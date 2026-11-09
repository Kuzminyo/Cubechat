import 'dart:async';
import 'dart:io';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../core/util/debug_log.dart';
import 'call_candidate_wait.dart';
import '../domain/call_network_quality.dart';

/// `video`: the pictures changed — a camera opened or closed, flipped, or the
/// other side's picture started or stopped arriving. Nothing about the call's
/// life; the screen redraws.
enum CallMediaEvent { connected, disconnected, failed, video }

/// Whether an SDP carries a picture both ways: an `m=video` line whose port
/// is not 0 (0 is a refused line) and that does not limit itself to one
/// direction.
///
/// Every call from a build with video has one, voice calls included, with no
/// camera on it yet — so a camera can join at any moment of any call without
/// a second offer, which would need a new kind of call signal. An old build
/// has none in its offer, and answers ours `recvonly`: it would receive a
/// picture and never draw it, so neither side shows a camera button then.
/// See `docs/superpowers/specs/2026-11-02-video-calls-design.md`.
bool sdpCarriesVideo(String sdp) {
  final start = RegExp(r'^m=video (\d+)', multiLine: true).firstMatch(sdp);
  if (start == null || start.group(1) == '0') return false;
  final next = sdp.indexOf('\nm=', start.end);
  final section = sdp.substring(start.end, next < 0 ? sdp.length : next);
  return !RegExp(r'^a=(recvonly|sendonly|inactive)\b', multiLine: true)
      .hasMatch(section);
}

/// The session name (`s=`) of an offer placed as a video call. WebRTC carries
/// the line and never reads it — `-` is what it writes itself — and an old
/// build ignores it the same way, so it costs no byte of protocol. It is how
/// the phone being called knows to say "video call" and answer with its
/// camera on; a voice call has the same picture line, without the name.
const String _videoSessionName = 'cubechat-video';

bool sdpStartsWithCamera(String sdp) =>
    RegExp('^s=$_videoSessionName\\r?\$', multiLine: true).hasMatch(sdp);

String markStartsWithCamera(String sdp) => sdp.replaceFirst(
      RegExp(r'^s=[^\r\n]*', multiLine: true),
      's=$_videoSessionName',
    );

/// The system would not give the call a microphone. Thrown by [CallMedia]
/// while it prepares, so the call ends as `microphone` and says so.
class CallMicrophoneUnavailable implements Exception {
  const CallMicrophoneUnavailable(this.reason);
  final String reason;
  @override
  String toString() => 'CallMicrophoneUnavailable($reason)';
}

/// Where a call's sound comes out.
enum CallAudioRouteKind { earpiece, speaker, bluetooth, wired }

/// One place the sound can go, as the platform names it.
class CallAudioRoute {
  const CallAudioRoute({
    required this.id,
    required this.label,
    required this.kind,
  });

  /// What the platform wants back to select it.
  final String id;

  /// The device's own name - "Pixel Buds", "AirPods Pro" - when it has one.
  final String label;
  final CallAudioRouteKind kind;
}

abstract interface class CallMedia {
  Stream<CallMediaEvent> get events;

  /// Every offer has a picture line; [video] marks it as placed as a video
  /// call ([markStartsWithCamera]). The answer needs no such flag: what it
  /// can do is read from the offer it answers.
  Future<String> offer(
    Map<String, dynamic> configuration, {
    bool video = false,
  });
  Future<String> answer(Map<String, dynamic> configuration, String remoteSdp);

  /// Whether both sides can show a picture: known once there is an answer.
  bool get videoPossible;

  /// The camera on or off, at any point in a call. Before the connection
  /// exists the choice is kept and applied as it opens. Returns whether it is
  /// on now: a camera that will not open leaves the call going without it.
  Future<bool> setCamera(bool on);

  /// Front to back and back again.
  Future<void> switchCamera();

  /// Whether a camera is actually capturing — not merely wanted.
  bool get cameraOpen;
  bool get frontCamera;

  /// Our own camera, for the preview. Null while it is off.
  MediaStream? get localVideo;

  /// Their picture, while frames are arriving. Null when their camera is off,
  /// their app is in the background, or they are on a build without video.
  MediaStream? get remoteVideo;
  Future<void> accept(String remoteSdp);
  Future<void> setMuted(bool muted);
  Future<void> setSpeaker(bool speaker);

  /// Every place the sound can go right now: the earpiece, the loudspeaker, a
  /// wired headset, a Bluetooth one.
  Future<List<CallAudioRoute>> routes();

