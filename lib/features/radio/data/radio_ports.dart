import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:record/record.dart';

import '../../../core/audio/opus_codec.dart';
import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';
import '../../../core/transport/messaging_service.dart';
import '../../../core/transport/radio_chunk.dart';
import '../../../core/util/audio_session.dart';
import '../../../core/util/debug_log.dart';
import '../../call/data/call_controller.dart';
import '../../call/domain/call_state_machine.dart';
import '../models/radio_channel.dart';

// Everything the radio controller touches outside its own logic, each behind a
// provider: the transport, the microphone, libopus, the disk, the clock and
// the call state. The controller is timing logic above all, and every one of
// these would otherwise need a phone (or a native library) to test it.

/// Where a chunk goes. Both return how many Bluetooth links it went out on;
/// 0 means nobody was in reach and nothing was kept.
abstract class RadioSender {
  Future<int> toContact(String canonicalId, RadioChunk chunk);
  Future<int> toGroup(Uint8List key, Uint8List tag, RadioChunk chunk);
}

class MessagingRadioSender implements RadioSender {
  MessagingRadioSender(this._ref);

  final Ref _ref;

  // Read per call, not when this is made: the radio controller is built when
  // the screen first asks for it, and that is no reason to build the whole
  // transport in a test that never sends.
  @override
  Future<int> toContact(String canonicalId, RadioChunk chunk) => _ref
      .read(messagingServiceProvider)
      .sendRadioToContact(canonicalId, chunk);

  @override
  Future<int> toGroup(Uint8List key, Uint8List tag, RadioChunk chunk) =>
      _ref.read(messagingServiceProvider).sendRadioToGroup(key, tag, chunk);
}

final radioSenderProvider =
    Provider<RadioSender>((ref) => MessagingRadioSender(ref));

/// PCM16 little-endian, mono, 48 kHz, in whatever pieces the platform likes.
abstract class RadioMicrophone {
  /// The microphone's stream, or null when it may not or cannot be used -
  /// permission refused, or the hardware would not open.
  Future<Stream<Uint8List>?> open();

  /// Lets the microphone go. Harmless when it is not open.
  Future<void> close();
}

/// The `record` plugin, the same way the voice-note recorder uses it: ask
/// `hasPermission` (which shows the system prompt the first time), then
/// `startStream` with [AudioSession.voiceStream] - 48 kHz mono PCM16 with the
/// platform's processing off, the format Opus is fed.
class RecordRadioMicrophone implements RadioMicrophone {
  /// Made on first use, as `VoiceRecorderController` does: opening the radio
  /// screen is no reason to wake the microphone plugin.
  AudioRecorder? _made;
  AudioRecorder get _recorder => _made ??= AudioRecorder();

  @override
  Future<Stream<Uint8List>?> open() async {
    try {
      if (!await _recorder.hasPermission()) return null;
      return await _recorder.startStream(AudioSession.voiceStream);
    } catch (e) {
      DebugLog.instance.log('RADIO', 'microphone would not open: $e');
      return null;
    }
  }

  @override
  Future<void> close() async {
    final recorder = _made;
    if (recorder == null) return;
    try {
      await recorder.stop();
    } catch (e) {
      debugPrint('radio microphone stop failed: $e');
    }
  }

  void dispose() => _made?.dispose();
}

final radioMicrophoneProvider = Provider<RadioMicrophone>((ref) {
  final mic = RecordRadioMicrophone();
  ref.onDispose(mic.dispose);
  return mic;
});

abstract class RadioEncoder {
  /// One 960-sample frame in, one Opus packet out.
  Uint8List encode(Int16List frame);
  void dispose();
}

abstract class RadioDecoder {
  /// One Opus packet in, its samples out (960 for every packet we send).
  Int16List decode(Uint8List packet);
  void dispose();
}

/// Makes the codec state for one press or one heard transmission. Both throw
/// when there is no libopus (the web build).
abstract class RadioCodec {
  RadioEncoder encoder();
  RadioDecoder decoder();
}

class OpusRadioCodec implements RadioCodec {
  const OpusRadioCodec();

  /// A quarter of a voice note's 32 kbit/s: a 20 ms frame is about 20 bytes,
  /// so a 300 ms chunk is a few hundred bytes - one BLE write after
  /// fragmentation - and three of them a second share the link with
  /// everybody's text. Speech at 8 kbit/s is narrowband but clear.
  static const int bitRate = 8000;

  /// Hard CBR, not the voice note's VBR: a chunk's length must not say when
  /// somebody is speaking and when they paused, to anyone on the air counting
  /// bytes - the README pads text for the same reason.
  @override
  RadioEncoder encoder() =>
      _OpusEncoder(OpusVoiceEncoder(bitRate: bitRate, vbr: false));

  @override
  RadioDecoder decoder() => _OpusDecoder(OpusVoiceDecoder());
}

class _OpusEncoder implements RadioEncoder {
  _OpusEncoder(this._inner);
  final OpusVoiceEncoder _inner;
  @override
  Uint8List encode(Int16List frame) => _inner.encode(frame);
  @override
  void dispose() => _inner.dispose();
}

