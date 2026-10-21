import 'dart:typed_data';

import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:cubechat/features/radio/domain/radio_floor.dart';
import 'package:flutter_test/flutter_test.dart';

const _t0 = 1760000000000;

Uint8List _id(int fill, [int last = 0]) =>
    Uint8List.fromList([...List<int>.filled(15, fill), last]);

RadioChunk _chunk(
  Uint8List id,
  int startedAtMs, {
  int seq = 0,
  bool isLast = false,
}) {
  return RadioChunk(
    transmissionId: id,
    seq: seq,
    isLast: isLast,
    startedAtMs: startedAtMs,
    frames: [
      Uint8List.fromList([1, 2]),
    ],
  );
}

Uint8List? _listeningTo(RadioFloor floor) {
  final s = floor.state;
  return s is Listening ? s.transmissionId : null;
}

void main() {
  late DateTime now;
  late RadioFloor floor;

  void advance(int ms) => now = now.add(Duration(milliseconds: ms));
  RadioFloor make() => RadioFloor(clock: () => now);

  setUp(() {
    now = DateTime.fromMillisecondsSinceEpoch(_t0);
    floor = make();
  });

  test('pressing on a quiet channel takes the floor', () {
    expect(floor.state, isA<Idle>());
    expect(floor.tryTalk(_id(1), _t0), isTrue);
    final s = floor.state;
    expect(s, isA<Talking>());
    expect((s as Talking).transmissionId, _id(1));
    floor.stopTalking();
    expect(floor.state, isA<Idle>());
  });

  test('pressing while someone talks is refused', () {
    expect(floor.onChunk('alice', _chunk(_id(1), _t0)), isTrue);
    expect(floor.state, isA<Listening>());
    expect(floor.tryTalk(_id(2), _t0 + 50), isFalse);
    expect(floor.state, isA<Listening>());
  });

  test('two near-simultaneous starts resolve to the earlier one on every side',
      () {
    final a = _id(1);
    final b = _id(2);
    const aStart = _t0;
    const bStart = _t0 + 40;

    // Two onlookers hear the same two presses in opposite orders.
    final first = make();
    final second = make();
    first.onChunk('alice', _chunk(a, aStart));
    first.onChunk('bob', _chunk(b, bStart, seq: 0));
    second.onChunk('bob', _chunk(b, bStart));
    second.onChunk('alice', _chunk(a, aStart));
    expect(_listeningTo(first), a);
    expect(_listeningTo(second), a);
    // Later chunks keep it that way, whatever the interleaving.
    first.onChunk('bob', _chunk(b, bStart, seq: 1));
    second.onChunk('bob', _chunk(b, bStart, seq: 1));
    first.onChunk('alice', _chunk(a, aStart, seq: 1));
    second.onChunk('alice', _chunk(a, aStart, seq: 1));
    expect(_listeningTo(first), a);
    expect(_listeningTo(second), a);

    // The two who pressed: the later one gives way, the earlier keeps going.
    final alice = make()..tryTalk(a, aStart);
    final bob = make()..tryTalk(b, bStart);
    expect(alice.onChunk('bob', _chunk(b, bStart)), isFalse);
    expect(alice.state, isA<Talking>());
    expect(bob.onChunk('alice', _chunk(a, aStart)), isTrue);
    expect(_listeningTo(bob), a);
  });

  test('chunks the floor refused are not played', () {
    final a = _id(1);
    final b = _id(2);
    expect(floor.onChunk('alice', _chunk(a, _t0)), isTrue);
    expect(floor.onChunk('bob', _chunk(b, _t0 + 40)), isFalse);
    // Alice's later chunks still play.
    expect(floor.onChunk('alice', _chunk(a, _t0, seq: 1)), isTrue);
  });

  test('equal start breaks ties on the lower id', () {
    final low = _id(1);
    final high = _id(1, 1);
    final first = make();
    final second = make();
    first.onChunk('alice', _chunk(low, _t0));
    first.onChunk('bob', _chunk(high, _t0));
    second.onChunk('bob', _chunk(high, _t0));
    second.onChunk('alice', _chunk(low, _t0));
    expect(_listeningTo(first), low);
    expect(_listeningTo(second), low);

    // The same tie between two who are both talking.
    final talkerHigh = make()..tryTalk(high, _t0);
    expect(talkerHigh.onChunk('alice', _chunk(low, _t0)), isTrue);
    expect(_listeningTo(talkerHigh), low);
    final talkerLow = make()..tryTalk(low, _t0);
    expect(talkerLow.onChunk('bob', _chunk(high, _t0)), isFalse);
    expect(talkerLow.state, isA<Talking>());
  });

  test('a lost last chunk frees the floor after the tail', () {
    floor.onChunk('alice', _chunk(_id(1), _t0));
    advance(999);
    floor.tick();
    expect(floor.state, isA<Listening>());
    advance(1);
    floor.tick();
    expect(floor.state, isA<Idle>());
    expect(floor.tryTalk(_id(2), _t0 + 1000), isTrue);
  });

  test('every chunk of the speaker restarts the tail', () {
    floor.onChunk('alice', _chunk(_id(1), _t0));
    advance(900);
    floor.onChunk('alice', _chunk(_id(1), _t0, seq: 3));
    advance(900);
    floor.tick();
    expect(floor.state, isA<Listening>());
    advance(100);
    floor.tick();
    expect(floor.state, isA<Idle>());
  });

  test('a refused chunk does not hold the floor open', () {
    floor.onChunk('alice', _chunk(_id(1), _t0));
    advance(900);
    // Bob lost the tie; his chunk is not Alice's voice.
    floor.onChunk('bob', _chunk(_id(2), _t0 + 40, seq: 3));
    advance(100);
    floor.tick();
    expect(floor.state, isA<Idle>());
  });

  test('isLast frees the floor at once', () {
    floor.onChunk('alice', _chunk(_id(1), _t0));
    expect(
      floor.onChunk('alice', _chunk(_id(1), _t0, seq: 1, isLast: true)),
      isTrue,
    );
    expect(floor.state, isA<Idle>());
    expect(floor.tryTalk(_id(2), _t0 + 10), isTrue);
  });

  test('a one-chunk press plays and leaves the floor free', () {
    expect(floor.onChunk('alice', _chunk(_id(1), _t0, isLast: true)), isTrue);
    expect(floor.state, isA<Idle>());
  });

  test('a winner that arrives as one last chunk still takes the floor from me',
      () {
    floor.tryTalk(_id(2), _t0 + 40);
    expect(floor.onChunk('alice', _chunk(_id(1), _t0, isLast: true)), isTrue);
    expect(floor.state, isA<Listening>());
    advance(1000);
    floor.tick();
    expect(floor.state, isA<Idle>());
  });

  test('a chunk of a finished press that straggles in changes nothing', () {
    floor.onChunk('alice', _chunk(_id(1), _t0));
    floor.onChunk('alice', _chunk(_id(1), _t0, seq: 2, isLast: true));
    // Seq 1 was reordered behind the last chunk: still worth playing, but it
    // must not put the channel back into Listening.
    expect(floor.onChunk('alice', _chunk(_id(1), _t0, seq: 1)), isTrue);
    expect(floor.state, isA<Idle>());
  });

  test('my own chunks coming back over the mesh are not played', () {
    final mine = _id(1);
    floor.tryTalk(mine, _t0);
    expect(floor.onChunk('me', _chunk(mine, _t0, seq: 4)), isFalse);
    expect(floor.state, isA<Talking>());
    // A relay may deliver the echo after the button was released.
    floor.stopTalking();
    expect(floor.onChunk('me', _chunk(mine, _t0, seq: 5)), isFalse);
    expect(floor.state, isA<Idle>());
  });

  test('a replayed old chunk cannot take the floor from me', () {
    floor.tryTalk(_id(2), _t0);
    // Meant for an hour ago: an earlier start would win the tie-break.
    expect(
      floor.onChunk('mallory', _chunk(_id(1), _t0 - 3600000)),
      isFalse,
    );
    expect(floor.state, isA<Talking>());
  });

  test('a start from a clock far ahead cannot take the floor either', () {
    floor.tryTalk(_id(2), _t0);
    expect(floor.onChunk('mallory', _chunk(_id(1), _t0 + 61000)), isFalse);
    expect(floor.state, isA<Talking>());
    expect(floor.staleBy, const Duration(seconds: 61));
  });

  // Ruling 22: lateness is measured from when the transmission was first
  // heard here; the sender's clock only has to be within a minute.
  test('a sender whose clock is six seconds behind takes the floor', () {
    expect(floor.onChunk('alice', _chunk(_id(1), _t0 - 6000)), isTrue);
    expect(floor.state, isA<Listening>());
    expect(floor.staleBy, isNull);
  });

  test('a sender-clock age of 61 s is refused', () {
    expect(floor.onChunk('alice', _chunk(_id(1), _t0 - 61000)), isFalse);
    expect(floor.state, isA<Idle>());
    expect(floor.staleBy, const Duration(seconds: 61));
    expect(floor.onChunk('alice', _chunk(_id(1), _t0 - 60000)), isTrue);
  });

  test('a chunk 5.5 s behind its expected arrival is refused', () {
    expect(floor.onChunk('alice', _chunk(_id(1), _t0)), isTrue);
    // Seq 1 was expected 300 ms after seq 0 came; the tail has long let go,
    // but the transmission is still held to when it was first heard.
    advance(300 + 5500);
    expect(floor.onChunk('alice', _chunk(_id(1), _t0, seq: 1)), isFalse);
    expect(floor.staleBy, const Duration(milliseconds: 5500));
    expect(floor.state, isA<Idle>());
    // 4.9 s behind is a stall, not a replay: it takes the floor back.
    advance(-600);
    expect(floor.onChunk('alice', _chunk(_id(1), _t0, seq: 1)), isTrue);
    expect(floor.state, isA<Listening>());
  });

  test('talking is not cut off by the tail timer', () {
    floor.tryTalk(_id(1), _t0);
    advance(60000);
    floor.tick();
    expect(floor.state, isA<Talking>());
  });

  test('stopTalking while listening leaves the listening alone', () {
    floor.onChunk('alice', _chunk(_id(1), _t0));
    floor.stopTalking();
    expect(floor.state, isA<Listening>());
  });
}