  Future<void> selectRoute(CallAudioRoute route);
  Future<void> close();

  /// The signal bars: 0 while nothing has been measured, then 2 to 4.
  int get linkBars;
}

class WebRtcCallMedia implements CallMedia {
  final _events = StreamController<CallMediaEvent>.broadcast();

  /// Muted before there was a microphone to mute - the person being called
  /// pressed it while the call still rang. Applied to the track as it opens.
  bool _muted = false;
  RTCPeerConnection? _peer;
  MediaStream? _local;
  Future<String>? _opening;
  Future<void>? _closing;
  bool _closed = false;
  final _quality = CallNetworkQuality();
  Timer? _qualityTimer;
  Future<void>? _qualityWork;
  int? _appliedBitrate;
  int _qualityTicks = 0;
  bool _qualityErrorLogged = false;
  final Map<String, num> _remoteReports = {};
  final _gathered = Completer<void>();
  final _relayReady = Completer<void>();

  /// What a video call's encoder may spend, in bits per second. Every byte of
  /// it crosses our TURN server on the way in and again on the way out: at
  /// 800 kbit/s an hour of talking is about 360 MB each way through the
  /// droplet. WebRTC adapts below this on a poor link; the cap is what keeps
  /// a good one from spending two or three times as much on a picture a
  /// phone screen does not show the difference of.
  ///
  /// **Under coturn's own ceiling, not merely near it.** The server allows
  /// each session `max-bps=128000` bytes a second (`push/tool/
  /// configure_turn.py`), 1.02 Mbit/s. A picture at 1 Mbit/s — the first cap,
  /// 2026-11-02 — plus up to 32 kbit/s of voice plus SRTP, RTP and TURN
  /// headers is over it, and coturn drops what is over: a picture that
  /// stutters at exactly the quality it was meant to look best at. 800 leaves
  /// a fifth for the rest. Raise both together, and the server's
  /// `bps-capacity` with them — that is a decision about the bill.
  static const int videoMaxBitrate = 800000;
  static const int videoMaxFramerate = 30;

  /// The ceiling when the call is direct — the mode a person turns on
  /// knowingly, where no byte crosses our server. Nothing is billed there, so
  /// the only limit worth setting is the one past which a phone screen shows
  /// no difference; WebRTC's congestion control finds the link's own below it.
  static const int videoDirectMaxBitrate = 2500000;

  /// What the picture's sender is held to on each step of the link ladder
  /// ([CallNetworkQuality.bitrate], driven by the same audio feedback).
  ///
  /// "Better picture on a good connection, lower on a bad one" was the ask.
  /// WebRTC already backs off on its own when packets go missing, but late
  /// and by dropping frames, and it shares the link with the voice: stepping
  /// the picture down first — fewer pixels, fewer frames, a lower ceiling —
  /// keeps the voice whole on a poor link. Recovery is as slow as the
  /// audio's (eight healthy reports in a row), so it does not pump.
  static ({int bitrate, int fps, double scale}) videoLimits(
    int audioStep, {
    required bool relayed,
  }) {
    final ceiling = relayed ? videoMaxBitrate : videoDirectMaxBitrate;
    return switch (audioStep) {
      32000 => (bitrate: ceiling, fps: videoMaxFramerate, scale: 1.0),
      24000 => (bitrate: ceiling * 45 ~/ 100, fps: 24, scale: 1.5),
      _ => (bitrate: ceiling * 20 ~/ 100, fps: 15, scale: 2.0),
    };
  }

  /// Media must go through our TURN — the default. False only in direct mode.
  bool _relayed = true;

  /// Placed as a video call — the audio mode, nothing else.
  bool _video = false;

  /// The other side's SDP carries a picture both ways ([sdpCarriesVideo]).
  bool _peerVideo = false;
  bool _cameraWanted = false;
  bool _front = true;
  bool _speakerWanted = false;
  MediaStream? _camera;
  MediaStream? _remote;
  RTCRtpTransceiver? _videoTransceiver;
  /// Camera work still running, or null when there is none — the way
  /// [_qualityWork] is kept, so [close] waits only for work that exists and
  /// never on a finished future from another zone.
  Future<void>? _cameraWork;
  Timer? _videoTimer;
  Future<void>? _videoWork;

  /// The last loss and round trip the other side reported. Feedback lands
  /// less often than the poll, so a line about this poll alone said "unknown"
  /// without telling whether any had ever come (all seven lines of the
  /// 2026-11-09 log).
  double? _lastLoss;
  double? _lastRtt;
  num? _framesSeen;

