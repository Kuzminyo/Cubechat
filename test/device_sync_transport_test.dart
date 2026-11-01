import 'dart:async';
import 'dart:io';

import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter/foundation.dart';
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

/// The transport's half of device sync: it says what it sent, before
/// sealing, under the id the conversation files it by.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  final peerHex = 'ab' * 32;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_sync_tx_');
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

  Future<(ProviderContainer, MessagingService)> start() async {
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
        );
    return (container, container.read(messagingServiceProvider));
  }

  test('a sent text is reported under the wireId it is filed by', () async {
    final (_, service) = await start();
    final sent = <SentToPeer>[];
    final sub = service.sentToPeers.listen(sent.add);
    addTearDown(sub.cancel);

    final message = await service.sendText(peerHex, 'hello');
    await Future<void>.delayed(Duration.zero);

    final report = sent.single;
    expect(report.chatId, peerHex);
    expect(report.type, InnerPayloadType.text);
    expect(TransportEnvelope.hashHex(report.msgId), message.wireId);
    expect(
      String.fromCharCodes(unpadTextPayload(report.body)),
      'hello',
      reason: 'the text as it went out, unpadded',
    );
  });

  test('a reaction and an edit are reported, a transient send is not',
      () async {
    final (_, service) = await start();
    final sent = <SentToPeer>[];
    final sub = service.sentToPeers.listen(sent.add);
    addTearDown(sub.cancel);

    final message = await service.sendText(peerHex, 'hello');
    await service.sendReaction(peerHex, message.wireId!, '👍', add: true);
    await service.sendEdit(peerHex, message.wireId!, 'hello again');
    await service.sendText(peerHex, 'beacon', transient: true);
    await Future<void>.delayed(Duration.zero);

    expect(sent.map((s) => s.type), [
      InnerPayloadType.text,
      InnerPayloadType.reaction,
      InnerPayloadType.edit,
    ]);
  });
}
