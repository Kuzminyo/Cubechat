import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/app/bindings.dart';
import 'package:cubechat/core/crypto/identity_service.dart';
import 'package:cubechat/core/crypto/radio_crypto.dart';
import 'package:cubechat/core/crypto/sealed_box.dart';
import 'package:cubechat/core/crypto/signed_payload.dart';
import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/frame.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/nostr/nostr_signer.dart';
import 'package:cubechat/core/transport/nostr/nostr_transport.dart';
import 'package:cubechat/core/transport/nostr/websocket_relay_client.dart';
import 'package:cubechat/core/transport/peer_id.dart';
import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:cubechat/features/radio/data/radio_inbound.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

/// No relays configured, so nothing reaches the internet unless a test hands
/// a pool in through `debugUseRelay`.
class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// A relay transport that counts what it is asked to publish and then
/// publishes it for real, so the control in the test proves the road was
/// open.
class _CountingNostr extends NostrTransport {
  _CountingNostr({required super.signer, required super.relay});

  int sent = 0;

  @override
  Future<PublishReceipt> sendFrame({
    required String recipientNpubHex,
    required Uint8List frameBytes,
    bool wakesPeer = false,
    bool wakesCall = false,
    RelayLane lane = RelayLane.conversation,
  }) {
    sent++;
    return super.sendFrame(
      recipientNpubHex: recipientNpubHex,
      frameBytes: frameBytes,
      wakesPeer: wakesPeer,
      wakesCall: wakesCall,
      lane: lane,
    );
  }
}

/// A relay that takes every EVENT with `OK true` and answers every REQ with
/// `EOSE`.
class _Relay {
  _Relay._(this._server);

  final HttpServer _server;

  String get url => 'ws://localhost:${_server.port}';

  static Future<_Relay> start() async {
    final server = await HttpServer.bind('localhost', 0);
    final relay = _Relay._(server);
    server.listen((req) async {
      final ws = await WebSocketTransformer.upgrade(req);
      ws.listen((data) {
        final msg = jsonDecode(data as String) as List<dynamic>;
        switch (msg[0]) {
          case 'EVENT':
            final id = (msg[1] as Map)['id'] as String;
            ws.add(jsonEncode(['OK', id, true, '']));
          case 'REQ':
            ws.add(jsonEncode(['EOSE', msg[1]]));
        }
      });
    });
    return relay;
  }

  Future<void> stop() => _server.close(force: true);
}

/// Another phone: its own X25519 identity and Ed25519 signing key.
class _Phone {
  _Phone._(this.keyPair, this.pub, this.signKeyPair, this.signPub);

  final SimpleKeyPair keyPair;
  final Uint8List pub;
  final SimpleKeyPairData signKeyPair;
  final Uint8List signPub;

  String get pubHex => _hex(pub);

  static Future<_Phone> make() async {
    final x = await X25519().newKeyPair();
    final ed = await Ed25519().newKeyPair();
    return _Phone._(
      x,
      Uint8List.fromList((await x.extractPublicKey()).bytes),
      await ed.extract(),
      Uint8List.fromList((await ed.extractPublicKey()).bytes),
    );
  }

  Future<Uint8List> originHash() =>
      PeerId.derive(pub, PeerId.epochAt(DateTime.now()));

  /// The 1:1 radio key this phone shares with the phone whose identity key
  /// is [theirPub].
  Future<Uint8List> pairKeyWith(Uint8List theirPub) =>
      RadioCrypto.derivePairKey(mine: keyPair, myPub: pub, theirPub: theirPub);
}

int get _epochNow => PeerId.epochAt(DateTime.now());

String _hex(Uint8List b) =>
    b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

RadioChunk _chunk(int seq) => RadioChunk(
      transmissionId: Uint8List.fromList(List<int>.generate(16, (i) => i)),
      seq: seq,
      isLast: false,
      startedAtMs: DateTime.now().millisecondsSinceEpoch,
      frames: [
        Uint8List.fromList(List<int>.filled(20, seq & 0xFF)),
      ],
    );