  /// Seconds without a new frame before their picture counts as gone. It was
  /// 2, and going means their face replaced by the avatar and the renderer
  /// thrown away: a 20-second call on 2026-11-09 flipped three times, each
  /// flip with a black start after it. A last frame held still is what every
  /// video call shows for a hiccup; a camera really turned off only takes
  /// three seconds longer to say so.
  static const int _picturePatience = 5;
  int _stillPolls = 0;
  bool _remoteLive = false;
  /// The ladder step ([CallNetworkQuality.bitrate]) the picture's sender was
  /// last limited for; null until it has been.
  int? _videoCappedFor;
  bool _videoErrorLogged = false;

  @override
  int get linkBars => _quality.bars;

  @override
  Stream<CallMediaEvent> get events => _events.stream;

  @override
  Future<String> offer(
    Map<String, dynamic> configuration, {
    bool video = false,
  }) {
    _video = video;
    return _opening = _open(configuration, null)
        .then((sdp) => video ? markStartsWithCamera(sdp) : sdp);
  }

  @override
  Future<String> answer(Map<String, dynamic> configuration, String remoteSdp) {
    _video = sdpStartsWithCamera(remoteSdp);
    _peerVideo = sdpCarriesVideo(remoteSdp);
    return _opening = _open(configuration, remoteSdp);
  }

  @override
  bool get videoPossible => _videoTransceiver != null && _peerVideo;

  @override
  bool get cameraOpen => _camera != null;

  @override
  bool get frontCamera => _front;

  @override
  MediaStream? get localVideo => _camera;

  @override
  MediaStream? get remoteVideo => _remoteLive ? _remote : null;

  void _emit(CallMediaEvent event) {
    if (!_closed) _events.add(event);
  }

  void _checkOpen() {
    if (_closed) throw StateError('call closed');
  }

  static void _log(String line) => DebugLog.instance.log('CALL', line);

