import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/models/channel.dart';
import 'package:cubechat/core/models/message.dart';
import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/inbound/inbound.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/inbound_harness.dart';

/// The registry that replaced the transport's `switch` statements.
///
/// Those switches were exhaustive, so a new payload type nobody handled did
/// not compile. A registry cannot promise that by itself; this test does, for
/// the registry the app actually runs with — the transport's own share plus
/// every module `lib/app/bindings.dart` binds.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('with the app bindings', () {
    late Directory tempDir;
    late InboundHarness h;

    setUp(() async {
      tempDir = await initTestHive('cubechat_registry_');
      h = await InboundHarness.start();
    });

    tearDown(() async {
      await h.dispose();
      await closeTestHive(tempDir);
    });

    test('every payload type is answered or dropped on purpose, in every scope',
        () {
      final registry = h.service.debugInboundRegistry();
      expect(
        registry.unaccounted.map((e) => '${e.$1.name}/${e.$2.name}'),
        isEmpty,
      );
    });

    test('a conversation is the chat module\'s, the rest the transport\'s', () {
      final registry = h.service.debugInboundRegistry();
      String? owner(InboundScope s, InnerPayloadType t) =>
          registry.ownerOf(s, t);

      for (final t in [
        InnerPayloadType.text,
        InnerPayloadType.textReply,
        InnerPayloadType.edit,
        InnerPayloadType.delete,
        InnerPayloadType.pin,
        InnerPayloadType.reaction,
        InnerPayloadType.receipt,
        InnerPayloadType.forwardedFrom,
        InnerPayloadType.conversationClear,
        InnerPayloadType.copyRestriction,
      ]) {
        expect(owner(InboundScope.direct, t), 'chat', reason: t.name);
      }
      for (final t in [
        InnerPayloadType.text,
        InnerPayloadType.textReply,
        InnerPayloadType.edit,
        InnerPayloadType.delete,
        InnerPayloadType.pin,
        InnerPayloadType.reaction,
        InnerPayloadType.receipt,
      ]) {
        expect(owner(InboundScope.room, t), 'chat', reason: t.name);
      }
      expect(
        owner(InboundScope.room, InnerPayloadType.channelPoll),
        'channels',
      );
      expect(owner(InboundScope.direct, InnerPayloadType.typing), 'peers');
      expect(
        owner(InboundScope.direct, InnerPayloadType.forwardPrivacy),
        'peers',
      );
      // Room administration, media, presence, calls and the control streams
      // are still the transport's.
      expect(
        owner(InboundScope.room, InnerPayloadType.channelAdmin),
        'transport',
      );
      expect(
        owner(InboundScope.direct, InnerPayloadType.presence),
        'transport',
      );
      expect(
        owner(InboundScope.direct, InnerPayloadType.mediaManifest),
        'transport',
      );
      expect(
        owner(InboundScope.direct, InnerPayloadType.callSignal),
        'transport',
      );
    });
  });

  group('the registry itself', () {
    InboundContext ctx(InboundScope scope) => scope == InboundScope.direct
        ? InboundContext.direct(
            linkPeerId: 'link',
            env: TransportEnvelope(
              originPubkeyHash: Uint8List(8),
              destPubkeyHash: Uint8List(8),
              msgId: Uint8List(16),
              ttl: 0,
              body: Uint8List(0),
            ),
            senderPub: null,
            senderEdPub: null,
            route: MessageRoute.bluetooth,
            routeHops: 1,
            sentAt: null,
            stamp: DateTime(2026),
            forwardSecret: false,
            authorProof: () => null,
          )
        : InboundContext.room(
            linkPeerId: 'link',
            env: TransportEnvelope(
              originPubkeyHash: Uint8List(8),
              destPubkeyHash: Uint8List(8),
              msgId: Uint8List(16),
              ttl: 0,
              body: Uint8List(0),
            ),
            channel: Channel(
              name: '#test',
              hasPassword: false,
              key: Uint8List(32),
              tag: Uint8List(8),
              joinedAt: DateTime(2026),
            ),
            authorName: 'A',
            authorId: '0123456789abcdef',
            senderEdPub: null,
            route: MessageRoute.bluetooth,
            routeHops: 1,
            stamp: DateTime(2026),
          );

    test('two owners for one type are refused at once', () {
      final registry = InboundRegistry()
        ..on(
          InboundScope.direct,
          const [InnerPayloadType.text],
          (_, __, ___) {},
          owner: 'one',
        );
      expect(
        () => registry.on(
          InboundScope.direct,
          const [InnerPayloadType.text],
          (_, __, ___) {},
          owner: 'two',
        ),
        throwsStateError,
      );
      expect(
        () => registry.ignore(
          InboundScope.direct,
          const [InnerPayloadType.text],
          owner: 'three',
          why: 'test',
        ),
        throwsStateError,
      );
    });

    test('the same type in the other scope is a different claim', () {
      final registry = InboundRegistry()
        ..on(
          InboundScope.direct,
          const [InnerPayloadType.edit],
          (_, __, ___) {},
          owner: 'one',
        )
        ..on(
          InboundScope.room,
          const [InnerPayloadType.edit],
          (_, __, ___) {},
          owner: 'two',
        );
      expect(registry.ownerOf(InboundScope.room, InnerPayloadType.edit), 'two');
    });

    test('dispatch reaches the handler of the frame\'s own scope', () async {
      final seen = <String>[];
      final registry = InboundRegistry()
        ..on(
          InboundScope.direct,
          const [InnerPayloadType.edit],
          (c, t, b) => seen.add('direct ${t.name} ${b.length}'),
          owner: 'one',
        )
        ..on(
          InboundScope.room,
          const [InnerPayloadType.edit],
          (c, t, b) => seen.add('room ${c.channel!.name}'),
          owner: 'two',
        );
      await registry.dispatch(
        ctx(InboundScope.direct),
        InnerPayloadType.edit,
        Uint8List(3),
      );
      await registry.dispatch(
        ctx(InboundScope.room),
        InnerPayloadType.edit,
        Uint8List(0),
      );
      expect(seen, ['direct edit 3', 'room #test']);
    });

    test('a type nobody claimed is dropped, not thrown', () async {
      final registry = InboundRegistry();
      await registry.dispatch(
        ctx(InboundScope.direct),
        InnerPayloadType.text,
        Uint8List(0),
      );
      expect(registry.unaccounted, isNotEmpty);
    });
  });
}
