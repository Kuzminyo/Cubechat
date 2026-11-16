import 'dart:io';

import 'package:cubechat/core/models/message.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chats/data/favorites_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/data/stranger_pruning.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/hive_settle.dart';

/// Which strangers survive a trim. Used to be a private method of the
/// transport; now `RosterStrangerPruning`, behind the `StrangerPruning` port.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late ProviderContainer container;
  late KnownPeersController roster;

  String hex(int i) => i.toRadixString(16).padLeft(64, '0');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    tempDir = await Directory.systemTemp.createTemp('cubechat_prune_');
    Hive.init(tempDir.path);
    container = ProviderContainer();
    roster = container.read(knownPeersControllerProvider.notifier);
    await roster.loaded;
    await container.read(messagesControllerProvider.notifier).loaded;
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

  /// Two strangers more than the cap, the first ones heard longest ago — so
  /// with one of them kept there is still one to forget.
  Future<void> overTheCap() async {
    for (var i = 0; i < KnownPeersController.strangerCap + 2; i++) {
      roster.upsert(pubkeyHex: hex(i), displayName: 'p$i', stranger: true);
      if (i < 3) await Future<void>.delayed(const Duration(milliseconds: 2));
    }
  }

  RosterStrangerPruning pruning() => container.read(
        Provider<RosterStrangerPruning>(RosterStrangerPruning.new),
      );

  test('the oldest stranger goes, one with a conversation stays', () async {
    await overTheCap();
    container.read(messagesControllerProvider.notifier).append(
          hex(0),
          Message(
            id: 'm1',
            chatId: hex(0),
            text: 'привіт',
            sentAt: DateTime.now(),
            isMine: false,
            wireId: 'w1',
          ),
        );

    final dropped = await pruning().prune(stillWanted: () => true);

    expect(dropped, isNot(contains(hex(0))), reason: 'they wrote to us');
    expect(dropped, contains(hex(1)), reason: 'next oldest, nothing kept');
    expect(container.read(knownPeersControllerProvider)[hex(0)], isNotNull);
  });

  test('a favourite stranger stays', () async {
    await overTheCap();
    await container.read(favoritesControllerProvider.notifier).toggle(hex(0));

    final dropped = await pruning().prune(stillWanted: () => true);

    expect(dropped, isNot(contains(hex(0))));
    expect(dropped, isNotEmpty);
  });

  test('a transport torn down while waiting forgets nobody', () async {
    await overTheCap();
    final dropped = await pruning().prune(stillWanted: () => false);
    expect(dropped, isEmpty);
    expect(
      container.read(knownPeersControllerProvider).length,
      KnownPeersController.strangerCap + 2,
    );
  });
}