  Future<String> _open(
      Map<String, dynamic> configuration, String? remote) async {
    _checkOpen();
    _relayed = configuration['iceTransportPolicy'] == 'relay';
    final watch = Stopwatch()..start();
    // Gathered once, said out loud rather than left to the platform default.
    // Nothing trickles candidates here — the whole SDP goes in one frame — so
    // this waits for gathering to finish, and a policy that gathers
    // continually never finishes: the offer would time out every time, before
    // an invite ever left. Android's default happens to be once today; the
    // design should not rest on a default nobody chose.
    final config = <String, dynamic>{
      ...configuration,
      'continualGatheringPolicy': 'gather_once',
    };
    final peer = _peer = await createPeerConnection(config);
    _checkOpen();
    peer.onIceCandidate = (candidate) {
      // Both test phones timed out at 12 s waiting for every network
      // interface. A usable relay route is sufficient for a complete SDP
      // snapshot; dead interfaces must not hold back a working route.
      if (candidate.candidate?.contains(' typ relay') ?? false) {
        _log('usable relay candidate (${watch.elapsedMilliseconds} ms)');
        if (!_relayReady.isCompleted) _relayReady.complete();
      }
    };
    peer.onIceGatheringState = (state) {
      _log('gathering ${state.name} (${watch.elapsedMilliseconds} ms)');
      if (state == RTCIceGatheringState.RTCIceGatheringStateComplete &&
          !_gathered.isCompleted) {
        _gathered.complete();
      }
    };
    peer.onIceConnectionState =
        (state) => _log('ice ${state.name} (${watch.elapsedMilliseconds} ms)');
    peer.onConnectionState = (state) {
      _log('connection ${state.name} (${watch.elapsedMilliseconds} ms)');
      if (_closed) return;
      switch (state) {
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          _startQualityMonitor();
          _startVideoMonitor();
          _events.add(CallMediaEvent.connected);
        case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
          _events.add(CallMediaEvent.disconnected);
        case RTCPeerConnectionState.RTCPeerConnectionStateFailed:
          _events.add(CallMediaEvent.failed);
        default:
          break;
      }
    };
    // Their picture. Drawn from its stream, which both sides make sure it has
    // (see `setStreams` below): the renderer draws a stream, not a track.
    peer.onTrack = (event) {
      if (_closed || event.track.kind != 'video') return;
      if (event.streams.isEmpty) {
        _log('their picture arrived without a stream: not drawn');
        return;
      }
      _remote = event.streams.first;
      _log('their picture track arrived (${watch.elapsedMilliseconds} ms)');
      _emit(CallMediaEvent.video);
    };
    // Configure communication before capture activates the native audio
    // session. Bluetooth must open as a bidirectional voice route.
    if (Platform.isAndroid) {
      await Helper.setAndroidAudioConfiguration(
        AndroidAudioConfiguration.communication,
      );
    } else if (Platform.isIOS) {
      await _configureAppleAudio();
    }
    _checkOpen();
    final MediaStream local;
    try {
      local = _local = await navigator.mediaDevices.getUserMedia({
      'audio': {
        // flutter_webrtc 0.12's native parser ignores top-level browser
        // constraints. Supply its optional list so AGC/NS/AEC actually reach
        // the audio source, including a quiet Bluetooth headset microphone.
        'optional': [
          {'googEchoCancellation': true},
          {'googNoiseSuppression': true},
          {'googAutoGainControl': true},
        ],
      },
      'video': false,
    });
    } catch (e) {
      // Windows asks nothing, but its "let desktop apps use the microphone"
      // switch can be off, and capture then fails here — a microphone
      // problem, which the call screen names, not a call that failed.
      throw CallMicrophoneUnavailable('$e');
    }
    if (local.getAudioTracks().isEmpty) {
      throw const CallMicrophoneUnavailable('no audio track');
    }
    _checkOpen();
    if (_muted) {
      for (final track in local.getAudioTracks()) {
        await Helper.setMicrophoneMute(true, track);
      }
    }
    // The route asked for before the microphone opened — off for a voice
    // call, on for a video one — rather than always off, which undid a
    // speaker chosen while the call was still being placed.
    await setSpeaker(_speakerWanted);
    for (final track in local.getAudioTracks()) {
      await peer.addTrack(track, local);
      _checkOpen();
    }
    // The picture is negotiated once, `sendrecv` from the start — in every
    // call, voice ones too — and the camera then comes and goes by swapping
    // the sender's track. Turning it on, in a call placed as voice or as
    // video, never needs a second offer, which would need a new kind of call
    // signal and teach every installed build about it. A line with no track
    // on it sends nothing.
    if (remote == null) {
      _videoTransceiver = await peer.addTransceiver(
        kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
        init: RTCRtpTransceiverInit(
          direction: TransceiverDirection.SendRecv,
          streams: [local],
        ),
      );
      _checkOpen();
    }
    if (remote != null)
      await peer.setRemoteDescription(RTCSessionDescription(remote, 'offer'));
    _checkOpen();
    if (remote != null && _peerVideo) {
      // The offer's picture made a transceiver of its own here, `recvonly`
      // and with no stream. Made to send as well, and given the audio's
      // stream, so the caller's renderer has something to draw.
      final transceivers = await peer.getTransceivers();
      _checkOpen();
      final video = transceivers
          .where((t) => t.receiver.track?.kind == 'video')
          .firstOrNull;
      if (video == null) {
        _log('the offer has a picture but no video transceiver came of it');
      } else {
        await video.setDirection(TransceiverDirection.SendRecv);
        await video.sender.setStreams([local]);
        _videoTransceiver = video;
      }
      _checkOpen();
    }
    // In the same queue as the camera button, which can be pressed from the
    // moment the transceiver exists: two opens at once would capture twice.
    await _inCameraQueue(
      () => _cameraWanted ? _openCamera() : Future.value(false),
    );
    _checkOpen();
    final description =
        remote == null ? await peer.createOffer() : await peer.createAnswer();
    await peer.setLocalDescription(description);
    _log('microphone open, local description set '
        '(${watch.elapsedMilliseconds} ms)');
    // The wire carries a complete SDP, without candidate trickling. Never
    // invite a peer with an offer which cannot reach our required TURN relay.
    try {
      await waitForCallCandidates(
        gathered: _gathered.future,
        relayReady: _relayReady.future,
      );
    } on TimeoutException {
      // Named, because this is the failure that ends a call before anybody is
      // rung, and "TimeoutException after 0:00:12" says nothing about which
      // wait it was.
      throw StateError('candidate gathering did not finish in 12 s');
    }
    _checkOpen();
    final sdp = (await peer.getLocalDescription())?.sdp;
    if (sdp == null || !sdp.contains('a=candidate:')) {
      throw StateError('gathering finished with no candidates at all — '
          'the relay did not answer');
    }
    if (configuration['iceTransportPolicy'] == 'relay' &&
        !sdp.contains(' typ relay')) {
      throw StateError('gathering finished with no relay candidate — the '
          'relay refused this phone\'s credentials or could not be reached');
    }
    return sdp;
  }

