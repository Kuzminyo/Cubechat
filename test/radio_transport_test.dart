import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/crypto/identity_service.dart';
import 'package:cubechat/core/crypto/radio_crypto.dart';
import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/frame.dart';
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
  _Phone._(this.pub, this.signKeyPair, this.signPub);

  final Uint8List pub;
  final SimpleKeyPairData signKeyPair;
  final Uint8List signPub;

  String get pubHex => _hex(pub);

  static Future<_Phone> make() async {
    final x = await X25519().newKeyPair();
    final ed = await Ed25519().newKeyPair();
    return _Phone._(
      Uint8List.fromList((await x.extractPublicKey()).bytes),
      await ed.extract(),
      Uint8List.fromList((await ed.extractPublicKey()).bytes),
    );
  }

  Future<Uint8List> originHash() =>
      PeerId.derive(pub, PeerId.epochAt(DateTime.now()));
}

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
    final env = await MessagingService.radioGroupEnvelope(
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

  Future<List<RadioInbound>> listen(ProviderContainer c) async {
    final got = <RadioInbound>[];
    final sub = c.read(radioInboundProvider).listen(got.add);
    addTearDown(sub.cancel);
    return got;
  }

  Iterable<String> radioLines() => printed.where((l) => l.startsWith('[RADIO]'));

  test('a radio chunk to an unreachable contact is not held', () async {
    final (container, service) = await start();

    final links = await service.sendRadioToContact(peerHex, _chunk(0));

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
    final key = await RadioCrypto.deriveKey('patrol', '');
    final tag = await RadioCrypto.deriveTag(key);
    for (var i = 0; i < 5; i++) {
      expect(await service.sendRadioToContact(peerHex, _chunk(i)), 0);
      expect(await service.sendRadioToGroup(key, tag, _chunk(i)), 0);
    }
    expect(nostr.sent, 0, reason: 'not one chunk was published');
    expect(
      container.read(messagesControllerProvider)[peerHex]!.length,
      1,
      reason: 'only the control text is in the conversation',
    );
  });

  test('a group chunk under an unknown tag is dropped without a log line '
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

  test('a 1:1 radio chunk reaches radioInbound with no group tag', () async {
    final (container, service) = await start();
    final got = await listen(container);
    final bob = await _Phone.make();
    container.read(knownPeersControllerProvider.notifier).upsert(
          pubkeyHex: bob.pubHex,
          displayName: 'Bob',
          signPublicKey: bob.signPub,
        );
    final me = await container.read(identityProvider.future);
    final myPub = Uint8List.fromList(me.publicKey);
    final env = await MessagingService.radioDirectEnvelope(
      chunk: _chunk(3),
      recipientPub: myPub,
      originHash: await bob.originHash(),
      destHash: await PeerId.derive(myPub, PeerId.epochAt(DateTime.now())),
      msgId: TransportEnvelope.newMsgId(initialTtl: 3),
      ttl: 3,
      signKeyPair: bob.signKeyPair,
      senderEdPub: bob.signPub,
    );

    await service.debugReceiveFrame(
      'peer-b',
      Frame(type: FrameType.transport, payload: env.encode()).encode(),
    );
    await Future<void>.delayed(Duration.zero);

    expect(got, hasLength(1));
    expect(got.single.senderId, bob.pubHex);
    expect(got.single.groupTag, isNull);
    expect(got.single.chunk.seq, 3);
  });
}
