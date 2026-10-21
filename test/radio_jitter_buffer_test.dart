import 'dart:typed_data';

import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:cubechat/features/radio/domain/radio_jitter_buffer.dart';
import 'package:flutter_test/flutter_test.dart';

final _id = Uint8List.fromList(List<int>.generate(16, (i) => i + 1));
final _other = Uint8List.fromList(List<int>.filled(16, 9));
const _startedAtMs = 1760000000000;

/// A chunk whose frames are tagged `[seq, i]`, so drained output shows which
/// chunk each frame came from.
RadioChunk _chunk(
  int seq, {
  bool isLast = false,
  Uint8List? id,
  int startedAtMs = _startedAtMs,
}) {
  return RadioChunk(
    transmissionId: id ?? _id,
    seq: seq,
    isLast: isLast,
    startedAtMs: startedAtMs,
    frames: [
      for (var i = 0; i < RadioChunk.framesPerChunk; i++)
        Uint8List.fromList([seq & 0xFF, i]),
    ],
  );
}

List<int?> _tags(List<Uint8List?> frames) => [for (final f in frames) f?[0]];

void main() {
  late DateTime now;
  late RadioJitterBuffer buffer;

  void advance(int ms) => now = now.add(Duration(milliseconds: ms));

  setUp(() {
    now = DateTime.fromMillisecondsSinceEpoch(_startedAtMs);
    buffer = RadioJitterBuffer(clock: () => now);
  });

  test('nothing plays before the prebuffer fills', () {
    expect(buffer.push(_chunk(0)), isTrue);
    // One chunk is 300 ms, the prebuffer 400.
    expect(buffer.drain(), isEmpty);
    advance(399);
    expect(buffer.drain(), isEmpty);
    // The second chunk arrives: 600 ms buffered, play.
    expect(buffer.push(_chunk(1)), isTrue);
    expect(buffer.drain().length, 30);
  });

  test('a lone chunk that never gets company plays once the wait is up', () {
    buffer.push(_chunk(0));
    advance(400);
    expect(buffer.drain().length, 15);
  });

  test('a one-chunk transmission plays at once', () {
    buffer.push(_chunk(0, isLast: true));
    expect(buffer.drain().length, 15);
    expect(buffer.finished, isTrue);
  });

  test('out-of-order chunks play in seq order', () {
    buffer.push(_chunk(2));
    buffer.push(_chunk(0));
    buffer.push(_chunk(1));
    final tags = _tags(buffer.drain());
    expect(tags.length, 45);
    expect(tags.take(15).toSet(), {0});
    expect(tags.skip(15).take(15).toSet(), {1});
    expect(tags.skip(30).toSet(), {2});
  });

  test('a duplicate seq is refused', () {
    expect(buffer.push(_chunk(0)), isTrue);
    expect(buffer.push(_chunk(0)), isFalse);
    buffer.push(_chunk(1));
    buffer.drain();
    // Already played: still a duplicate.
    expect(buffer.push(_chunk(0)), isFalse);
    expect(buffer.push(_chunk(1)), isFalse);
  });

  // Ruling 22: freshness is anchored on this phone's arrival of the first
  // chunk; the sender's clock is only a loose bound against old replays.
  test('a sender whose clock is six seconds behind is still heard', () {
    const behind = _startedAtMs - 6000;
    expect(buffer.push(_chunk(0, startedAtMs: behind)), isTrue);
    advance(300);
    expect(buffer.push(_chunk(1, startedAtMs: behind)), isTrue);
    expect(
      _tags(buffer.drain()),
      [...List.filled(15, 0), ...List.filled(15, 1)],
    );
  });

  test('a chunk 5.5 s behind its expected arrival is refused', () {
    expect(buffer.push(_chunk(0)), isTrue);
    // Seq 1 was expected 300 ms after seq 0 arrived.
    advance(300 + 5500);
    expect(buffer.push(_chunk(1)), isFalse);
    // Seq 2, expected at 600 ms, is 5.2 s late: refused too.
    expect(buffer.push(_chunk(2)), isFalse);
  });

  test('a chunk exactly five seconds behind its expected arrival plays', () {
    expect(buffer.push(_chunk(0)), isTrue);
    advance(300 + 5000);
    expect(buffer.push(_chunk(1)), isTrue);
  });

  test('a chunk 61 s off the sender clock is refused, either way', () {
    // Meant to be heard 61 s ago.
    advance(61000);
    expect(buffer.push(_chunk(0)), isFalse);
    // Meant for 61 s from now.
    expect(
      buffer.push(_chunk(0, startedAtMs: _startedAtMs + 2 * 61000)),
      isFalse,
    );
    // Exactly 60 s off is still taken.
    expect(buffer.push(_chunk(0, startedAtMs: _startedAtMs + 1000)), isTrue);
  });

  // Chunks 0 and 1 play, chunk 2 never shows, chunk 3 is queued behind the
  // hole.
  void playUntilHole() {
    buffer.push(_chunk(0));
    buffer.push(_chunk(1));
    buffer.push(_chunk(3));
    expect(_tags(buffer.drain()).length, 30);
  }

  test('a missing seq is skipped after waiting one chunk', () {
    playUntilHole();
    // Seq 2 is not here; give it a chance.
    advance(299);
    expect(buffer.drain(), isEmpty);
    advance(1);
    final tags = _tags(buffer.drain());
    expect(tags.length, 30);
    // 15 holes for the decoder to conceal, then chunk 3.
    expect(tags.take(15).toSet(), {null});
    expect(tags.skip(15).toSet(), {3});
  });

  test('a late chunk that arrives inside the wait slots into the gap', () {
    playUntilHole();
    advance(200);
    expect(buffer.push(_chunk(2)), isTrue);
    final tags = _tags(buffer.drain());
    expect(tags.take(15).toSet(), {2});
    expect(tags.skip(15).toSet(), {3});
  });

  test('a chunk that arrives after its slot was skipped is refused', () {
    playUntilHole();
    advance(300);
    buffer.drain();
    expect(buffer.push(_chunk(2)), isFalse);
  });

  test('a wide hole is jumped, not filled with seconds of silence', () {
    buffer.push(_chunk(0));
    advance(400);
    expect(_tags(buffer.drain()), List.filled(15, 0));
    // Seq 200 is a minute into the press: the sender stalled, or everything
    // in between was lost.
    buffer.push(_chunk(200));
    // The hole is seen, then given its one chunk of grace.
    expect(buffer.drain(), isEmpty);
    advance(300);
    final tags = _tags(buffer.drain());
    expect(
      tags.where((t) => t == null).length,
      lessThanOrEqualTo(3 * RadioChunk.framesPerChunk),
    );
    expect(tags.where((t) => t != null).toSet(), {200});
  });

  test('a hole is as long as the chunk before it', () {
    RadioChunk short(int seq) => RadioChunk(
          transmissionId: _id,
          seq: seq,
          isLast: false,
          startedAtMs: _startedAtMs,
          frames: [
            for (var i = 0; i < 5; i++) Uint8List.fromList([seq, i]),
          ],
        );
    buffer.push(short(0));
    buffer.push(short(2));
    advance(400);
    expect(_tags(buffer.drain()), List.filled(5, 0));
    advance(300);
    expect(
      _tags(buffer.drain()),
      [...List.filled(5, null), ...List.filled(5, 2)],
    );
  });

  test('a hole before the first chunk still waits for the prebuffer', () {
    // Chunk 1 is queued but chunk 0 is not: unbroken speech from the first
    // seq is 300 ms, short of 400, so nothing plays yet.
    buffer.push(_chunk(1));
    expect(buffer.drain(), isEmpty);
    advance(400);
    expect(_tags(buffer.drain()).toSet(), {1});
  });

  test('finished once the last chunk drains', () {
    buffer.push(_chunk(0));
    buffer.push(_chunk(1, isLast: true));
    expect(buffer.finished, isFalse);
    expect(buffer.drain().length, 30);
    expect(buffer.finished, isTrue);
    expect(buffer.drain(), isEmpty);
  });

  test('a last chunk that is held back does not finish early', () {
    buffer.push(_chunk(0));
    buffer.push(_chunk(2, isLast: true));
    buffer.drain();
    expect(buffer.finished, isFalse);
  });

  test('another transmission is refused until the current one finished', () {
    buffer.push(_chunk(0));
    buffer.push(_chunk(1));
    expect(buffer.push(_chunk(0, id: _other)), isFalse);
    buffer.drain();
    // Still not finished: the last chunk has not come.
    expect(buffer.push(_chunk(0, id: _other)), isFalse);
    expect(buffer.push(_chunk(2, isLast: true)), isTrue);
    buffer.drain();
    expect(buffer.finished, isTrue);
    // The next press starts clean, from seq 0 again.
    expect(buffer.push(_chunk(0, id: _other)), isTrue);
    expect(buffer.finished, isFalse);
  });

  test('a finished transmission does not come back from a replay', () {
    buffer.push(_chunk(0, isLast: true));
    buffer.drain();
    expect(buffer.push(_chunk(0, isLast: true)), isFalse);
    expect(buffer.finished, isTrue);
  });

  test('a chunk with a different start time is not part of this press', () {
    buffer.push(_chunk(0));
    expect(buffer.push(_chunk(1, startedAtMs: _startedAtMs + 1)), isFalse);
  });

  test('reset lets another transmission in', () {
    buffer.push(_chunk(0));
    buffer.reset();
    expect(buffer.push(_chunk(0, id: _other)), isTrue);
  });
}