  @override
  Future<void> accept(String remoteSdp) async {
    _checkOpen();
    await _peer!
        .setRemoteDescription(RTCSessionDescription(remoteSdp, 'answer'));
    _peerVideo = sdpCarriesVideo(remoteSdp);
    _log('answer applied, ${_peerVideo ? 'picture both ways' : 'voice only'}');
    _emit(CallMediaEvent.video);
  }

  @override
  Future<void> setMuted(bool muted) async {
    _checkOpen();
    _muted = muted;
    for (final track in _local?.getAudioTracks() ?? <MediaStreamTrack>[]) {
      await Helper.setMicrophoneMute(muted, track);
    }
  }

  /// On or off, and actually applied either way.
  ///
  /// **"Speaker on and normal sound exactly the same" was the report, and on
  /// Android it was true.** flutter_webrtc's audio switch ranks the loudspeaker
  /// above the earpiece in its default preference list, so every call started
  /// on the loudspeaker while the button said it was off - pressing it turned
  /// on what was already on. Nothing ever asked for the earpiece. The call now
  /// states its route when the microphone opens and again when media connects,
  /// so the button and the sound agree from the first second. Off still
  /// prefers a headset over the earpiece when one is connected.
  @override
  Future<void> setSpeaker(bool speaker) async {
    _checkOpen();
    _speakerWanted = speaker;
    if (Platform.isIOS) {
      // The plugin's setSpeakerphoneOn helper re-enables A2DP. Keep the
      // bidirectional HFP voice category and change only the output override.
      await _configureAppleAudio();
      if (!_closed)
        await Helper.selectAudioOutput(speaker ? 'Speaker' : 'none');
    } else {
      await Helper.setSpeakerphoneOn(speaker);
    }
  }

  // `.videoChat` for a picture: the same echo cancelling, tuned for a phone
  // held at arm's length on the loudspeaker rather than at an ear.
  Future<void> _configureAppleAudio() =>
      Helper.setAppleAudioConfiguration(AppleAudioConfiguration(
        appleAudioCategory: AppleAudioCategory.playAndRecord,
        appleAudioMode:
            _video ? AppleAudioMode.videoChat : AppleAudioMode.voiceChat,
        appleAudioCategoryOptions: {AppleAudioCategoryOption.allowBluetooth},
      ));

  void _startQualityMonitor() {
    if (_qualityTimer != null || _closed) return;
    void poll() {
      if (_closed || _qualityWork != null) return;
      _qualityWork = _sampleQuality().whenComplete(() => _qualityWork = null);
    }

    _qualityTimer = Timer.periodic(const Duration(seconds: 3), (_) => poll());
    poll();
  }

