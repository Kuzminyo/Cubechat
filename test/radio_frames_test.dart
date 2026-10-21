import 'dart:typed_data';

import 'package:cubechat/core/audio/opus_voice.dart';
import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:cubechat/features/radio/domain/radio_frames.dart';
import 'package:flutter_test/flutter_test.dart';

/// Stands in for libopus: two bytes per frame, the first sample's low byte and
/// a running count, so a test can tell which frame ended up where.
class _FakeEncoder {
  int calls = 0;
  final List<Int16List> frames = [];

  Uint8List call(Int16List frame) {
    frames.add(Int16List.fromList(frame));
    return Uint8List.fromList([frame[0] & 0xFF, calls++ & 0xFF]);
  }
}

/// [frames] frames of PCM where every sample of frame n equals n + 1, as
/// little-endian bytes.
Uint8List _pcm(int frames) {
  final out = Uint8List(frames * OpusVoice.frameSamples * 2);
  final bd = ByteData.sublistView(out);
  for (var f = 0; f < frames; f++) {
    for (var s = 0; s < OpusVoice.frameSamples; s++) {
      bd.setInt16(
        (f * OpusVoice.frameSamples + s) * 2,
        f + 1,
        Endian.little,
      );
    }
  }
  return out;
}

void main() {
  final startedAt = DateTime.fromMillisecondsSinceEpoch(1760000000000);

  RadioFramer make(_FakeEncoder enc, {Uint8List? id}) => RadioFramer(
        encode: enc.call,
        clock: () => startedAt,
        transmissionId: id,
      );

  test('pcm in uneven pieces comes out as 15-frame chunks with rising seq', () {
    final enc = _FakeEncoder();
    final framer = make(enc);
    // 40 frames: two full chunks and 10 frames over.
    final pcm = _pcm(40);
    final chunks = <RadioChunk>[];
    // Pieces that never line up with a frame (1920 bytes) or a chunk.
    var o = 0;
    for (final size in [1, 1000, 4097, 777, 12345, 65536]) {
      final end = (o + size).clamp(0, pcm.length);
      chunks.addAll(framer.add(Uint8List.sublistView(pcm, o, end)));
      o = end;
    }
    chunks.addAll(framer.add(Uint8List.sublistView(pcm, o)));
    expect(chunks.length, 2);
    expect([for (final c in chunks) c.seq], [0, 1]);
    for (final c in chunks) {
      expect(c.frames.length, RadioChunk.framesPerChunk);
      expect(c.isLast, isFalse);
    }
    // 40 frames went in, so 40 reached the encoder whole, in order, with the
    // right samples; 10 of them wait for the next chunk.
    expect(enc.frames.length, 40);
    for (var n = 0; n < 40; n++) {
      expect(enc.frames[n].length, OpusVoice.frameSamples);
      expect(enc.frames[n].first, n + 1);
      expect(enc.frames[n].last, n + 1);
    }
    // The second chunk starts where the first stopped.
    expect(chunks[1].frames.first, [16, 15]);
  });

  test('finish marks the last chunk and keeps the transmission id', () {
    final enc = _FakeEncoder();
    final id = Uint8List.fromList(List<int>.generate(16, (i) => i + 100));
    final framer = make(enc, id: id);
    // One chunk out, two frames pending.
    final full = framer.add(_pcm(17));
    expect(full.length, 1);
    final last = framer.finish();
    expect(last.isLast, isTrue);
    expect(last.seq, 1);
    expect(last.transmissionId, id);
    expect(full.single.transmissionId, id);
    expect(last.frames.length, 2);
    expect(() => framer.add(_pcm(1)), throwsStateError);
  });

  test('finish pads a half frame with silence rather than dropping it', () {
    final enc = _FakeEncoder();
    final framer = make(enc);
    // 1.5 frames of PCM: the half frame is the end of the sentence.
    final pcm = _pcm(2);
    expect(framer.add(Uint8List.sublistView(pcm, 0, 1920 + 960)), isEmpty);
    final last = framer.finish();
    expect(last.frames.length, 2);
    final tail = enc.frames.last;
    expect(tail.first, 2);
    expect(tail[479], 2);
    expect(tail[480], 0);
    expect(tail.last, 0);
  });

  test('finish with nothing spoken sends one frame of silence', () {
    final enc = _FakeEncoder();
    final last = make(enc).finish();
    expect(last.isLast, isTrue);
    expect(last.seq, 0);
    expect(last.frames.length, 1);
    expect(enc.frames.single.every((s) => s == 0), isTrue);
  });

  test('every chunk carries the same startedAtMs', () {
    var now = startedAt;
    final framer = RadioFramer(
      encode: _FakeEncoder().call,
      clock: () => now,
    );
    final chunks = <RadioChunk>[];
    for (var i = 0; i < 3; i++) {
      // The clock moves on while the button is held; the start must not.
      now = now.add(const Duration(milliseconds: 300));
      chunks.addAll(framer.add(_pcm(15)));
    }
    chunks.add(framer.finish());
    expect(chunks.length, 4);
    for (final c in chunks) {
      expect(c.startedAtMs, startedAt.millisecondsSinceEpoch);
    }
  });

  test('a fresh framer names itself with 16 random bytes', () {
    final a = make(_FakeEncoder()).finish().transmissionId;
    final b = make(_FakeEncoder()).finish().transmissionId;
    expect(a.length, RadioChunk.idLen);
    expect(a, isNot(b));
  });
}