class _OpusDecoder implements RadioDecoder {
  _OpusDecoder(this._inner);
  final OpusVoiceDecoder _inner;
  @override
  Int16List decode(Uint8List packet) => _inner.decode(packet);
  @override
  void dispose() => _inner.dispose();
}

final radioCodecProvider = Provider<RadioCodec>((_) => const OpusRadioCodec());

/// A joined group as it is kept: what the screen shows, plus the key.
class StoredRadioGroup {
  const StoredRadioGroup({
    required this.group,
    required this.key,
    required this.joinedAt,
  });

  final RadioRoom group;

  /// The 32-byte group key. Kept instead of the password, as a channel's is:
  /// the key is all anyone needs, and the password may be one used elsewhere.
  final Uint8List key;

  final DateTime joinedAt;
}

/// The radio's corner of the disk: joined groups, and the silent-mode switch.
abstract class RadioGroupStore {
  Future<List<StoredRadioGroup>> loadGroups();
  Future<void> putGroup(StoredRadioGroup stored);
  Future<void> deleteGroup(String tagHex);
  Future<void> clearGroups();

  /// Null when it has never been set.
  Future<bool?> loadPlayInSilentMode();
  Future<void> savePlayInSilentMode(bool value);
}

/// [HiveBoxes.radioGroups], encrypted like the channels box because a group
/// key is a credential, keyed by tag hex; the switch lives in the settings box.
///
/// Both boxes are opened as `dynamic`, which is how a backup opens every box
/// it has no special case for - opening one typed here would make the
/// backup's untyped open of the same live box throw.
class HiveRadioGroupStore implements RadioGroupStore {
  const HiveRadioGroupStore();

  static const String playInSilentKey = 'radio.playInSilentMode';

  Future<Box<dynamic>> _groups() =>
      hiveCipherProvider.openEncryptedBox<dynamic>(HiveBoxes.radioGroups);

  Future<Box<dynamic>> _settings() =>
      hiveCipherProvider.openEncryptedBox<dynamic>(HiveBoxes.settings);

  @override
  Future<List<StoredRadioGroup>> loadGroups() async {
    final box = await _groups();
    final out = <StoredRadioGroup>[];
    for (final k in box.keys) {
      final raw = box.get(k);
      if (raw is! Map) continue;
      try {
        out.add(_decode(raw));
      } catch (e) {
        debugPrint('skip corrupt radio group "$k": $e');
      }
    }
    return out;
  }

  @override
  Future<void> putGroup(StoredRadioGroup stored) async {
    final box = await _groups();
    await box.put(stored.group.tagHex, <String, Object>{
      'name': stored.group.name,
      'hasPassword': stored.group.hasPassword,
      'keyHex': radioHex(stored.key),
      'tagHex': stored.group.tagHex,
      'joinedAtIso': stored.joinedAt.toIso8601String(),
    });
  }

  @override
  Future<void> deleteGroup(String tagHex) async {
    final box = await _groups();
    await box.delete(tagHex);
  }

  @override
  Future<void> clearGroups() async {
    final box = await _groups();
    await box.clear();
  }

  @override
  Future<bool?> loadPlayInSilentMode() async {
    final v = (await _settings()).get(playInSilentKey);
    return v is bool ? v : null;
  }

  @override
  Future<void> savePlayInSilentMode(bool value) async {
    await (await _settings()).put(playInSilentKey, value);
  }

  static StoredRadioGroup _decode(Map<dynamic, dynamic> m) {
    final key = radioUnhex(m['keyHex'] as String);
    if (key.length != 32) throw const FormatException('key is not 32 bytes');
    return StoredRadioGroup(
      group: RadioRoom(
        name: m['name'] as String,
        hasPassword: (m['hasPassword'] as bool?) ?? false,
        tagHex: m['tagHex'] as String,
      ),
      key: key,
      joinedAt: DateTime.tryParse((m['joinedAtIso'] as String?) ?? '') ??
          DateTime.now(),
    );
  }
}

final radioGroupStoreProvider =
    Provider<RadioGroupStore>((_) => const HiveRadioGroupStore());

/// The radio's clock. Every freshness rule in it - the 5 s age limit, the
/// floor's tail, when to stop the speaker - reads this, so a test can move it.
final radioClockProvider = Provider<DateTime Function()>((_) => DateTime.now);

/// Whether a voice call is up. Read, not watched: the controller asks on every
/// chunk and every tick, and must not be rebuilt by a call's every change.
final radioCallBusyProvider = Provider<bool Function()>(
  (ref) => () {
    final phase = ref.read(callControllerProvider).phase;
    return phase != CallPhase.idle && phase != CallPhase.ended;
  },
);

String radioHex(Uint8List bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

Uint8List radioUnhex(String hex) {
  if (hex.length.isOdd) throw FormatException('odd-length hex: $hex');
  final out = Uint8List(hex.length ~/ 2);
  for (var i = 0; i < out.length; i++) {
    out[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
  }
  return out;
}