  Future<void> _sampleQuality() async {
    final peer = _peer;
    if (_closed || peer == null) return;
    try {
      final reports = await peer.getStats().timeout(const Duration(seconds: 2));
      if (_closed) return;
      var freshReport = false;
      double? loss;
      double? rtt;
      for (final report in reports) {
        final values = report.values;
        // Remote inbound describes how the OTHER phone receives OUR audio.
        // Local inbound loss is the opposite direction and cannot be fixed by
        // reducing our encoder's bandwidth.
        if (report.type != 'remote-inbound-rtp' ||
            (values['kind'] ?? values['mediaType']) != 'audio') continue;
        final counter =
            values['reportsReceived'] ?? values['roundTripTimeMeasurements'];
        final marker = counter is num ? counter : report.timestamp;
        if (_remoteReports[report.id] == marker) continue;
        _remoteReports[report.id] = marker;
        freshReport = true;
        final fraction = values['fractionLost'];
        final roundTrip = values['roundTripTime'];
        if (fraction is num) loss = fraction.toDouble();
        if (roundTrip is num) rtt = roundTrip.toDouble();
      }
      // RTCP often arrives less frequently than getStats is polled. Count
      // actual feedback, not polling gaps, toward sustained recovery.
      if (freshReport) _quality.sample(loss: loss, rtt: rtt);
      _lastLoss = loss ?? _lastLoss;
      _lastRtt = rtt ?? _lastRtt;
      final target = _quality.bitrate;
      final changed = _appliedBitrate != target;
      if (changed) {
        // Fetch fresh parameters: a cached addTrack sender can precede SDP
        // negotiation and have no negotiated encodings yet.
        final senders =
            await peer.getSenders().timeout(const Duration(seconds: 2));
        if (_closed) return;
        var applied = false;
        for (final sender in senders) {
          if (sender.track?.kind != 'audio') continue;
          final parameters = sender.parameters;
          final encodings = parameters.encodings;
          if (encodings == null || encodings.isEmpty) continue;
          for (final encoding in encodings) {
            encoding.maxBitrate = target;
          }
          if (!await sender
              .setParameters(parameters)
              .timeout(const Duration(seconds: 2))) {
            throw StateError('audio sender refused bitrate');
          }
          if (_closed) return;
          applied = true;
        }
        if (applied) _appliedBitrate = target;
      }
      // One line every 15 seconds, plus real policy changes. Never log SDP,
      // addresses or captured speech; just the measurements needed to debug.
      if (++_qualityTicks % 5 == 0 || changed && _appliedBitrate == target) {
        _log('audio quality: cap ${_appliedBitrate ?? 0} bps, '
            'loss ${_lastLoss == null ? "unknown" : (_lastLoss! * 100).toStringAsFixed(1)}%, '
            'rtt ${_lastRtt == null ? "unknown" : (_lastRtt! * 1000).round()} ms'
            '${freshReport ? '' : ' (no new report)'}');
      }
      _qualityErrorLogged = false;
    } catch (e) {
      if (!_closed && !_qualityErrorLogged) {
        _log('audio quality update unavailable: $e');
        _qualityErrorLogged = true;
      }
      // A platform that cannot set a cap retains WebRTC's own congestion
      // control. Monitoring must never tear down an otherwise usable call.
    }
  }

  @override
  Future<bool> setCamera(bool on) {
    _cameraWanted = on;
    // Before there is a transceiver to put it on: kept, and [_open] applies
    // it. Answered with the wish, which the controller checks against
    // [cameraOpen] once the call is up.
    if (_videoTransceiver == null || _closed) {
      return Future.value(on && !_closed);
    }
    return _inCameraQueue(() async {
      if (on) return _openCamera();
      await _closeCamera();
      return false;
    });
  }

  @override
  Future<void> switchCamera() => _inCameraQueue(() async {
        final track = _camera?.getVideoTracks().firstOrNull;
        if (_closed) return false;
        if (track == null) {
          // Off: the next time it opens, it opens on the other side.
          _front = !_front;
          _emit(CallMediaEvent.video);
          return false;
        }
        try {
          await Helper.switchCamera(track);
          _front = !_front;
          _log('camera flipped to the ${_front ? 'front' : 'back'}');
          _emit(CallMediaEvent.video);
        } catch (e) {
          _log('camera would not flip: $e');
        }
        return true;
      });

  /// One camera step at a time — opening, closing, flipping — behind any
  /// still running, so two presses cannot capture twice. [_cameraWork] goes
  /// back to null when the queue is empty.
  Future<bool> _inCameraQueue(Future<bool> Function() step) {
    final previous = _cameraWork;
    final result = previous == null ? step() : previous.then((_) => step());
    late final Future<void> settled;
    settled = result.then<void>((_) {}, onError: (Object _) {}).whenComplete(
      () {
        if (identical(_cameraWork, settled)) _cameraWork = null;
      },
    );
    _cameraWork = settled;
    return result;
  }

  /// Capture the camera and put it on the picture's sender. A camera that
  /// will not open — refused, busy with another app, none on this computer —
  /// is logged and the call goes on without a picture from this side: a
  /// camera is never a reason to end a call.
  Future<bool> _openCamera() async {
    final transceiver = _videoTransceiver;
    if (transceiver == null || _closed) return false;
    if (_camera != null) return true;
    MediaStream? camera;
    try {
      camera = await navigator.mediaDevices.getUserMedia({
        'audio': false,
        'video': {
          'facingMode': _front ? 'user' : 'environment',
          // 720p at 30: what a phone screen can show of somebody's face. The
          // encoder is capped separately — [videoMaxBitrate].
          'mandatory': {
            'minWidth': '1280',
            'minHeight': '720',
            'minFrameRate': '$videoMaxFramerate',
          },
          'optional': <Object>[],
        },
      });
      final track = camera.getVideoTracks().firstOrNull;
      if (track == null) throw StateError('no video track');
      if (_closed) throw StateError('call closed');
      await transceiver.sender.replaceTrack(track);
      _camera = camera;
      _log('camera on (${_front ? 'front' : 'back'})');
      _emit(CallMediaEvent.video);
      return true;
    } catch (e) {
      _log('camera would not open: $e');
      await _dispose(camera);
      return false;
    }
  }

