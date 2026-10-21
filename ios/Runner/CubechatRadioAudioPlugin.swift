import AVFoundation
import Flutter
import Foundation

/// Plays walkie-talkie audio as it arrives: PCM16 mono pushed into an
/// `AVAudioPlayerNode`. The Android half is `CubechatRadioAudioPlugin.kt`, and
/// `radio_audio.dart` is the Dart side of both.
///
/// Dart decodes the Opus chunks and hands over 300 ms of samples at a time. A
/// file player cannot take audio that has not finished arriving, so this is an
/// engine and a node that buffers are scheduled onto the moment they come in.
///
/// **A call owns the audio session, and this plugin never takes it back.**
/// While a call is up the session is `.playAndRecord` in `.voiceChat` mode
/// (rule 8 of the `calls` skill: that mode must never be undone). Changing the
/// category from here would drop the call's echo cancellation and its route,
/// so in that case this plays into the session as it is and touches nothing —
/// not on start, and not on stop. Dart says whether a call is up (`inCall` on
/// both methods, from the call controller's phase). This used to be guessed
/// from the session's category and mode, which is wrong both ways: anything
/// else in `.playAndRecord` / `.voiceChat` looked like a call, and a call
/// still ringing, before CallKit has set the session, did not.
///
/// Everything runs on one serial queue, and Flutter's replies go out on the
/// main thread.
final class CubechatRadioAudioPlugin: NSObject {
  private let channel: FlutterMethodChannel
  private let queue = DispatchQueue(label: "cubechat.radio_audio", qos: .userInteractive)

  // Queue-confined from here down.
  private var engine: AVAudioEngine?
  private var node: AVAudioPlayerNode?
  private var format: AVAudioFormat?
  private var configObserver: NSObjectProtocol?

  /// True only when *this plugin* turned the session on, so only then does stop
  /// turn it off. A session something else activated (a call, the voice-note
  /// player) is not ours to deactivate.
  private var activatedSession = false

  /// Frames handed to the node and not yet played. Radio chunks arrive at the
  /// rate they play, so this sits near one chunk; it only grows if the engine
  /// stops draining. Past `maxQueuedFrames` new audio is dropped — a
  /// walkie-talkie two seconds behind is no longer one, and the queue must not
  /// grow for as long as the other side keeps talking.
  private var queuedFrames = 0
  private static let maxQueuedFrames = 48_000 * 2

