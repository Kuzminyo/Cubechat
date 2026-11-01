import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/crypto/identity_service.dart';
import 'package:cubechat/core/identity/account_key_rotation.dart';
import 'package:cubechat/core/notifications/push_registration.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/hive_settle.dart';

class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// Push off, so nothing asks the native channel.
class _NoPush extends PushEnabled {
  @override
  bool build() => false;
}

/// A transport that remembers what rotation it was asked to send, under
/// which of our keys.
class _Recording extends MessagingService {
  _Recording(super.ref, this.log);

  final List<Uint8List> log;

  @override
  Future<({int sent, int total})> sendKeyRotationToContacts(
    Uint8List body,
  ) async {
    log.add(body);
    return (sent: 1, total: 1);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory dir;
  final peerHex = 'ab' * 32;

  setUp(() async {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
    dir = await Directory.systemTemp.createTemp('cubechat_rotate_');
    Hive.init(dir.path);
  });

  tearDown(() async {
    await settleBackgroundStorage();
    try {
      await Hive.close();
    } on FileSystemException {
      // closed on dispose, unawaited
    }
    try {
      if (dir.existsSync()) dir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows holds a just-closed box briefly.
    }
  });

  test('new keys, the same conversation, contacts told first', () async {
    final sent = <Uint8List>[];
    final container = ProviderContainer(
      overrides: [
        relaySettingsProvider.overrideWith(_Offline.new),
        pushEnabledProvider.overrideWith(_NoPush.new),
        messagingServiceProvider.overrideWith((ref) {
          final service = _Recording(ref, sent);
          ref.onDispose(() => unawaited(service.dispose()));
          return service;
        }),
      ],
    );
    addTearDown(container.dispose);

    {
      await container.read(messagesControllerProvider.notifier).loaded;
      container.read(knownPeersControllerProvider.notifier).upsert(
            pubkeyHex: peerHex,
            displayName: 'Bob',
            signPublicKey: Uint8List(32),
          );
      container.read(messagesControllerProvider.notifier).append(
            peerHex,
            Message(
              id: 'm1',
              chatId: peerHex,
              text: 'hi',
              sentAt: DateTime(2026),
              isMine: true,
              wireId: 'w1',
            ),
          );
      final before = await container.read(identityProvider.future);

      await rotateAccountKeys(
        read: container.read,
        invalidate: container.invalidate,
      );

      final after = await container.read(identityProvider.future);
      expect(after.publicKey, isNot(equals(before.publicKey)));
      expect(after.signPublicKey, isNot(equals(before.signPublicKey)));

      final rotation = sent.single;
      expect(rotation.sublist(1, 33), before.publicKey,
          reason: 'sent while the old key was still ours');
      expect(rotation.sublist(33, 65), after.publicKey);
      expect(InnerPayloadType.keyRotation.tag, 0xED);

      expect(container.read(messagesControllerProvider)[peerHex], hasLength(1));
      expect(container.read(knownPeersControllerProvider)[peerHex], isNotNull);
    }
  });
}
