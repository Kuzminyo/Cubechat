import 'dart:io';

import 'package:cubechat/core/models/discovered_peer.dart';
import 'package:cubechat/core/transport/ports/peer_extras.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/inbound_harness.dart';

/// A text that finds no link goes into the queue — and, when the scanner can
/// see the recipient right now, the phone dials them instead of waiting for
/// the scanner to come round again.
///
/// Field log of 2026-11-16 (build 1212, both phones offline): the sender's
/// scanner resolved the contact at 18:25:35, the text was queued at 18:25:39,
/// and nothing dialled until the next scan result at 18:26:03 — after
/// Bluetooth had been switched off and on. An idle scan sleeps 54 s between
/// windows, and the auto-connect that chases queued mail only ever ran on a
/// scan result, so a message to somebody standing next to you sat "in the
/// queue" for up to a minute.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = await initTestHive('cubechat_dial_queued_');
  });

  tearDown(() async {
    await closeTestHive(tempDir);
  });

  Future<InboundHarness> start(List<DiscoveredPeer> Function(String) seen) =>
      InboundHarness.start(
        overrides: [
          // Who the scanner can see; the recipient's key is filled in once
          // the harness has made them, before the first send reads this.
          nearbyPeersProvider.overrideWith((ref) => seen(_peerHex)),
        ],
      );

  test('a queued text to a contact in scan range dials them', () async {
    final h = await start(
      (hex) => [
        DiscoveredPeer(
          id: 'AA:BB:CC:DD:EE:01',
          advertisedName: 'Anonymous',
          rssi: -60,
          lastSeen: DateTime.now(),
          resolvedPubkeyHex: hex,
        ),
      ],
    );
    addTearDown(h.dispose);
    _peerHex = h.peer.pubHex;
    h.service.debugDeliveryDials = [];

    await h.service.sendText(h.peer.pubHex, 'ти тут?');
    await drainEventQueue();

    expect(h.service.debugDeliveryDials, ['AA:BB:CC:DD:EE:01']);
  });

  test('a burst of queued texts is one dial, not one per text', () async {
    final h = await start(
      (hex) => [
        DiscoveredPeer(
          id: 'AA:BB:CC:DD:EE:02',
          advertisedName: 'Anonymous',
          rssi: -60,
          lastSeen: DateTime.now(),
          resolvedPubkeyHex: hex,
        ),
      ],
    );
    addTearDown(h.dispose);
    _peerHex = h.peer.pubHex;
    h.service.debugDeliveryDials = [];

    for (var i = 0; i < 3; i++) {
      await h.service.sendText(h.peer.pubHex, 'раз $i');
    }
    await drainEventQueue();

    expect(h.service.debugDeliveryDials, hasLength(1));
  });

  test('nobody is dialled when the recipient is not in scan range', () async {
    final h = await start(
      (hex) => [
        // Somebody else entirely.
        DiscoveredPeer(
          id: 'AA:BB:CC:DD:EE:03',
          advertisedName: 'Anonymous',
          rssi: -60,
          lastSeen: DateTime.now(),
          resolvedPubkeyHex: 'cd' * 32,
        ),
      ],
    );
    addTearDown(h.dispose);
    _peerHex = h.peer.pubHex;
    h.service.debugDeliveryDials = [];

    await h.service.sendText(h.peer.pubHex, 'агов');
    await drainEventQueue();

    expect(h.service.debugDeliveryDials, isEmpty);
  });
}

/// The harness makes the recipient's key, and the scanner override has to
/// name it; set before the first send, read lazily by the override.
String _peerHex = '';
