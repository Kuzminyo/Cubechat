import 'dart:typed_data';

import 'package:cubechat/core/transport/image_reassembly.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:flutter_test/flutter_test.dart';

Uint8List _id(int fill) => Uint8List(16)..fillRange(0, 16, fill);

ImageChunk _image(int fill, int seq) => ImageChunk(
      imageId: _id(fill),
      seq: seq,
      total: 5,
      mime: 'image/jpeg',
      data: Uint8List(64),
    );

AudioChunk _audio(int fill, int seq) => AudioChunk(
      audioId: _id(fill),
      seq: seq,
      total: 5,
      durationMs: 1000,
      mime: 'audio/aac',
      data: Uint8List(64),
    );

/// Photos and voice notes expire by how long they have been silent, as files
/// do (see `file_reassembly_stale_test.dart`): on EDGE a chunk can be minutes
/// behind the last while the sender waits out a dropout.
void main() {
  final t0 = DateTime.utc(2026, 10, 20, 12);

  group('photo', () {
    late DateTime now;
    late ImageReassembler r;

    setUp(() {
      now = t0;
      r = ImageReassembler(clock: () => now);
    });

    test('a photo that keeps moving is not expired', () {
      r.ingest(_image(1, 0));
      now = t0.add(const Duration(seconds: 100));
      r.ingest(_image(1, 1));
      now = t0.add(const Duration(seconds: 200));
      r.ingest(_image(2, 0)); // runs the collection

      expect(r.has(_id(1), 0), isTrue);
      expect(r.has(_id(1), 1), isTrue);
    });

    test('a photo silent for two minutes is expired', () {
      r.ingest(_image(1, 0));
      now = t0.add(const Duration(minutes: 2, seconds: 1));
      r.ingest(_image(2, 0));

      expect(r.has(_id(1), 0), isFalse);
    });

    test('a repeated chunk does not keep a photo alive', () {
      r.ingest(_image(1, 0));
      now = t0.add(const Duration(seconds: 100));
      r.ingest(_image(1, 0));
      now = t0.add(const Duration(minutes: 2, seconds: 1));
      r.ingest(_image(2, 0));

      expect(r.has(_id(1), 0), isFalse);
    });
  });

  group('voice note', () {
    late DateTime now;
    late AudioReassembler r;

    setUp(() {
      now = t0;
      r = AudioReassembler(clock: () => now);
    });

    test('a voice note that keeps moving is not expired', () {
      r.ingest(_audio(1, 0));
      now = t0.add(const Duration(minutes: 4));
      r.ingest(_audio(1, 1));
      now = t0.add(const Duration(minutes: 8));
      r.ingest(_audio(2, 0));

      expect(r.has(_id(1), 1), isTrue);
    });

    test('a voice note silent for five minutes is expired', () {
      r.ingest(_audio(1, 0));
      now = t0.add(const Duration(minutes: 5, seconds: 1));
      r.ingest(_audio(2, 0));

      expect(r.has(_id(1), 0), isFalse);
    });
  });
}
