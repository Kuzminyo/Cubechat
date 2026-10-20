import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/nostr/link_quality.dart';
import 'package:cubechat/core/transport/nostr/nostr_signer.dart';
import 'package:cubechat/core/transport/nostr/nostr_transport.dart';
import 'package:cubechat/core/transport/nostr/websocket_relay_client.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

/// No relays at first, so the text is queued — then a pool is handed in
/// with nothing listening for its sockets coming up.
class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// A relay that takes every EVENT with `OK true` and answers every REQ with
/// `EOSE` — alive and well, the socket that never needs reopening.
class _Relay {
  _Relay._(this._server);

  final HttpServer _server;
  final List<String> events = [];
  int connections = 0;

  String get url => 'ws://localhost:${_server.port}';

  static Future<_Relay> start() async {
    final server = await HttpServer.bind('localhost', 0);
    final relay = _Relay._(server);
    server.listen((req) async {
      final ws = await WebSocketTransformer.upgrade(req);
      relay.connections++;
      ws.listen((data) {
        final msg = jsonDecode(data as String) as List<dynamic>;
        switch (msg[0]) {
          case 'EVENT':
            final id = (msg[1] as Map)['id'] as String;
            relay.events.add(id);
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

Future<void> _until(bool Function() check, {required String reason}) async {
  final deadline = DateTime.now().add(const Duration(seconds: 5));
  while (!check()) {
    if (DateTime.now().isAfter(deadline)) fail('timed out waiting for $reason');
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
}

/// Once the link is slow, a text that missed the stretched ack deadline is
/// not waiting on a socket to reconnect: the socket answered, nothing will be
/// reopened, and before the presence tick offered the outbox nothing carried
/// it — "Slow network — sending 1 message" with no tick, for as long as the
/// sockets stayed up.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  final peerHex = 'ab' * 32;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_slow_tick_');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
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

  test(
      'a queued text is flushed on a slow tick with the sockets left connected',
      () async {
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
          // A Nostr key on file: this text *can* go by relay.
          nostrPubkey: Uint8List.fromList(List<int>.filled(32, 0xcd)),
        );
    final service = container.read(messagingServiceProvider);

    final msg = await service.sendText(peerHex, 'на EDGE');
    expect(service.debugQueuedFrame(msg.wireId!), isNotNull);

    final relay = await _Relay.start();
    addTearDown(relay.stop);
    final meter = LinkQualityMeter();
    addTearDown(meter.dispose);
    final client = WebSocketNostrRelayClient(
      relayUrls: [relay.url],
      linkQuality: meter,
    );
    addTearDown(client.dispose);
    client.start();
    await _until(() => client.isConnected, reason: 'socket up');
    // Two publishes nobody answered in time: the link is slow.
    meter.recordSilence(relay.url);
    meter.recordSilence(relay.url);
    expect(client.isSlow, isTrue);
    final signer = await Secp256k1NostrSigner.deriveFromSeed(
      Uint8List.fromList(List<int>.generate(32, (i) => i + 7)),
    );
    service.debugUseRelay(
      client,
      NostrTransport(signer: signer, relay: client),
    );
    expect(service.debugQueuedFrame(msg.wireId!), isNotNull);

    service.debugPresenceTick();

    await _until(
      () => service.debugQueuedFrame(msg.wireId!) == null,
      reason: 'the tick to carry the queued text',
    );
    final mine = container
        .read(messagesControllerProvider)[peerHex]!
        .singleWhere((m) => m.wireId == msg.wireId);
    expect(mine.route, MessageRoute.internet);
    expect(relay.events, isNotEmpty);
    expect(relay.connections, 1, reason: 'nothing was reopened to do it');
  });

  test('a fast tick leaves the outbox to the relay-up triggers, as before',
      () async {
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
          nostrPubkey: Uint8List.fromList(List<int>.filled(32, 0xcd)),
        );
    final service = container.read(messagingServiceProvider);
    final msg = await service.sendText(peerHex, 'on wi-fi');

    final relay = await _Relay.start();
    addTearDown(relay.stop);
    final client = WebSocketNostrRelayClient(relayUrls: [relay.url]);
    addTearDown(client.dispose);
    client.start();
    await _until(() => client.isConnected, reason: 'socket up');
    final signer = await Secp256k1NostrSigner.deriveFromSeed(
      Uint8List.fromList(List<int>.generate(32, (i) => i + 7)),
    );
    service.debugUseRelay(
      client,
      NostrTransport(signer: signer, relay: client),
    );

    service.debugPresenceTick();
    await Future<void>.delayed(const Duration(milliseconds: 500));
    expect(service.debugQueuedFrame(msg.wireId!), isNotNull);
    expect(relay.events, isEmpty);
  });
}
