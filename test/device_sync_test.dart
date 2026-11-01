import 'dart:async';
import 'dart:typed_data';

import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/own_device_notice.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/devices/data/device_sync.dart';
import 'package:flutter_test/flutter_test.dart';

Uint8List _id(int fill) => Uint8List.fromList(List.filled(16, fill));
Uint8List _key(int fill) => Uint8List.fromList(List.filled(32, fill));

class _Target implements DeviceSyncTarget {
  final known = <String>{};
  final filed = <String, List<Message>>{};
  final edits = <String>[];
  final deletes = <String>[];
  final reactions = <String>[];
  final pins = <String>[];
  final clears = <String>[];
  final reads = <String, DateTime>{};
  final contacts = <SyncedContact>[];

  @override
  bool hasChat(String chatId) => known.contains(chatId);

  @override
  void fileMine(String chatId, Message message) {
    final list = filed.putIfAbsent(chatId, () => []);
    if (list.any((m) => m.wireId == message.wireId)) return;
    list.add(message);
  }

  @override
  void editMine(String chatId, String wireId, String text) =>
      edits.add('$chatId $wireId $text');

  @override
  void deleteMine(String chatId, String wireId) =>
      deletes.add('$chatId $wireId');

  @override
  void reactMine(
    String chatId,
    String wireId,
    String emoji, {
    required bool add,
  }) =>
      reactions.add('$chatId $wireId $emoji $add');

  @override
  Future<void> pin(String chatId, String wireId, {required bool pinned}) async =>
      pins.add('$chatId $wireId $pinned');

  @override
  Future<void> clearUpTo(String chatId, DateTime upTo) async =>
      clears.add(chatId);

  @override
  Future<void> markRead(String chatId, DateTime at) async {
    final before = reads[chatId];
    if (before == null || at.isAfter(before)) reads[chatId] = at;
  }

  @override
  SyncedContact? contactFor(String chatId) => SyncedContact(
        pubkey: _key(0xAA),
        signPub: _key(0xBB),
        nostr: _key(0xCC),
        name: 'Bob',
      );

  @override
  void addContact(SyncedContact contact) {
    contacts.add(contact);
    known.add(contact.pubkey.map((b) => b.toRadixString(16)).join());
  }
}

class _Rig {
  _Rig({bool others = true, bool relays = true, Uint8List? me})
      : _others = others,
        _relays = relays {
    sync = DeviceSync(
      inbound: inbound.stream,
      sent: sent.stream,
      heard: heard.stream,
      send: (n) async {
        sentNotices.add(n);
        return true;
      },
      passOn: (f) async => passed.add(f),
      deviceId: () async => me ?? _id(1),
      othersExist: () => _others,
      relaysOn: () => _relays,
      target: target,
    );
  }

  final bool _others;
  final bool _relays;
  final inbound = StreamController<OwnDeviceNotice>();
  final sent = StreamController<SentToPeer>();
  final heard = StreamController<Uint8List>();
  final sentNotices = <OwnDeviceNotice>[];
  final passed = <Uint8List>[];
  final target = _Target();
  late final DeviceSync sync;

  Future<void> settle() => Future<void>.delayed(Duration.zero).then(
        (_) => Future<void>.delayed(Duration.zero),
      );

  /// A notice as the other device (id 2) would send it.
  void fromOther(OwnDeviceNotice notice) => inbound.add(
        OwnDeviceNotice.decode(notice.encode()),
      );
}

OwnDeviceNotice _mirror(
  String chat,
  InnerPayloadType type,
  Uint8List body, {
  int device = 2,
  int msg = 7,
}) =>
    OwnDeviceNotice.mirror(
      deviceId: _id(device),
      sentAtMs: 1_700_000_000_000,
      chatId: chat,
      innerType: type.tag,
      msgId: _id(msg),
      inner: body,
    );

