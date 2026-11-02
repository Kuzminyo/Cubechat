import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/models/known_peer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

/// Strangers in the roster: people known only from an announcement heard in
/// passing. Anyone in range can mint those by the thousand, so the roster
/// keeps a bounded number of them — and must never, while doing so, forget a
/// person this device actually dealt with.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late ProviderContainer container;
  late KnownPeersController roster;

  String hex(int i) => i.toRadixString(16).padLeft(64, '0');

  Future<void> heard(int i) async {
    roster.upsert(pubkeyHex: hex(i), displayName: 'p$i', stranger: true);
    // Distinct lastSeen, so "seen longest ago" has one answer.
    await Future<void>.delayed(const Duration(milliseconds: 2));
  }

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_strangers_');
    Hive.init(tempDir.path);
    container = ProviderContainer();
    roster = container.read(knownPeersControllerProvider.notifier);
    await roster.loaded;
  });

  tearDown(() async {
    await settleBackgroundStorage();
    container.dispose();
    await Hive.close();
    try {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows can retain a Hive handle briefly after close.
    }
  });

  Map<String, KnownPeer> peers() =>
      container.read(knownPeersControllerProvider);
  bool isStranger(int i) => peers()[hex(i)]!.isStranger;

  test('a broadcast makes a stranger, and anything else unmakes one', () async {
    await heard(1);
    expect(isStranger(1), isTrue);

    // A handshake, a card, an introduction: no `stranger:` argument.
    roster.upsert(pubkeyHex: hex(1), displayName: 'p1');
    expect(isStranger(1), isFalse);

    // And their next broadcast does not make them one again.
    await heard(1);
    expect(isStranger(1), isFalse);
  });

  test('somebody met first is never a stranger', () async {
    roster.upsert(
      pubkeyHex: hex(2),
      displayName: 'met',
      signPublicKey: Uint8List(32),
    );
    await heard(2);
    expect(isStranger(2), isFalse);
  });

  test('past the cap the ones heard longest ago go, nobody else', () async {
    roster.upsert(pubkeyHex: hex(100), displayName: 'contact');
    for (var i = 1; i <= 6; i++) {
      await heard(i);
    }
    await roster.markVerified(hex(1));
    await roster.setBlocked(hex(2), true);

    final dropped = await roster.pruneStrangers(
      keep: 2,
      // As if 3 had a conversation behind them.
      isKept: (p) => p.pubkeyHex == hex(3),
    );

    // 4, 5, 6 were the candidates; 4 was heard first.
    expect(dropped, [hex(4)]);
    expect(peers().keys, containsAll([hex(100), hex(1), hex(2), hex(3)]));
    expect(peers().keys, containsAll([hex(5), hex(6)]));
    expect(peers().containsKey(hex(4)), isFalse);
  });

  test('a flood of strangers comes down to the cap', () async {
    roster.upsert(pubkeyHex: hex(100), displayName: 'contact');
    for (var i = 1; i <= 30; i++) {
      roster.upsert(pubkeyHex: hex(i), displayName: 'p$i', stranger: true);
    }
    final dropped =
        await roster.pruneStrangers(keep: 10, isKept: (_) => false);
    expect(dropped, hasLength(20));
    expect(peers(), hasLength(11));
    expect(peers().containsKey(hex(100)), isTrue);
  });

  test('the mark and the pruning both survive a restart', () async {
    await heard(1);
    await heard(2);
    roster.upsert(pubkeyHex: hex(3), displayName: 'contact');
    await roster.pruneStrangers(keep: 1, isKept: (_) => false);
    await settleBackgroundStorage();

    final next = ProviderContainer();
    addTearDown(next.dispose);
    final restored = next.read(knownPeersControllerProvider.notifier);
    await restored.loaded;
    final after = next.read(knownPeersControllerProvider);
    expect(after.containsKey(hex(1)), isFalse);
    expect(after[hex(2)]!.isStranger, isTrue);
    expect(after[hex(3)]!.isStranger, isFalse);
  });
}