  Future<void> _closeCamera() async {
    final camera = _camera;
    _camera = null;
    if (camera == null) return;
    try {
      await _videoTransceiver?.sender.replaceTrack(null);
    } catch (e) {
      _log('camera track would not come off the sender: $e');
    }
    await _dispose(camera);
    _log('camera off');
    _emit(CallMediaEvent.video);
  }

  static Future<void> _dispose(MediaStream? stream) async {
    if (stream == null) return;
    try {
      for (final track in stream.getTracks()) {
        await track.stop();
      }
      await stream.dispose();
    } catch (_) {/* Already gone with the call. */}
  }

  /// Whether their picture is arriving, asked of the decoder once a second.
  ///
  /// There is no message for "my camera is off" — see the design note — and
  /// there need not be: a sender whose track is gone sends nothing, and a
  /// count of decoded frames that stops moving says so. The same count also
  /// catches an iPhone whose app went to the background, where iOS stops the
  /// camera, and a link that froze. [_picturePatience] still seconds before
  /// it counts as stopped.
  void _startVideoMonitor() {
    if (_videoTransceiver == null || _videoTimer != null || _closed) return;
    void poll() {
      if (_closed || _videoWork != null) return;
      _videoWork = _sampleVideo().whenComplete(() => _videoWork = null);
    }

    _videoTimer = Timer.periodic(const Duration(seconds: 1), (_) => poll());
    poll();
  }

  Future<void> _sampleVideo() async {
    final peer = _peer;
    // A call with somebody on a build without video asks nothing, every
    // second, for a picture that cannot come.
    if (_closed || peer == null || !videoPossible) return;
    try {
      final reports = await peer.getStats().timeout(const Duration(seconds: 2));
      if (_closed) return;
      num? frames;
      Map<dynamic, dynamic>? inbound;
      for (final report in reports) {
        final values = report.values;
        if (report.type != 'inbound-rtp' ||
            (values['kind'] ?? values['mediaType']) != 'video') {
          continue;
        }
        inbound = values;
        final decoded = values['framesDecoded'];
        if (decoded is num) frames = (frames ?? 0) + decoded;
      }
      final moved = frames != null && frames > (_framesSeen ?? 0);
      if (frames != null) _framesSeen = frames;
      if (moved) {
        _stillPolls = 0;
      } else {
        _stillPolls++;
      }
      final live = moved || (_remoteLive && _stillPolls < _picturePatience);
      if (live != _remoteLive) {
        _remoteLive = live;
        // Counters only, so the next report of a freeze says whether it was
        // the network (lost, nack) or the decoder (dropped, decoder).
        final why = !live && inbound != null
            ? ' (received ${inbound['framesReceived']}, '
                'dropped ${inbound['framesDropped']}, '
                'lost ${inbound['packetsLost']}, '
                'nack ${inbound['nackCount']}, '
                'pli ${inbound['pliCount']}, '
                'freezes ${inbound['freezeCount']}, '
                'decoder ${inbound['decoderImplementation']})'
            : '';
        _log('their picture ${live ? 'started' : 'stopped'}$why');
        _emit(CallMediaEvent.video);
      }
      if (_videoCappedFor != _quality.bitrate) await _capVideo(peer);
      _videoErrorLogged = false;
    } catch (e) {
      if (!_closed && !_videoErrorLogged) {
        _log('picture check unavailable: $e');
        _videoErrorLogged = true;
      }
    }
  }

  /// [videoLimits] for the link as it is now onto the picture's sender, once
  /// its encodings exist — they do not before negotiation, so this is retried
  /// from the once-a-second check until it takes, and again whenever the
  /// link moves a step.
  Future<void> _capVideo(RTCPeerConnection peer) async {
    final wanted = _videoTransceiver?.sender.senderId;
    if (wanted == null) return;
    final step = _quality.bitrate;
    final limits = videoLimits(step, relayed: _relayed);
    final senders = await peer.getSenders().timeout(const Duration(seconds: 2));
    if (_closed) return;
    for (final sender in senders) {
      if (sender.senderId != wanted) continue;
      final parameters = sender.parameters;
      final encodings = parameters.encodings;
      if (encodings == null || encodings.isEmpty) return;
      for (final encoding in encodings) {
        encoding.maxBitrate = limits.bitrate;
        encoding.maxFramerate = limits.fps;
        encoding.scaleResolutionDownBy = limits.scale;
      }
      if (await sender
          .setParameters(parameters)
          .timeout(const Duration(seconds: 2))) {
        _videoCappedFor = step;
        _log('picture capped at ${limits.bitrate} bps, ${limits.fps} fps, '
            '1/${limits.scale} size (${_relayed ? 'relayed' : 'direct'})');
      }
      return;
    }
  }

