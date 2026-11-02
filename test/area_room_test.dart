import 'package:cubechat/features/area/domain/area_event.dart';
import 'package:cubechat/features/area/domain/area_room.dart';
import 'package:cubechat/features/area/domain/area_send_limits.dart';
import 'package:flutter_test/flutter_test.dart';

AreaInbound _msg(int i, {String? key, int? at}) => AreaInbound(
      id: i.toRadixString(16).padLeft(64, '0'),
      pubkey: key ?? i.toRadixString(16).padLeft(64, 'f'),
      kind: kAreaMessageKind,
      g: 'u8vx',
      createdAt: at ?? 1000000 + i,
      expiration: 9999999999,
      content: AreaContent(text: 'm$i'),
    );

AreaInbound _note(int i) => AreaInbound(
      id: i.toRadixString(16).padLeft(64, '1'),
      pubkey: i.toRadixString(16).padLeft(64, 'e'),
      kind: kAreaNoteKind,
      g: 'u8vx',
      createdAt: 1000000,
      expiration: 9999999999,
      content: AreaContent(text: 'n$i'),
    );

void main() {
  test('ten thousand events from ten thousand keys stay within the bounds',
      () {
    final room = AreaRoom();
    for (var i = 0; i < 10000; i++) {
      room
        ..addPost(_msg(i))
        ..addNote(_note(i))
        ..addPresence(
          AreaInbound(
            id: 'p$i',
            pubkey: i.toRadixString(16).padLeft(64, 'd'),
            kind: kAreaPresenceKind,
            g: 'u8vx',
            createdAt: 1000000 + i,
          ),
        );
    }
    expect(room.posts.length, AreaRoom.maxPosts);
    expect(room.participantCount, AreaRoom.maxParticipants);
    expect(room.notesAt(0).length, AreaRoom.maxNotes);
    // The newest are what is kept.
    expect(room.posts.last.text, 'm9999');
  });

  test('posts are in time order whatever order they arrive in', () {
    final room = AreaRoom()
      ..addPost(_msg(3))
      ..addPost(_msg(1))
      ..addPost(_msg(2));
    expect(room.posts.map((p) => p.text), ['m1', 'm2', 'm3']);
    expect(room.addPost(_msg(2)), isFalse, reason: 'a duplicate');
  });

  test('more than ten a minute from one key is flood', () {
    final room = AreaRoom();
    const key = 'abcd';
    for (var i = 0; i < 12; i++) {
      room.addPost(_msg(i, key: key.padLeft(64, '0'), at: 5000 + i));
    }
    final flags = room.posts.map((p) => p.flood).toList();
    expect(flags.take(10), everyElement(isFalse));
    expect(flags.skip(10), everyElement(isTrue));
    // A minute later the same key is not flood any more.
    room.addPost(_msg(99, key: key.padLeft(64, '0'), at: 5000 + 200));
    expect(room.posts.last.flood, isFalse);
  });

  test('"≈N here" counts keys seen in the last five minutes', () {
    final room = AreaRoom()
      ..addPost(_msg(1, at: 1010))
      ..addPost(_msg(2, at: 1290));
    expect(room.presentCount(1300), 2);
    expect(room.presentCount(1010 + 300), 1);
  });

  test('a block drops the author everywhere in the room', () {
    final room = AreaRoom()
      ..addPost(_msg(1, key: 'a' * 64))
      ..addPost(_msg(2, key: 'b' * 64));
    room.dropAuthor('a' * 64);
    expect(room.posts.map((p) => p.pubkey), ['b' * 64]);
  });

  group('AreaSendLimits', () {
    test('once in three seconds, twenty in ten minutes, per level', () {
      final limits = AreaSendLimits();
      var t = DateTime(2026, 11, 2, 12);
      expect(limits.canSend('city', t), isTrue);
      limits.noteSent('city', t);
      expect(limits.canSend('city', t.add(const Duration(seconds: 2))), isFalse);
      expect(limits.canSend('region', t), isTrue, reason: 'another level');
      for (var i = 1; i < 20; i++) {
        t = t.add(const Duration(seconds: 4));
        expect(limits.canSend('city', t), isTrue, reason: '#$i');
        limits.noteSent('city', t);
      }
      t = t.add(const Duration(seconds: 4));
      expect(limits.canSend('city', t), isFalse);
      expect(limits.canSend('city', t.add(const Duration(minutes: 10))), isTrue);
    });

    test('three notes a day', () {
      final now = DateTime(2026, 11, 2, 12);
      final made = [
        now.subtract(const Duration(hours: 1)),
        now.subtract(const Duration(hours: 2)),
      ];
      expect(AreaSendLimits.canLeaveNote(made, now), isTrue);
      made.add(now);
      expect(AreaSendLimits.canLeaveNote(made, now), isFalse);
      expect(
        AreaSendLimits.canLeaveNote(made, now.add(const Duration(days: 1))),
        isTrue,
      );
    });
  });
}
