import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/debug_log.dart';

/// Where decoded walkie-talkie audio goes to be heard.
///
/// A seam rather than a direct channel call so the radio controller can be
/// tested against a fake that records what it was given, and so the one place
/// that knows about the phone's audio session is behind a name.
abstract class RadioAudioSink {
  /// Opens the speaker for 48 kHz mono PCM16. [playInSilentMode] decides
  /// whether the ring/silent switch (and Android's media volume) can mute it.
  Future<void> start({required bool playInSilentMode});

  /// Plays [pcm] after whatever is already queued. Ignored before [start].
  Future<void> write(Int16List pcm);

  /// Lets the speaker go. Harmless when nothing is playing.
  Future<void> stop();
}

/// The phone's own audio output: `AudioTrack` on Android, `AVAudioEngine` on
/// iOS (`CubechatRadioAudioPlugin` on both).
///
/// Nothing here throws. A radio chunk is 300 ms of someone talking; a phone
/// that cannot play it has lost 300 ms, and the controller has nothing useful
/// to do about it. Platforms without the plugin (web, Windows, tests) answer
/// with [MissingPluginException] and land in the same place.
class PlatformRadioAudio implements RadioAudioSink {
  PlatformRadioAudio();

  static const channel = MethodChannel('cubechat/radio_audio');

  /// Opus here runs at 48 kHz (`OpusVoice`), so the player does too — no
  /// resampling on either platform.
  static const sampleRate = 48000;

  /// Dart's view of "is the native player open". Gating `write` and `stop`
  /// here costs nothing and keeps a late chunk, arriving after the channel
  /// went quiet, from crossing the platform channel at all.
  bool _open = false;

  @override
  Future<void> start({required bool playInSilentMode}) async {
    _open = true;
    await _invoke('start', <String, Object>{
      'sampleRate': sampleRate,
      'playInSilentMode': playInSilentMode,
    });
  }

  @override
  Future<void> write(Int16List pcm) async {
    if (!_open || pcm.isEmpty) return;
    // Explicitly little-endian, not a view of Int16List's buffer: that buffer
    // is host-endian, which is little on every target we ship, but the native
    // side reads little-endian and the contract should say so in code.
    final bytes = ByteData(pcm.length * 2);
    for (var i = 0; i < pcm.length; i++) {
      bytes.setInt16(i * 2, pcm[i], Endian.little);
    }
    await _invoke('write', bytes.buffer.asUint8List());
  }

  @override
  Future<void> stop() async {
    if (!_open) return;
    _open = false;
    await _invoke('stop');
  }

  Future<void> _invoke(String method, [Object? arguments]) async {
    try {
      await channel.invokeMethod<void>(method, arguments);
    } on PlatformException catch (e) {
      DebugLog.instance.log('RADIO', 'audio $method failed: ${e.code}');
    } on MissingPluginException {
      // No native player on this platform; silence is the honest answer.
    }
  }
}

final radioAudioProvider = Provider<RadioAudioSink>((_) => PlatformRadioAudio());