  /// Bumped on every teardown. A completion handler from a buffer scheduled
  /// before a stop must not subtract from the count of the next session.
  private var generation = 0

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(
      name: "cubechat/radio_audio",
      binaryMessenger: messenger
    )
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else {
        result(nil)
        return
      }
      self.handle(call, result)
    }
  }

  private func handle(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    switch call.method {
    case "start":
      let args = call.arguments as? [String: Any]
      let sampleRate = (args?["sampleRate"] as? NSNumber)?.doubleValue ?? 48_000
      let playInSilentMode = (args?["playInSilentMode"] as? Bool) ?? false
      let inCall = (args?["inCall"] as? Bool) ?? false
      queue.async {
        let error = self.start(
          sampleRate: sampleRate,
          playInSilentMode: playInSilentMode,
          inCall: inCall
        )
        DispatchQueue.main.async {
          if let error {
            result(FlutterError(code: "audio", message: error, details: nil))
          } else {
            result(nil)
          }
        }
      }
    case "write":
      // Answered at once: Dart does not wait for the speaker.
      result(nil)
      guard let data = (call.arguments as? FlutterStandardTypedData)?.data else { return }
      queue.async { self.write(data) }
    case "stop":
      let inCall = ((call.arguments as? [String: Any])?["inCall"] as? Bool) ?? false
      queue.async {
        self.teardown(inCall: inCall)
        DispatchQueue.main.async { result(nil) }
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// Returns an error message, or nil when the speaker is open.
  private func start(sampleRate: Double, playInSilentMode: Bool, inCall: Bool) -> String? {
    // "Start twice restarts cleanly": the first engine is gone before the
    // second is built.
    teardown(inCall: inCall)
    let session = AVAudioSession.sharedInstance()
    do {
      if !inCall {
        // `.playback` ignores the ring/silent switch; `.ambient` obeys it,
        // which is the point of the "talk in silent mode" toggle. `.playback`
        // ducks other audio under the voice (the Android side asks for
        // MAY_DUCK) and the matching deactivation in `teardown` hands it back;
        // `.ambient` mixes with everything already.
        if playInSilentMode {
          try session.setCategory(.playback, mode: .default, options: [.duckOthers])
        } else {
          try session.setCategory(.ambient, mode: .default, options: [])
        }
        try session.setActive(true)
        activatedSession = true
      }

      // Float32 is the format the engine's mixer is built around; Int16 would
      // work through an implicit conversion, but doing it here is one
      // multiplication per sample on 300 ms of audio and removes the doubt.
      guard
        let fmt = AVAudioFormat(
          commonFormat: .pcmFormatFloat32,
          sampleRate: sampleRate,
          channels: 1,
          interleaved: false
        )
      else {
        teardown(inCall: inCall)
        return "no audio format for \(sampleRate) Hz"
      }
      let engine = AVAudioEngine()
      let node = AVAudioPlayerNode()
      engine.attach(node)
      engine.connect(node, to: engine.mainMixerNode, format: fmt)
      engine.prepare()
      try engine.start()
      node.play()

      self.engine = engine
      self.node = node
      self.format = fmt
      // A route change (headphones pulled, Bluetooth connecting) stops the
      // engine and posts this; without a restart the radio would go quiet for
      // the rest of the session.
      configObserver = NotificationCenter.default.addObserver(
        forName: .AVAudioEngineConfigurationChange,
        object: engine,
        queue: nil
      ) { [weak self] _ in
        self?.queue.async { self?.restartAfterConfigurationChange() }
      }
      return nil
    } catch {
      teardown(inCall: inCall)
      return "\(error)"
    }
  }

  private func restartAfterConfigurationChange() {
    guard let engine, let node, !engine.isRunning else { return }
    do {
      try engine.start()
      node.play()
    } catch {
      // No word from Dart here, so an engine that will not restart is let go
      // as if no call were up. A call coming up is answered by the
      // controller's own stop, with `inCall`, within a tick (100 ms); only a
      // restart that fails inside that tick hands the session back early.
      teardown(inCall: false)
    }
  }

  private func write(_ data: Data) {
    guard let engine, engine.isRunning, let node, let format else { return }
    let frames = data.count / 2  // a trailing odd byte is half a sample
    guard frames > 0, queuedFrames + frames <= CubechatRadioAudioPlugin.maxQueuedFrames else {
      return
    }
    guard
      let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(frames)),
      let out = buffer.floatChannelData?[0]
    else {
      return
    }
    buffer.frameLength = AVAudioFrameCount(frames)
    // Little-endian PCM16 read byte by byte, so it is right whatever the
    // alignment of the Data's storage or the endianness of the CPU.
    data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
      for i in 0..<frames {
        let lo = UInt16(raw[2 * i])
        let hi = UInt16(raw[2 * i + 1])
        out[i] = Float(Int16(bitPattern: lo | (hi << 8))) / 32_768
      }
    }
    queuedFrames += frames
    let gen = generation
    node.scheduleBuffer(buffer) { [weak self] in
      self?.queue.async {
        guard let self, self.generation == gen else { return }
        self.queuedFrames -= frames
      }
    }
  }

  /// Stops playback and, if this plugin turned the session on and no call has
  /// taken it since ([inCall], from Dart), turns it off and tells other apps
  /// they can resume.
  private func teardown(inCall: Bool) {
    generation += 1
    queuedFrames = 0
    if let observer = configObserver {
      NotificationCenter.default.removeObserver(observer)
      configObserver = nil
    }
    node?.stop()
    engine?.stop()
    node = nil
    engine = nil
    format = nil
    if activatedSession {
      activatedSession = false
      // A call that started while we were playing now owns the session;
      // deactivating it would end the call's audio.
      if !inCall {
        // Throws when something else is still using the session; then it is
        // not ours to turn off anyway.
        try? AVAudioSession.sharedInstance().setActive(
          false,
          options: .notifyOthersOnDeactivation
        )
      }
    }
  }
}
