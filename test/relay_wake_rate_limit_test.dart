import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/app/bindings.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/nostr/nostr_signer.dart';
import 'package:cubechat/core/transport/nostr/nostr_transport.dart';
import 'package:cubechat/core/transport/nostr/websocket_relay_client.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// A pool that is never up and counts how often it is told to try again now.
/// Never started, so no socket is opened: only the wakes are under test.
class _CountingPool extends WebSocketNostrRelayClient {
  _CountingPool() : super(relayUrls: const ['ws://localhost:1']);

  int wakes = 0;

  @override
  void wake() => wakes++;
}

/// A phone with no network and texts to send. Every send with no road asks
/// the relays to come back; each such ask used to reach the pool directly and
/// reset every relay's backoff to two seconds, so the doubling that should
/// reach two minutes never got past the floor. A 1215 log (2026-11-23) showed
/// 28 attempts per relay in five offline minutes.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  final peerHex = 'ab' * 32;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_wake_limit_');
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

  test('sends with no road do not wake the relays inside the gap; a resume does',
      () async {
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
          nostrPubkey: Uint8List.fromList(List<int>.filled(32, 0xcd)),
        );
    final service = container.read(messagingServiceProvider);
    // First send before the pool goes in: it is what brings the service up,
    // and the start-up turns the (disabled) fallback off — which would take a
    // pool handed in earlier straight back out.
    await service.sendText(peerHex, 'нульовий');
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final pool = _CountingPool();
    addTearDown(pool.dispose);
    final signer = await Secp256k1NostrSigner.deriveFromSeed(
      Uint8List.fromList(List<int>.generate(32, (i) => i + 7)),
    );
    service.debugUseRelay(pool, NostrTransport(signer: signer, relay: pool));

    // Each of these waits out its relay timeout, so they really are sends
    // with no road — the old code woke the pool on every one of them.
    await service.sendText(peerHex, 'перший');
    await service.sendText(peerHex, 'другий');
    await service.sendText(peerHex, 'третій');
    expect(
      pool.wakes,
      0,
      reason: 'the warm-up send woke the relays seconds ago; these are inside '
          'the gap',
    );

    // Coming back to the app is forced past the gap…
    service.wakeRelays(force: true);
    expect(pool.wakes, 1);

    // …and starts the gap again.
    await service.sendText(peerHex, 'четвертий');
    expect(pool.wakes, 1);
  });
}