void main() {
  group('OwnDeviceNotice sync kinds', () {
    test('mirror, read and contact round-trip', () {
      final m = OwnDeviceNotice.decode(
        _mirror('ab' * 32, InnerPayloadType.text, Uint8List.fromList([1, 2]))
            .encode(),
      );
      expect(m.kind, OwnDeviceKind.mirror);
      expect(m.chatId, 'ab' * 32);
      expect(m.innerType, InnerPayloadType.text.tag);
      expect(m.msgId, _id(7));
      expect(m.inner, [1, 2]);

      final r = OwnDeviceNotice.decode(
        OwnDeviceNotice.read(
          deviceId: _id(2),
          sentAtMs: 5,
          chatId: '#patrol',
          upToMs: 1_700_000_123_456,
        ).encode(),
      );
      expect(r.chatId, '#patrol');
      expect(r.upToMs, 1_700_000_123_456);

      final c = OwnDeviceNotice.decode(
        OwnDeviceNotice.contact(
          deviceId: _id(2),
          sentAtMs: 5,
          pubkey: _key(1),
          signPub: _key(2),
          nostr: _key(3),
          name: 'Оля',
        ).encode(),
      );
      expect(c.contactPub, _key(1));
      expect(c.contactSignPub, _key(2));
      expect(c.contactPrekey, isNull);
      expect(c.contactNostr, _key(3));
      expect(c.name, 'Оля');
    });

    test('refuses what it did not write', () {
      final mirror =
          _mirror('ab', InnerPayloadType.text, Uint8List(3)).encode();
      expect(
        () => OwnDeviceNotice.decode(
          Uint8List.sublistView(mirror, 0, mirror.length - 1),
        ),
        throwsFormatException,
        reason: 'cut short',
      );
      expect(
        () => OwnDeviceNotice.decode(Uint8List.fromList([...mirror, 0])),
        throwsFormatException,
        reason: 'trailing byte',
      );
      expect(
        () => OwnDeviceNotice.mirror(
          deviceId: _id(1),
          sentAtMs: 0,
          chatId: 'x' * 200,
          innerType: 0x10,
          msgId: _id(1),
          inner: Uint8List(0),
        ).encode(),
        throwsFormatException,
        reason: 'chat id past its cap',
      );
      expect(
        () => OwnDeviceNotice.mirror(
          deviceId: _id(1),
          sentAtMs: 0,
          chatId: 'ab',
          innerType: 0x10,
          msgId: _id(1),
          inner: Uint8List(OwnDeviceNotice.maxInnerBytes + 1),
        ).encode(),
        throwsFormatException,
        reason: 'payload past its cap',
      );
      final contact = OwnDeviceNotice.contact(
        deviceId: _id(1),
        sentAtMs: 0,
        pubkey: _key(1),
        signPub: _key(2),
        name: '',
      ).encode();
      final badFlags = Uint8List.fromList(contact)..[26 + 64] = 0x04;
      expect(
        () => OwnDeviceNotice.decode(badFlags),
        throwsFormatException,
        reason: 'unknown flags',
      );
    });
  });

  group('DeviceSync', () {
    const bob = 'ab';

    test('a text from the other device is filed as mine, once', () async {
      final rig = _Rig()..target.known.add(bob);
      final body = unpackInnerPayload(
        packInnerPayload(
          InnerPayloadType.text,
          padTextPayload(Uint8List.fromList('привіт'.codeUnits), bucket: 0),
        ),
      ).body;
      rig
        ..fromOther(_mirror(bob, InnerPayloadType.text, body))
        ..fromOther(_mirror(bob, InnerPayloadType.text, body));
      await rig.settle();
      final filed = rig.target.filed[bob]!;
      expect(filed, hasLength(1), reason: 'a repeat is the same wireId');
      expect(filed.single.isMine, isTrue);
      expect(filed.single.wireId, TransportEnvelope.hashHex(_id(7)));
      expect(filed.single.status, MessageStatus.delivered);
    });

    test('a reply keeps what it quotes', () async {
      final rig = _Rig()..target.known.add(bob);
      final body = packTextReply(_id(9), padTextPayload(Uint8List(2)));
      rig.fromOther(_mirror(bob, InnerPayloadType.textReply, body));
      await rig.settle();
      expect(
        rig.target.filed[bob]!.single.replyToWireId,
        TransportEnvelope.hashHex(_id(9)),
      );
    });

    test('edit, delete, reaction, pin and clear land on my messages',
        () async {
      final rig = _Rig()..target.known.add(bob);
      final wire = TransportEnvelope.hashHex(_id(9));
      rig
        ..fromOther(
          _mirror(
            bob,
            InnerPayloadType.edit,
            MessageEdit(targetMsgId: _id(9), text: 'new').encode(),
          ),
        )
        ..fromOther(
          _mirror(
            bob,
            InnerPayloadType.delete,
            MessageDelete(targetMsgId: _id(9)).encode(),
          ),
        )
        ..fromOther(
          _mirror(
            bob,
            InnerPayloadType.reaction,
            Reaction(op: ReactionOp.add, emoji: '👍', targetMsgId: _id(9))
                .encode(),
          ),
        )
        ..fromOther(
          _mirror(
            bob,
            InnerPayloadType.pin,
            MessagePin(op: PinOp.pin, targetMsgId: _id(9)).encode(),
          ),
        )
        ..fromOther(_mirror(bob, InnerPayloadType.conversationClear, Uint8List(0)));
      await rig.settle();
      expect(rig.target.edits, ['$bob $wire new']);
      expect(rig.target.deletes, ['$bob $wire']);
      expect(rig.target.reactions, ['$bob $wire 👍 true']);
      expect(rig.target.pins, ['$bob $wire true']);
      expect(rig.target.clears, [bob]);
    });

    test('our own echo is ignored', () async {
      final rig = _Rig()..target.known.add(bob);
      rig.fromOther(
        _mirror(bob, InnerPayloadType.text, padTextPayload(Uint8List(1)), device: 1),
      );
      await rig.settle();
      expect(rig.target.filed, isEmpty);
    });

    test('a mirror before its contact waits for the contact', () async {
      final rig = _Rig();
      final chat = _key(0xAA).map((b) => b.toRadixString(16)).join();
      rig.fromOther(
        _mirror(chat, InnerPayloadType.text, padTextPayload(Uint8List(1))),
      );
      await rig.settle();
      expect(rig.target.filed, isEmpty, reason: 'nowhere to file it yet');
      rig.fromOther(
        OwnDeviceNotice.contact(
          deviceId: _id(2),
          sentAtMs: 0,
          pubkey: _key(0xAA),
          signPub: _key(0xBB),
          name: 'Bob',
        ),
      );
      await rig.settle();
      expect(rig.target.contacts.single.name, 'Bob');
      expect(rig.target.filed[chat], hasLength(1), reason: 'released');
    });

    test('what I send goes out as a contact once, then mirrors', () async {
      final rig = _Rig();
      for (var i = 0; i < 2; i++) {
        rig.sent.add(
          SentToPeer(
            chatId: bob,
            type: InnerPayloadType.text,
            body: padTextPayload(Uint8List(1)),
            msgId: _id(i),
            at: DateTime(2026),
          ),
        );
      }
      await rig.settle();
      expect(
        rig.sentNotices.map((n) => n.kind),
        [OwnDeviceKind.contact, OwnDeviceKind.mirror, OwnDeviceKind.mirror],
      );
    });

    test('with no other device nothing is sent or passed on', () async {
      final rig = _Rig(others: false);
      rig.sent.add(
        SentToPeer(
          chatId: bob,
          type: InnerPayloadType.text,
          body: Uint8List(1),
          msgId: _id(1),
          at: DateTime(2026),
        ),
      );
      rig.heard.add(Uint8List(3));
      await rig.sync.noteRead(bob, DateTime(2026));
      await rig.settle();
      expect(rig.sentNotices, isEmpty);
      expect(rig.passed, isEmpty);
    });

    test('Bluetooth frames go on only while relays are on', () async {
      final off = _Rig(relays: false)..heard.add(Uint8List(3));
      final on = _Rig()..heard.add(Uint8List(3));
      await off.settle();
      await on.settle();
      expect(off.passed, isEmpty, reason: 'the owner\'s ruling');
      expect(on.passed, hasLength(1));
    });

    test('a read from the other device is applied and not sent back',
        () async {
      final rig = _Rig();
      rig.fromOther(
        OwnDeviceNotice.read(
          deviceId: _id(2),
          sentAtMs: 0,
          chatId: bob,
          upToMs: 2000,
        ),
      );
      await rig.settle();
      expect(rig.target.reads[bob], DateTime.fromMillisecondsSinceEpoch(2000));
      expect(rig.sentNotices, isEmpty);

      await rig.sync.noteRead(bob, DateTime.fromMillisecondsSinceEpoch(3000));
      expect(rig.sentNotices.single.kind, OwnDeviceKind.read);
      expect(rig.sentNotices.single.upToMs, 3000);
    });
  });
}
