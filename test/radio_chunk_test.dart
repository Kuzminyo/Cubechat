import 'dart:typed_data';

import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:flutter_test/flutter_test.dart';

Uint8List _bytes(int n, int seed) =>
    Uint8List.fromList(List<int>.generate(n, (i) => (seed + i) & 0xFF));

RadioChunk _chunk({
  int frameCount = RadioChunk.framesPerChunk,
  bool isLast = false,
  int seq = 7,
  int startedAtMs = 1760000000123,
}) {
  return RadioChunk(
    transmissionId: _bytes(16, 1),
    seq: seq,
    isLast: isLast,
    startedAtMs: startedAtMs,
    // Different length per frame, so a decoder that assumed a fixed size or
    // mixed up the length prefix shows up as a mismatch.
    frames: [for (var i = 0; i < frameCount; i++) _bytes(10 + i * 3, i)],
  );
}

void main() {
  group('RadioChunk', () {
    test('round trip keeps every field', () {
      for (final isLast in [false, true]) {
        final src = _chunk(isLast: isLast, seq: 65535);
        final back = RadioChunk.decode(src.encode());
        expect(back.transmissionId, src.transmissionId);
        expect(back.seq, 65535);
        expect(back.isLast, isLast);
        expect(back.startedAtMs, src.startedAtMs);
        expect(back.frames.length, RadioChunk.framesPerChunk);
        for (var i = 0; i < src.frames.length; i++) {
          expect(back.frames[i], src.frames[i]);
        }
      }
    });

    test('layout matches the brief byte for byte', () {
      final bytes = _chunk(frameCount: 1, isLast: true, seq: 0x0102).encode();
      expect(bytes[0], 0x01);
      expect(bytes[1], 0x01);
      expect(bytes.sublist(2, 18), _bytes(16, 1));
      expect(bytes.sublist(18, 20), [0x01, 0x02]);
      expect(bytes[28], 1);
      expect(bytes.sublist(29, 31), [0x00, 10]);
      expect(bytes.length, 31 + 10);
    });

    test('truncated bytes throw FormatException', () {
      final bytes = _chunk().encode();
      for (var n = 0; n < bytes.length; n++) {
        expect(
          () => RadioChunk.decode(Uint8List.sublistView(bytes, 0, n)),
          throwsFormatException,
          reason: 'length $n',
        );
      }
    });

    test('a frame length past the end throws FormatException', () {
      final bytes = _chunk(frameCount: 2).encode();
      // First frame's length prefix sits right after the 29-byte header.
      bytes[29] = 0xFF;
      bytes[30] = 0xFF;
      expect(() => RadioChunk.decode(bytes), throwsFormatException);
    });

    test('trailing bytes after the last frame throw FormatException', () {
      final bytes = _chunk(frameCount: 2).encode();
      final longer = Uint8List(bytes.length + 1)
        ..setRange(0, bytes.length, bytes);
      expect(() => RadioChunk.decode(longer), throwsFormatException);
    });

    test('unknown version throws FormatException', () {
      final bytes = _chunk().encode();
      bytes[0] = 0x02;
      expect(() => RadioChunk.decode(bytes), throwsFormatException);
      bytes[0] = 0x00;
      expect(() => RadioChunk.decode(bytes), throwsFormatException);
    });

    test('zero frames or more than 50 throws', () {
      expect(() => _chunk(frameCount: 0).encode(), throwsArgumentError);
      expect(() => _chunk(frameCount: 51).encode(), throwsArgumentError);
      expect(
          RadioChunk.decode(_chunk(frameCount: 50).encode()).frames.length, 50);
      expect(
          RadioChunk.decode(_chunk(frameCount: 1).encode()).frames.length, 1);

      // A hand-built blob that claims zero or 51 frames is refused on decode.
      final zero = _chunk(frameCount: 1).encode().sublist(0, 29);
      zero[28] = 0;
      expect(() => RadioChunk.decode(zero), throwsFormatException);
      final many = _chunk(frameCount: 50).encode();
      many[28] = 51;
      expect(() => RadioChunk.decode(many), throwsFormatException);
    });

    test(
        'a transmission id that is not 16 bytes or a seq out of range '
        'throws on encode', () {
      expect(
        () => RadioChunk(
          transmissionId: _bytes(15, 0),
          seq: 0,
          isLast: false,
          startedAtMs: 0,
          frames: [_bytes(5, 0)],
        ).encode(),
        throwsArgumentError,
      );
      expect(() => _chunk(seq: 65536).encode(), throwsArgumentError);
      expect(() => _chunk(seq: -1).encode(), throwsArgumentError);
    });

    test('a chunk is 300 ms of 20 ms frames', () {
      expect(RadioChunk.framesPerChunk, 15);
      expect(RadioChunk.chunkDuration, const Duration(milliseconds: 300));
    });

    test('the inner payload byte is unique and resolves back', () {
      expect(InnerPayloadType.radioChunk.tag, 0xEC);
      expect(
        InnerPayloadType.values.where((t) => t.tag == 0xEC).length,
        1,
      );
      expect(InnerPayloadType.fromByte(0xEC), InnerPayloadType.radioChunk);
    });
  });
}
