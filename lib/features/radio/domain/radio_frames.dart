import 'dart:math' as math;
import 'dart:typed_data';

import '../../../core/audio/opus_format.dart';
import '../../../core/transport/radio_chunk.dart';

/// Cuts a microphone stream into [RadioChunk]s.
///
/// PCM16 mono at 48 kHz arrives from the recorder in whatever pieces the
/// platform likes; this turns it into 960-sample (20 ms) frames, encodes each,
/// and hands back a chunk for every [RadioChunk.framesPerChunk] of them.
///
/// [encode] is injected rather than owning an `OpusVoiceEncoder`: the radio
/// bitrate is the controller's choice, and a test can run the whole cutting
/// logic without libopus.
class RadioFramer {
  RadioFramer({
    required Uint8List Function(Int16List frame) encode,
    required DateTime Function() clock,
    Uint8List? transmissionId,
  })  : _encode = encode,
        transmissionId = transmissionId ?? _randomId(),
        // Read once: every chunk of a press carries the moment it began, and
        // the receiver derives each chunk's playback time from it.
        startedAtMs = math.max(0, clock().millisecondsSinceEpoch) {
    if (this.transmissionId.length != RadioChunk.idLen) {
      throw ArgumentError.value(
        this.transmissionId.length,
        'transmissionId',
        'must be ${RadioChunk.idLen} bytes',
      );
    }
  }

  final Uint8List Function(Int16List frame) _encode;

  final Uint8List transmissionId;
  final int startedAtMs;

  static const int _frameBytes = OpusVoice.frameSamples * 2;

  /// PCM bytes that have not yet made a whole frame.
  Uint8List _carry = Uint8List(0);
  final List<Uint8List> _frames = [];
  int _seq = 0;
  bool _finished = false;

  static Uint8List _randomId() {
    final rng = math.Random.secure();
    return Uint8List.fromList(
      List<int>.generate(RadioChunk.idLen, (_) => rng.nextInt(256)),
    );
  }

  /// Feeds little-endian PCM16; returns the chunks that are now complete
  /// (usually none or one).
  List<RadioChunk> add(Uint8List pcmBytes) {
    if (_finished) throw StateError('transmission already finished');
    final bytes = _carry.isEmpty
        ? pcmBytes
        : (Uint8List(_carry.length + pcmBytes.length)
          ..setRange(0, _carry.length, _carry)
          ..setRange(_carry.length, _carry.length + pcmBytes.length, pcmBytes));
    final out = <RadioChunk>[];
    var o = 0;
    while (bytes.length - o >= _frameBytes) {
      _frames.add(_encode(_toSamples(bytes, o)));
      o += _frameBytes;
      if (_frames.length == RadioChunk.framesPerChunk) {
        out.add(_take(isLast: false));
      }
    }
    _carry = Uint8List.fromList(bytes.sublist(o));
    return out;
  }

  /// Closes the transmission. A half frame left over is padded with silence
  /// instead of dropped, so the last syllable is not clipped; if nothing is
  /// pending at all (the button was released right on a chunk boundary, or
  /// never held) one frame of silence carries the `isLast` flag, because a
  /// chunk with no frames cannot be encoded.
  RadioChunk finish() {
    if (_finished) throw StateError('transmission already finished');
    _finished = true;
    if (_carry.isNotEmpty || _frames.isEmpty) {
      final padded = Uint8List(_frameBytes)..setRange(0, _carry.length, _carry);
      _frames.add(_encode(_toSamples(padded, 0)));
      _carry = Uint8List(0);
    }
    return _take(isLast: true);
  }

  RadioChunk _take({required bool isLast}) {
    final chunk = RadioChunk(
      transmissionId: transmissionId,
      seq: _seq++,
      isLast: isLast,
      startedAtMs: startedAtMs,
      frames: List<Uint8List>.of(_frames),
    );
    _frames.clear();
    return chunk;
  }

  /// One frame's worth of samples from [bytes] at [offset]. Read through a
  /// ByteData so the byte order is the recorder's (little-endian) whatever the
  /// host is, and so [offset] need not be 2-aligned.
  static Int16List _toSamples(Uint8List bytes, int offset) {
    final bd = ByteData.sublistView(bytes, offset, offset + _frameBytes);
    final out = Int16List(OpusVoice.frameSamples);
    for (var i = 0; i < out.length; i++) {
      out[i] = bd.getInt16(i * 2, Endian.little);
    }
    return out;
  }
}