Future<void> _until(bool Function() check, {required String reason}) async {
  final deadline = DateTime.now().add(const Duration(seconds: 5));
  while (!check()) {
    if (DateTime.now().isAfter(deadline)) fail('timed out waiting for $reason');
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
}

/// Walkie-talkie chunks over the mesh: what goes out, what is never kept, and
/// what comes back in.
///
/// Voice is only worth anything in the 300 ms it was meant for. A chunk that
/// sits in an outbox, a store-and-forward cache or a relay backlog arrives as
/// noise from the past and costs the airtime of the mail that should have had
/// that slot - so the send side has exactly one answer when nobody is in
/// range: nowhere.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  final peerHex = 'ab' * 32;

  // Every DebugLog line goes through debugPrint, so this sees each one
  // exactly once - without the ring buffer's collapsing of repeats, which
  // would hide a per-chunk line behind a counter.
  final printed = <String>[];
  late DebugPrintCallback originalPrint;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_radio_tx_');
    Hive.init(tempDir.path);
    printed.clear();
    originalPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) printed.add(message);
    };
  });

  tearDown(() async {
    debugPrint = originalPrint;
    await settleBackgroundStorage();
    try {
      await Hive.close();
    } on FileSystemException {
      // The service closes its own boxes on dispose, unawaited.
    }
    try {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows holds a just-closed box briefly.
    }
  });

  Future<(ProviderContainer, MessagingService)> start({
    Uint8List? nostrPubkey,
  }) async {
    final container = ProviderContainer(
      overrides: [
        ...appBindings,
        relaySettingsProvider.overrideWith(_Offline.new),
        messagingServiceProvider.overrideWith((ref) {
          final service = MessagingService(ref);
          ref.onDispose(() => unawaited(service.dispose()));
          return service;
        }),
      ],
    );
    addTearDown(container.dispose);
    await container.read(messagesControllerProvider.notifier).loaded;
    container.read(knownPeersControllerProvider.notifier).upsert(
          pubkeyHex: peerHex,
          displayName: 'Alice',
          signPublicKey: Uint8List(32),
          nostrPubkey: nostrPubkey,
        );
    return (container, container.read(messagingServiceProvider));
  }

  /// A group frame from [from], as its phone would put it on the air.
  Future<Uint8List> groupFrame({
    required _Phone from,
    required Uint8List key,
    required Uint8List tag,
    required int seq,
  }) async {
    final env = await MessagingService.radioEnvelope(
      key: key,
      tag: tag,
      chunk: _chunk(seq),
      originHash: await from.originHash(),
      msgId: TransportEnvelope.newMsgId(initialTtl: 3),
      ttl: 3,
      signKeyPair: from.signKeyPair,
      senderEdPub: from.signPub,
    );
    return Frame(type: FrameType.transport, payload: env.encode()).encode();
  }

  /// A 1:1 frame from [from] to this phone, as [from] would put it on the
  /// air in [epoch]. [signer] stands in for somebody else's signature.
  Future<Uint8List> pairFrame(
    ProviderContainer c, {
    required _Phone from,
    required int seq,
    int? epoch,
    Uint8List? key,
    _Phone? signer,
  }) async {
    final me = await c.read(identityProvider.future);
    final pairKey =
        key ?? await from.pairKeyWith(Uint8List.fromList(me.publicKey));
    final tag = await RadioCrypto.derivePairTag(
      await from.pairKeyWith(Uint8List.fromList(me.publicKey)),
      epoch ?? _epochNow,
    );
    return groupFrame(
      from: _Phone._(
        from.keyPair,
        from.pub,
        (signer ?? from).signKeyPair,
        (signer ?? from).signPub,
      ),
      key: pairKey,
      tag: tag,
      seq: seq,
    );
  }

  /// [p] as a contact, and - unless [tuned] is false - the radio tuned to
  /// them, which is the only case in which their pair frames are opened.
  void addContact(ProviderContainer c, _Phone p, {bool tuned = true}) {
    c.read(knownPeersControllerProvider.notifier).upsert(
          pubkeyHex: p.pubHex,
          displayName: 'Bob',
          signPublicKey: p.signPub,
        );
    if (tuned) c.read(radioPairPeersProvider.notifier).state = {p.pubHex};
  }

  Future<List<RadioInbound>> listen(ProviderContainer c) async {
    final got = <RadioInbound>[];
    final sub = c.read(radioInboundProvider).listen(got.add);
    addTearDown(sub.cancel);
    return got;
  }

  Iterable<String> radioLines() =>
      printed.where((l) => l.startsWith('[RADIO]'));

  /// What somebody holding both keys can do with a radio frame: open it
  /// under [fromKey] and seal the very same signed bytes under [toKey],
  /// behind [toTag]. Origin, msgId and signature are untouched.
  Future<Uint8List> reseal(
    Uint8List frame, {
    required Uint8List fromKey,
    required Uint8List toKey,
    required Uint8List toTag,
  }) async {
    final env = TransportEnvelope.decode(Frame.decode(frame).payload);
    final plain = await RadioCrypto.open(fromKey, env.body.sublist(9));
    final sealed = await RadioCrypto.seal(toKey, plain);
    final moved = TransportEnvelope(
      originPubkeyHash: env.originPubkeyHash,
      destPubkeyHash: env.destPubkeyHash,
      msgId: env.msgId,
      ttl: env.ttl,
      body: Uint8List.fromList([0x05, ...toTag, ...sealed]),
    );
    return Frame(type: FrameType.transport, payload: moved.encode()).encode();
  }

  test('a radio chunk to an unreachable contact is not held', () async {
    final (container, service) = await start();

    service.debugRadioFrames = [];
    expect(await service.sendRadioToContact(peerHex, _chunk(0)), 0);
    expect(
      service.debugRadioFrames,
      isEmpty,
      reason: 'with no link at all, not even built',
    );

    // Now as if a link were up, so the frame is built and fanned out: it
    // still reaches nobody, and it is a broadcast — no phone that relays it,
    // of any build, files it in a store-and-forward cache for anybody.
    service.debugAssumeLinkUp = true;
    final links = await service.sendRadioToContact(peerHex, _chunk(1));
    expect(service.debugRadioFrames, hasLength(1));
    final env = TransportEnvelope.decode(
      Frame.decode(service.debugRadioFrames!.single).payload,
    );
    expect(env.isBroadcast, isTrue, reason: 'destHash all zero');
    expect(env.body[0], 0x05, reason: 'the radio cipher byte');
    expect(env.ttl, lessThanOrEqualTo(3));

    expect(links, 0, reason: 'no Bluetooth link: it went nowhere');
    expect(
      service.debugHeldFrameCount,
      0,
      reason: 'nothing in the store-and-forward cache',
    );
    expect(service.debugOutboxSize, 0, reason: 'nothing waiting for a relay');
    expect(
      container.read(messagesControllerProvider)[peerHex] ?? const [],
      isEmpty,
      reason: 'and no bubble in the conversation',
    );

    // Control: the same contact, the same lack of a road, a text instead -
    // and the counters above do see it held. Without this the zeros could be
    // a seam that never moves.
    await service.sendText(peerHex, 'ще тут?');
    expect(service.debugOutboxSize, greaterThan(0));
    expect(service.debugHeldFrameCount, greaterThan(0));
  });

  test('a radio chunk never goes to a relay', () async {
    final (container, service) = await start(
      // A Nostr key on file: a text to this contact *can* go by relay.
      nostrPubkey: Uint8List.fromList(List<int>.filled(32, 0xcd)),
    );
    final relay = await _Relay.start();
    addTearDown(relay.stop);
    final client = WebSocketNostrRelayClient(relayUrls: [relay.url]);
    addTearDown(client.dispose);
    client.start();
    await _until(() => client.isConnected, reason: 'socket up');
    final signer = await Secp256k1NostrSigner.deriveFromSeed(
      Uint8List.fromList(List<int>.generate(32, (i) => i + 3)),
    );
    final nostr = _CountingNostr(signer: signer, relay: client);
    service.debugUseRelay(client, nostr);

    // Control: with no Bluetooth, a text takes the relay.
    await service.sendText(peerHex, 'по інтернету');
    expect(nostr.sent, greaterThan(0), reason: 'the relay road is open');

    nostr.sent = 0;
    // Built and fanned out for real, not stopped at "no link".
    service.debugAssumeLinkUp = true;
    service.debugRadioFrames = [];
    final key = await RadioCrypto.deriveKey('patrol', '');
    final tag = await RadioCrypto.deriveTag(key);
    for (var i = 0; i < 5; i++) {
      expect(await service.sendRadioToContact(peerHex, _chunk(i)), 0);
      expect(await service.sendRadioToGroup(key, tag, _chunk(i)), 0);
    }
    expect(service.debugRadioFrames, hasLength(10), reason: 'all built');
    expect(nostr.sent, 0, reason: 'not one chunk was published');
    expect(
      container.read(messagesControllerProvider)[peerHex]!.length,
      1,
      reason: 'only the control text is in the conversation',
    );
  });

  test(
      'a group chunk under an unknown tag is dropped without a log line '
      'per chunk', () async {
    final (container, service) = await start();
    final got = await listen(container);
    final someoneElse = await _Phone.make();
    final key = await RadioCrypto.deriveKey('not ours', 'x');
    final tag = await RadioCrypto.deriveTag(key);
    printed.clear();

    for (var i = 0; i < 20; i++) {
      await service.debugReceiveFrame(
        'peer-a',
        await groupFrame(from: someoneElse, key: key, tag: tag, seq: i),
      );
    }
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty);
    expect(radioLines().length, lessThanOrEqualTo(1));
    // Nor under any other tag: twenty chunks are not twenty lines of anything.
    expect(printed.length, lessThan(20), reason: printed.join('\n'));
  });

  test('a group chunk under a known tag reaches radioInbound with its sender',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    container.read(knownPeersControllerProvider.notifier).upsert(
          pubkeyHex: bob.pubHex,
          displayName: 'Bob',
          signPublicKey: bob.signPub,
        );
    final key = await RadioCrypto.deriveKey('patrol', 'secret');
    final tag = await RadioCrypto.deriveTag(key);
    container.read(radioGroupKeysProvider.notifier).state = {_hex(tag): key};

    await service.debugReceiveFrame(
      'peer-b',
      await groupFrame(from: bob, key: key, tag: tag, seq: 7),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, hasLength(1));
    expect(got.single.senderId, bob.pubHex);
    expect(got.single.groupTag, tag);
    expect(got.single.chunk.seq, 7);
    expect(got.single.chunk.frames.single, everyElement(7));
  });

  test('a stranger in a group is named by their signing key', () async {
    final (container, service) = await start();
    final got = await listen(container);
    final stranger = await _Phone.make();
    final key = await RadioCrypto.deriveKey('patrol', 'secret');
    final tag = await RadioCrypto.deriveTag(key);
    container.read(radioGroupKeysProvider.notifier).state = {_hex(tag): key};

    await service.debugReceiveFrame(
      'peer-c',
      await groupFrame(from: stranger, key: key, tag: tag, seq: 0),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, hasLength(1));
    expect(got.single.senderId, _hex(stranger.signPub).substring(0, 16));
  });

  test('a group frame decrypted with the wrong key is dropped', () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    final ours = await RadioCrypto.deriveKey('patrol', 'right');
    final tag = await RadioCrypto.deriveTag(ours);
    container.read(radioGroupKeysProvider.notifier).state = {_hex(tag): ours};
    // Someone who typed the wrong password, wearing our tag - or a forger
    // who copied it off the air. Either way the body does not open.
    final wrong = await RadioCrypto.deriveKey('patrol', 'wrong');
    printed.clear();

    for (var i = 0; i < 20; i++) {
      await service.debugReceiveFrame(
        'peer-b',
        await groupFrame(from: bob, key: wrong, tag: tag, seq: i),
      );
    }
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty);
    expect(
      radioLines().length,
      1,
      reason: 'said once, not once a chunk: ${radioLines().join('\n')}',
    );
  });

  test('our own group chunk coming back is not played to us', () async {
    final (container, service) = await start();
    final got = await listen(container);
    final me = await container.read(identityProvider.future);
    final self = _Phone._(
      me.asKeyPair(),
      Uint8List.fromList(me.publicKey),
      me.asSignKeyPair(),
      me.signPublicKey,
    );
    final key = await RadioCrypto.deriveKey('patrol', 'secret');
    final tag = await RadioCrypto.deriveTag(key);
    container.read(radioGroupKeysProvider.notifier).state = {_hex(tag): key};

    await service.debugReceiveFrame(
      'peer-b',
      await groupFrame(from: self, key: key, tag: tag, seq: 0),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty);
  });

  test('a pair frame reaches radioInbound with the contact as sender',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    addContact(container, bob);

    await service.debugReceiveFrame(
      'peer-b',
      await pairFrame(container, from: bob, seq: 3),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, hasLength(1));
    expect(got.single.senderId, bob.pubHex);
    expect(got.single.groupTag, isNull);
    expect(got.single.chunk.seq, 3);
  });

  test('a chunk sent to a contact opens with the key the contact derives',
      () async {
    final (container, service) = await start();
    final bob = await _Phone.make();
    addContact(container, bob);
    service
      ..debugAssumeLinkUp = true
      ..debugRadioFrames = [];

    await service.sendRadioToContact(bob.pubHex, _chunk(9));

    final env = TransportEnvelope.decode(
      Frame.decode(service.debugRadioFrames!.single).payload,
    );
    final me = await container.read(identityProvider.future);
    final key = await bob.pairKeyWith(Uint8List.fromList(me.publicKey));
    expect(env.isBroadcast, isTrue);
    expect(
      env.body.sublist(1, 9),
      await RadioCrypto.derivePairTag(key, _epochNow),
      reason: "the tag Bob looks for this hour",
    );
    final plain = await RadioCrypto.open(key, env.body.sublist(9));
    final verified = await SignedPayload.verify(
      wire: plain,
      // Signed over the pair tag in the destination's place, not the
      // envelope's broadcast zeros.
      context: SignedPayload.contextBytes(
        originPubkeyHash: env.originPubkeyHash,
        destPubkeyHash: env.body.sublist(1, 9),
        msgId: env.msgId,
      ),
      expectedEdPub: me.signPublicKey,
    );
    final inner = unpackInnerPayload(verified.inner);
    expect(inner.type, InnerPayloadType.radioChunk);
    expect(RadioChunk.decode(inner.body).seq, 9);
  });

  test('a pair frame from a non-contact or under the wrong key is dropped',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    final mallory = await _Phone.make();
    addContact(container, bob);
    printed.clear();

    // Somebody we have never met: their pair tag names no contact.
    for (var i = 0; i < 10; i++) {
      await service.debugReceiveFrame(
        'peer-m',
        await pairFrame(container, from: mallory, seq: i),
      );
    }
    expect(radioLines(), isEmpty, reason: 'nobody of ours: not a word');

    // Bob's tag this hour, but a body sealed under some other key.
    final wrong = await RadioCrypto.deriveKey('not', 'the pair key');
    for (var i = 0; i < 10; i++) {
      await service.debugReceiveFrame(
        'peer-m',
        await pairFrame(container, from: bob, seq: i, key: wrong),
      );
    }
    // Bob's tag and Bob's pair key, signed by somebody else.
    await service.debugReceiveFrame(
      'peer-m',
      await pairFrame(container, from: bob, seq: 0, signer: mallory),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty);
    expect(radioLines().length, 1, reason: 'once a minute for Bob, at most');
  });

  test('a previous-epoch pair tag is still accepted, two epochs old is not',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    addContact(container, bob);

    await service.debugReceiveFrame(
      'peer-b',
      await pairFrame(container, from: bob, seq: 1, epoch: _epochNow - 1),
    );
    await service.debugReceiveFrame(
      'peer-b',
      await pairFrame(container, from: bob, seq: 2, epoch: _epochNow - 2),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got.map((g) => g.chunk.seq), [1]);
  });

  test('a chunk signed for one tag and re-sealed under another is dropped',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    final alice = await _Phone.make();
    addContact(container, bob);
    final k1 = await RadioCrypto.deriveKey('patrol', 'one');
    final t1 = await RadioCrypto.deriveTag(k1);
    final k2 = await RadioCrypto.deriveKey('patrol', 'two');
    final t2 = await RadioCrypto.deriveTag(k2);
    // We are in G2 only. Whoever moves the chunk is in G1 too.
    container.read(radioGroupKeysProvider.notifier).state = {_hex(t2): k2};
    printed.clear();

    // Bob speaking in G1, moved into G2 unchanged.
    for (var i = 0; i < 20; i++) {
      final inG1 = await groupFrame(from: bob, key: k1, tag: t1, seq: i);
      await service.debugReceiveFrame(
        'peer-a',
        await reseal(inG1, fromKey: k1, toKey: k2, toTag: t2),
      );
    }
    // Bob's private chunk to Alice, pushed by Alice into G2.
    final pairKey = await bob.pairKeyWith(alice.pub);
    final toAlice = await groupFrame(
      from: bob,
      key: pairKey,
      tag: await RadioCrypto.derivePairTag(pairKey, _epochNow),
      seq: 50,
    );
    await service.debugReceiveFrame(
      'peer-a',
      await reseal(toAlice, fromKey: pairKey, toKey: k2, toTag: t2),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty, reason: 'Bob never spoke in G2');
    expect(
      radioLines().length,
      lessThanOrEqualTo(1),
      reason: 'once a minute for G2, at most: ${radioLines().join('\n')}',
    );

    // Control: a chunk Bob really did sign for G2 is heard.
    await service.debugReceiveFrame(
      'peer-b',
      await groupFrame(from: bob, key: k2, tag: t2, seq: 99),
    );
    await Future<void>.delayed(Duration.zero);
    expect(got.map((g) => g.chunk.seq), [99]);
  });

  test('frames arriving together share one build of the pair tag table',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    addContact(container, bob);
    final first = await pairFrame(container, from: bob, seq: 1);
    final second = await pairFrame(container, from: bob, seq: 2);

    await Future.wait([
      service.debugReceiveFrame('peer-b', first),
      service.debugReceiveFrame('peer-b', second),
    ]);
    await Future<void>.delayed(Duration.zero);

    expect(service.debugRadioPairTagBuilds, 1);
    expect(got.map((g) => g.chunk.seq).toSet(), {1, 2});
  });

  test('with nobody tuned in a pair frame costs no pair crypto at all',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    addContact(container, bob, tuned: false);

    for (var i = 0; i < 3; i++) {
      await service.debugReceiveFrame(
        'peer-b',
        await pairFrame(container, from: bob, seq: i),
      );
    }
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty);
    expect(service.debugRadioPairTagBuilds, 0);

    // Tuned in, the same frames open.
    container.read(radioPairPeersProvider.notifier).state = {bob.pubHex};
    await service.debugReceiveFrame(
      'peer-b',
      await pairFrame(container, from: bob, seq: 7),
    );
    await Future<void>.delayed(Duration.zero);
    expect(got.map((g) => g.chunk.seq), [7]);
    expect(service.debugRadioPairTagBuilds, 1);
  });

  test('a pair frame from a contact the radio is not tuned to is not opened',
      () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    final carol = await _Phone.make();
    addContact(container, carol);
    addContact(container, bob, tuned: false);
    container.read(radioPairPeersProvider.notifier).state = {carol.pubHex};

    await service.debugReceiveFrame(
      'peer-b',
      await pairFrame(container, from: bob, seq: 1),
    );
    await Future<void>.delayed(Duration.zero);
    expect(got, isEmpty);
  });

  test('a radio chunk addressed to us is refused', () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    addContact(container, bob);
    final me = await container.read(identityProvider.future);
    final myPub = Uint8List.fromList(me.publicKey);
    final origin = await bob.originHash();
    final dest = await PeerId.derive(myPub, _epochNow);
    final msgId = TransportEnvelope.newMsgId(initialTtl: 3);
    // What the first cut of this task sent: signed, sealed to us, addressed.
    final signed = await SignedPayload.wrap(
      inner: packInnerPayload(InnerPayloadType.radioChunk, _chunk(4).encode()),
      context: SignedPayload.contextBytes(
        originPubkeyHash: origin,
        destPubkeyHash: dest,
        msgId: msgId,
      ),
      signKeyPair: bob.signKeyPair,
      senderEdPub: bob.signPub,
    );
    final sealed = await SealedBox.seal(signed, myPub);
    final env = TransportEnvelope(
      originPubkeyHash: origin,
      destPubkeyHash: dest,
      msgId: msgId,
      ttl: 3,
      body: Uint8List.fromList([0x01, ...sealed]),
    );

    await service.debugReceiveFrame(
      'peer-b',
      Frame(type: FrameType.transport, payload: env.encode()).encode(),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, isEmpty);
  });
}