  @override
  Future<List<CallAudioRoute>> routes() async {
    try {
      final devices = await navigator.mediaDevices.enumerateDevices();
      if (Platform.isAndroid) return _androidRoutes(devices);
      if (Platform.isIOS) return _iosRoutes(devices);
    } catch (e) {
      _log('could not list audio routes: $e');
    }
    return const [];
  }

  /// Android names its outputs by kind: `earpiece`, `speaker`, `wired-headset`,
  /// `bluetooth` - and selecting one is selecting that name.
  static List<CallAudioRoute> _androidRoutes(List<MediaDeviceInfo> devices) {
    final routes = <CallAudioRoute>[];
    for (final device in devices.where((d) => d.kind == 'audiooutput')) {
      final kind = switch (device.deviceId) {
        'earpiece' => CallAudioRouteKind.earpiece,
        'speaker' => CallAudioRouteKind.speaker,
        'wired-headset' => CallAudioRouteKind.wired,
        'bluetooth' => CallAudioRouteKind.bluetooth,
        _ => null,
      };
      if (kind == null) continue;
      routes.add(CallAudioRoute(
        id: device.deviceId,
        label: device.label,
        kind: kind,
      ));
    }
    return routes;
  }

  /// iOS has no list of outputs to pick from, only inputs, and the output
  /// follows the input: choosing a headset's microphone routes the call to that
  /// headset. The loudspeaker is the one output that is chosen directly.
  static List<CallAudioRoute> _iosRoutes(List<MediaDeviceInfo> devices) {
    final routes = <CallAudioRoute>[];
    for (final device in devices.where((d) => d.kind == 'audioinput')) {
      final kind = switch (device.groupId) {
        'MicrophoneBuiltIn' => CallAudioRouteKind.earpiece,
        'BluetoothHFP' => CallAudioRouteKind.bluetooth,
        'HeadsetMic' || 'USBAudio' => CallAudioRouteKind.wired,
        _ => null,
      };
      if (kind == null) continue;
      routes.add(CallAudioRoute(
        id: device.deviceId,
        label: device.label,
        kind: kind,
      ));
    }
    routes.add(const CallAudioRoute(
      id: 'Speaker',
      label: 'Speaker',
      kind: CallAudioRouteKind.speaker,
    ));
    return routes;
  }

  @override
  Future<void> selectRoute(CallAudioRoute route) async {
    _checkOpen();
    if (Platform.isAndroid) {
      await Helper.selectAudioOutput(route.id);
      return;
    }
    if (route.kind == CallAudioRouteKind.speaker) {
      await Helper.selectAudioOutput('Speaker');
      return;
    }
    // Loudspeaker override off first, or the chosen headset stays silent
    // behind it.
    await Helper.selectAudioOutput('none');
    await Helper.selectAudioInput(route.id);
  }

  @override
  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    _qualityTimer?.cancel();
    _qualityTimer = null;
    _videoTimer?.cancel();
    _videoTimer = null;
    if (!_gathered.isCompleted) _gathered.complete();
    // Native camera/audio creation cannot be disposed underneath its pending
    // future. The controller prevents a new call until this teardown ends.
    try {
      await _opening;
    } catch (_) {/* Cancelled setup still needs cleanup. */}
    try {
      await _qualityWork;
      await _videoWork;
      try {
        await _cameraWork;
      } catch (_) {/* A camera that failed still needs closing. */}
      await _peer?.close();
      await _peer?.dispose();
    } finally {
      try {
        final camera = _camera;
        _camera = null;
        await _dispose(camera);
        for (final track in _local?.getTracks() ?? <MediaStreamTrack>[]) {
          await track.stop();
        }
        await _local?.dispose();
      } finally {
        _peer = null;
        _local = null;
        _remote = null;
        _videoTransceiver = null;
        await _events.close();
      }
    }
  }
}
