import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/models/channel.dart';
import 'package:cubechat/core/transport/call_signal.dart';
import 'package:cubechat/core/transport/channel_poll.dart';
import 'package:cubechat/core/transport/shared_location.dart';
import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/features/channels/data/channel_controller.dart';
import 'package:cubechat/features/chat/data/conversation_settings_controller.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/data/pinned_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/data/peer_activity.dart';
import 'package:cubechat/features/peers/data/typing_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/inbound_harness.dart';

/// What this phone does with each kind of inbound payload, pinned from the
/// outside: signed, sealed frames go in through the transport's front door and
/// controller state is read back.
///
/// Written before the inbound switches in `MessagingService` were replaced by a
/// registry of handlers living in the features (see
/// docs/superpowers/specs/2026-11-16-messaging-service-split-design.md). It
/// passed against the switches first, so a red test here after a move is a
/// behaviour change, not a new expectation.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late InboundHarness h;

  setUp(() async {
    tempDir = await initTestHive('cubechat_inbound_');
    h = await InboundHarness.start();
  });

  tearDown(() async {
    await h.dispose();
    await closeTestHive(tempDir);
  });

  List<Message> chat(String id) =>
      h.container.read(messagesControllerProvider)[id] ?? const [];

  Message? byWire(String chatId, Uint8List msgId) {
    final wire = TransportEnvelope.hashHex(msgId);
    for (final m in chat(chatId)) {
      if (m.wireId == wire) return m;
    }
    return null;
  }

  /// One of our own messages in the conversation, as if we had sent it.
  Uint8List ownMessage(String chatId) {
    final msgId = TransportEnvelope.newMsgId(initialTtl: 7);
    h.container.read(messagesControllerProvider.notifier).append(
          chatId,
          Message(
            id: 'mine-${TransportEnvelope.hashHex(msgId)}',
            chatId: chatId,
            text: 'від мене',
            sentAt: DateTime.now(),
            isMine: true,
            wireId: TransportEnvelope.hashHex(msgId),
          ),
        );
    return msgId;
  }

  group('one to one', () {
    test('text is filed under the sender, signed and by Bluetooth', () async {
      final id = await h.direct(InnerPayloadType.text, textBody('привіт'));
      final m = byWire(h.peer.pubHex, id);
      expect(m, isNotNull);
      expect(m!.text, 'привіт');
      expect(m.isMine, isFalse);
      expect(m.route, MessageRoute.bluetooth);
      expect(m.signedProof, isNotNull);
      expect(m.forwardSecret, isFalse);
    });

    test('a reply names what it answers', () async {
      final first = await h.direct(InnerPayloadType.text, textBody('питання'));
      final id = await h.direct(
        InnerPayloadType.textReply,
        packTextReply(first, textBody('відповідь')),
      );
      final m = byWire(h.peer.pubHex, id)!;
      expect(m.text, 'відповідь');
      expect(m.replyToWireId, TransportEnvelope.hashHex(first));
    });

    test('an edit rewrites their message', () async {
      final id = await h.direct(InnerPayloadType.text, textBody('друкарска'));
      await h.direct(
        InnerPayloadType.edit,
        MessageEdit(targetMsgId: id, text: 'друкарська').encode(),
      );
      final m = byWire(h.peer.pubHex, id)!;
      expect(m.text, 'друкарська');
      expect(m.editedAt, isNotNull);
    });

    test('a delete takes their message away after the farewell', () async {
      final id = await h.direct(InnerPayloadType.text, textBody('зітри'));
      expect(byWire(h.peer.pubHex, id), isNotNull);
      await h.direct(
        InnerPayloadType.delete,
        MessageDelete(targetMsgId: id).encode(),
      );
      await Future<void>.delayed(const Duration(milliseconds: 400));
      expect(byWire(h.peer.pubHex, id), isNull);
    });

    test('a reaction lands on our message, keyed by their fingerprint',
        () async {
      final mine = ownMessage(h.peer.pubHex);
      await h.direct(
        InnerPayloadType.reaction,
        Reaction(op: ReactionOp.add, emoji: '👍', targetMsgId: mine).encode(),
      );
      final m = byWire(h.peer.pubHex, mine)!;
      expect(m.reactions['👍'], contains(h.peer.authorId));
    });

    test('a read receipt marks our message read', () async {
      final mine = ownMessage(h.peer.pubHex);
      await h.direct(
        InnerPayloadType.receipt,
        ReadReceipt(status: ReceiptStatus.read, msgIds: [mine]).encode(),
      );
      expect(byWire(h.peer.pubHex, mine)!.status, MessageStatus.read);
    });

    test('a pin pins the conversation on that message', () async {
      final id = await h.direct(InnerPayloadType.text, textBody('важливо'));
      await h.direct(
        InnerPayloadType.pin,
        MessagePin(op: PinOp.pin, targetMsgId: id).encode(),
      );
      final pinned = h.container.read(pinnedControllerProvider)[h.peer.pubHex];
      expect(pinned?.wireId, TransportEnvelope.hashHex(id));
    });

    test('forward privacy is filed on the person, not the link', () async {
      await h.direct(InnerPayloadType.forwardPrivacy, Uint8List.fromList([0]));
      final peer = h.container.read(knownPeersControllerProvider)[h.peer.pubHex];
      expect(peer!.allowsForwardLink, isFalse);
      expect(
        h.container.read(knownPeersControllerProvider)[InboundHarness.linkId],
        isNull,
      );
    });

    test('a malformed forward privacy byte changes nothing', () async {
      await h.direct(InnerPayloadType.forwardPrivacy, Uint8List.fromList([7]));
      final peer = h.container.read(knownPeersControllerProvider)[h.peer.pubHex];
      expect(peer!.allowsForwardLink, isTrue);
    });

    test('a copy restriction is recorded for the conversation', () async {
      await h.direct(InnerPayloadType.copyRestriction, Uint8List.fromList([1]));
      final s = h.container
          .read(conversationSettingsControllerProvider)[h.peer.pubHex];
      expect(s?.peerRestrictsCopying, isTrue);
    });

    test('a conversation clear empties what came before it', () async {
      await h.direct(InnerPayloadType.text, textBody('раз'));
      await h.direct(InnerPayloadType.text, textBody('два'));
      expect(chat(h.peer.pubHex), hasLength(2));
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await h.direct(InnerPayloadType.conversationClear, Uint8List(0));
      expect(chat(h.peer.pubHex), isEmpty);
    });

    test('typing shows while last-seen sharing is on', () async {
      await h.direct(
        InnerPayloadType.typing,
        Uint8List.fromList([PeerActivity.typing.wireByte]),
      );
      final notice = h.container.read(typingControllerProvider)[h.peer.pubHex];
      expect(notice?.kind, PeerActivity.typing);
    });

    test('a call signal is handed on, decoded, under the sender', () async {
      final got = <({String chatId, CallSignal signal})>[];
      final sub = h.service.callSignals.listen(got.add);
      addTearDown(sub.cancel);
      final callId = Uint8List.fromList(List<int>.generate(16, (i) => i));
      await h.direct(
        InnerPayloadType.callSignal,
        CallSignal.ringing(callId).encode(),
      );
      expect(got, hasLength(1));
      expect(got.single.chatId, h.peer.pubHex);
      expect(got.single.signal.kind, CallSignalKind.ringing);
    });

    test('room business on the one-to-one path changes nothing', () async {
      final before = h.container.read(messagesControllerProvider);
      for (final type in [
        InnerPayloadType.channelAdmin,
        InnerPayloadType.channelPoll,
        InnerPayloadType.channelAvatar,
        InnerPayloadType.channelDescription,
        InnerPayloadType.radioChunk,
      ]) {
        await h.direct(type, Uint8List.fromList([1, 2, 3]));
      }
      expect(h.container.read(messagesControllerProvider), before);
    });

    test('an own-device notice not signed by our key is dropped', () async {
      final got = <Object>[];
      final sub = h.service.ownDeviceNotices.listen(got.add);
      addTearDown(sub.cancel);
      await h.direct(InnerPayloadType.ownDevice, Uint8List.fromList([1]));
      expect(got, isEmpty);
    });

    test('a blocked sender is not heard', () async {
      await h.container
          .read(knownPeersControllerProvider.notifier)
          .setBlocked(h.peer.pubHex, true);
      await h.direct(InnerPayloadType.text, textBody('ти мене чуєш?'));
      expect(chat(h.peer.pubHex), isEmpty);
    });
  });

  group('room', () {
    Future<Channel> joined() =>
        h.container.read(channelControllerProvider.notifier).join('#двір');

    test('a post is filed under the room with its author', () async {
      final room = await joined();
      final id = await h.room(room, InnerPayloadType.text, textBody('всім'));
      final m = byWire(room.name, id)!;
      expect(m.text, 'всім');
      expect(m.authorId, h.peer.authorId);
      expect(m.isMine, isFalse);
    });

    test('a reply in a room names what it answers', () async {
      final room = await joined();
      final first =
          await h.room(room, InnerPayloadType.text, textBody('хто тут?'));
      final id = await h.room(
        room,
        InnerPayloadType.textReply,
        packTextReply(first, textBody('я')),
      );
      final m = byWire(room.name, id)!;
      expect(m.replyToWireId, TransportEnvelope.hashHex(first));
    });

    test('the author may edit their post', () async {
      final room = await joined();
      final id = await h.room(room, InnerPayloadType.text, textBody('було'));
      await h.room(
        room,
        InnerPayloadType.edit,
        MessageEdit(targetMsgId: id, text: 'стало').encode(),
      );
      expect(byWire(room.name, id)!.text, 'стало');
    });

    test('somebody else may not edit it', () async {
      final room = await joined();
      final id = await h.room(room, InnerPayloadType.text, textBody('моє'));
      final stranger = await TestPhone.make();
      await h.room(
        room,
        InnerPayloadType.edit,
        MessageEdit(targetMsgId: id, text: 'чуже').encode(),
        from: stranger,
      );
      expect(byWire(room.name, id)!.text, 'моє');
    });

    test('the author may delete their post', () async {
      final room = await joined();
      final id = await h.room(room, InnerPayloadType.text, textBody('геть'));
      await h.room(
        room,
        InnerPayloadType.delete,
        MessageDelete(targetMsgId: id).encode(),
      );
      await Future<void>.delayed(const Duration(milliseconds: 400));
      expect(byWire(room.name, id), isNull);
    });

    test('a reaction in a room is keyed by the reactor', () async {
      final room = await joined();
      final id = await h.room(room, InnerPayloadType.text, textBody('ну'));
      await h.room(
        room,
        InnerPayloadType.reaction,
        Reaction(op: ReactionOp.add, emoji: '🔥', targetMsgId: id).encode(),
      );
      expect(
        byWire(room.name, id)!.reactions['🔥'],
        contains(h.peer.authorId),
      );
    });

    test('anybody may pin in a room', () async {
      final room = await joined();
      final id = await h.room(room, InnerPayloadType.text, textBody('правила'));
      await h.room(
        room,
        InnerPayloadType.pin,
        MessagePin(op: PinOp.pin, targetMsgId: id).encode(),
      );
      expect(
        h.container.read(pinnedControllerProvider)[room.name]?.wireId,
        TransportEnvelope.hashHex(id),
      );
    });

    test('a poll is filed as a poll, and a vote is counted per voter',
        () async {
      final room = await joined();
      final id = await h.room(
        room,
        InnerPayloadType.channelPoll,
        ChannelPollPayload.create('Коли збираємось?', ['завтра', 'в суботу'])
            .encode(),
      );
      final poll = byWire(room.name, id)!;
      expect(poll.kind, MessageKind.poll);
      expect(poll.text, 'Коли збираємось?');
      expect(poll.pollOptions, ['завтра', 'в суботу']);
      expect(poll.authorId, h.peer.authorId);

      final voter = await TestPhone.make();
      await h.room(
        room,
        InnerPayloadType.channelPoll,
        ChannelPollPayload.vote(TransportEnvelope.hashHex(id), 1).encode(),
        from: voter,
      );
      expect(byWire(room.name, id)!.pollVotes, {voter.authorId: 1});
    });

    test('a map beacon in a room is not filed as a post', () async {
      final room = await joined();
      final beacon = SharedLocation(
        latitude: 50.45,
        longitude: 30.52,
        expiresAt: DateTime.now().add(const Duration(minutes: 2)),
        presence: true,
      );
      await h.room(room, InnerPayloadType.text, textBody(beacon.encode()));
      expect(chat(room.name), isEmpty);
    });

    test('a frame in a room we are not in is not opened', () async {
      final room = await joined();
      await h.container
          .read(channelControllerProvider.notifier)
          .leave(room.name);
      await h.room(room, InnerPayloadType.text, textBody('агов'));
      expect(chat(room.name), isEmpty);
    });
  });
}
