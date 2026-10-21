import 'dart:typed_data';

/// One 300 ms slice of a walkie-talkie transmission.
///
/// Layout, big-endian throughout:
///
/// ```
/// [version:1 = 0x01][flags:1, bit0 = isLast][transmissionId:16]
/// [seq:2][startedAtMs:8][frameCount:1][{len:2, bytes} x frameCount]
/// ```
///
/// A transmission is a press of the button, named by a random
/// [transmissionId]; [seq] counts its chunks from 0 and [isLast] marks the
/// final one, so a receiver can close the playback without waiting for a
/// timeout. [startedAtMs] is when the press began, the same in every chunk of
/// the transmission. It settles who wins when two people press at once, and
/// bounds a replay: a chunk a minute or more off by it is refused. How late a
/// chunk is, though, is measured on the receiver's own clock, from when the
/// transmission's first chunk arrived there (Ruling 22 - a sender's clock may
/// have drifted seconds), because late voice is worse than no voice.
///
/// Sealing and signing happen outside, in the envelope. This type is only the
/// bytes inside.
class RadioChunk {
  const RadioChunk({
    required this.transmissionId,
    required this.seq,
    required this.isLast,
    required this.startedAtMs,
    required this.frames,
  });

  /// 16 random bytes naming one press of the button.
  final Uint8List transmissionId;

  /// Position of this chunk within its transmission, 0..65535 (about five
  /// hours at 300 ms, far more than anyone holds a button).
  final int seq;

  final bool isLast;

  /// Start of the transmission, milliseconds since the epoch.
  final int startedAtMs;

  /// Opus packets, 20 ms each, 1..[maxFrames].
  final List<Uint8List> frames;

  static const int version = 0x01;
  static const int idLen = 16;

  /// 15 x 20 ms. Chosen for airtime, not for latency alone: at 8 kbit/s a
  /// frame is about 20 bytes, so a chunk is a few hundred bytes - one BLE
  /// write after fragmentation - and the envelope, signature and AEAD
  /// overhead is spread over 300 ms of speech instead of 20.
  static const int framesPerChunk = 15;
  static const Duration chunkDuration = Duration(milliseconds: 300);

  /// Upper bound the decoder accepts, so a hostile blob cannot ask for
  /// thousands of allocations. Three times what we send.
  static const int maxFrames = 50;

  static const int _flagLast = 0x01;
  static const int _headerLen = 1 + 1 + idLen + 2 + 8 + 1;

  Uint8List encode() {
    if (transmissionId.length != idLen) {
      throw ArgumentError.value(
        transmissionId.length,
        'transmissionId',
        'must be $idLen bytes',
      );
    }
    if (seq < 0 || seq > 0xFFFF) {
      throw ArgumentError.value(seq, 'seq', 'must fit in two bytes');
    }
    if (startedAtMs < 0) {
      // setUint64 would write it as a huge unsigned number that decode then
      // rejects; refuse at the source instead.
      throw ArgumentError.value(startedAtMs, 'startedAtMs', 'must not be < 0');
    }
    if (frames.isEmpty || frames.length > maxFrames) {
      throw ArgumentError.value(
        frames.length,
        'frames',
        'must be 1..$maxFrames',
      );
    }
    var total = _headerLen;
    for (final f in frames) {
      if (f.length > 0xFFFF) {
        throw ArgumentError.value(f.length, 'frame', 'too long for two bytes');
      }
      total += 2 + f.length;
    }
    final out = Uint8List(total);
    final bd = ByteData.sublistView(out);
    var o = 0;
    out[o++] = version;
    out[o++] = isLast ? _flagLast : 0;
    out.setRange(o, o += idLen, transmissionId);
    bd.setUint16(o, seq);
    o += 2;
    bd.setUint64(o, startedAtMs);
    o += 8;
    out[o++] = frames.length;
    for (final f in frames) {
      bd.setUint16(o, f.length);
      o += 2;
      out.setRange(o, o += f.length, f);
    }
    return out;
  }

  /// Throws [FormatException] on anything that is not exactly one chunk:
  /// remote input, so every length is checked before it is trusted.
  static RadioChunk decode(Uint8List bytes) {
    if (bytes.length < _headerLen) {
      throw const FormatException('radio chunk shorter than its header');
    }
    if (bytes[0] != version) {
      throw FormatException('unknown radio chunk version ${bytes[0]}');
    }
    final bd = ByteData.sublistView(bytes);
    final isLast = bytes[1] & _flagLast != 0;
    var o = 2;
    final id = Uint8List.fromList(bytes.sublist(o, o + idLen));
    o += idLen;
    final seq = bd.getUint16(o);
    o += 2;
    final startedAtMs = bd.getUint64(o);
    if (startedAtMs < 0) {
      // A value of 2^63 or more reads back negative in a Dart int.
      throw const FormatException('radio chunk start time out of range');
    }
    o += 8;
    final count = bytes[o++];
    if (count < 1 || count > maxFrames) {
      throw FormatException('radio chunk frame count $count out of range');
    }
    final frames = <Uint8List>[];
    for (var i = 0; i < count; i++) {
      if (o + 2 > bytes.length) {
        throw const FormatException('radio chunk ends inside a frame length');
      }
      final len = bd.getUint16(o);
      o += 2;
      if (o + len > bytes.length) {
        throw const FormatException('radio chunk frame runs past the end');
      }
      frames.add(Uint8List.fromList(bytes.sublist(o, o + len)));
      o += len;
    }
    if (o != bytes.length) {
      throw const FormatException('radio chunk has trailing bytes');
    }
    return RadioChunk(
      transmissionId: id,
      seq: seq,
      isLast: isLast,
      startedAtMs: startedAtMs,
      frames: frames,
    );
  }
}
