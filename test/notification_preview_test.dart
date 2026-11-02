import 'dart:io';
import 'dart:ui' show Locale;

import 'package:cubechat/core/locale/locale_controller.dart';
import 'package:cubechat/core/notifications/notification_preview.dart';
import 'package:cubechat/core/notifications/notification_service.dart';
import 'package:cubechat/features/profile/data/notification_preview_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/hive_settle.dart';

/// How much a notification may show of a message.
///
/// What matters: under "name only" and "nothing" the text never reaches the
/// banner, under "nothing" the sender does not either, and the choice is in
/// the notification service — which has no Riverpod of its own — by the time
/// the stored value has been read, including after a restart.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ({String title, String body}) redact(NotificationPreview p) => p.redact(
        title: 'Olena',
        body: 'meet at the north gate at 9',
        appName: 'Cubechat',
        newMessage: 'New message',
      );

  group('redact', () {
    test('full shows the sender and the text', () {
      expect(
        redact(NotificationPreview.full),
        (title: 'Olena', body: 'meet at the north gate at 9'),
      );
    });

    test('name only keeps the sender and drops the text', () {
      expect(
        redact(NotificationPreview.nameOnly),
        (title: 'Olena', body: 'New message'),
      );
    });

    test('nothing drops both', () {
      expect(
        redact(NotificationPreview.hidden),
        (title: 'Cubechat', body: 'New message'),
      );
    });

    test('the stored word round-trips, and anything else reads as full', () {
      for (final p in NotificationPreview.values) {
        expect(NotificationPreview.fromWire(p.wire), p);
      }
      expect(NotificationPreview.fromWire(null), NotificationPreview.full);
      expect(NotificationPreview.fromWire('garbage'), NotificationPreview.full);
    });
  });

  group('controller', () {
    late Directory tempDir;
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({localePrefsKey: 'uk'});
      tempDir = await Directory.systemTemp.createTemp('cubechat_notif_prev_');
      Hive.init(tempDir.path);
      container = ProviderContainer();
    });

    tearDown(() async {
      await settleBackgroundStorage();
      container.dispose();
      await Hive.close();
      NotificationService.instance.preview = NotificationPreview.full;
      NotificationService.instance.previewLoading = null;
      try {
        if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
      } on FileSystemException {
        // Windows can retain a Hive handle briefly after close.
      }
    });

    test('a fresh install shows everything', () async {
      final c = container.read(notificationPreviewProvider.notifier);
      await c.loaded;
      expect(container.read(notificationPreviewProvider),
          NotificationPreview.full);
      expect(NotificationService.instance.preview, NotificationPreview.full);
    });

    test('a choice reaches the service and survives a restart', () async {
      final c = container.read(notificationPreviewProvider.notifier);
      await c.loaded;
      await c.set(NotificationPreview.hidden);
      expect(NotificationService.instance.preview, NotificationPreview.hidden);
      await settleBackgroundStorage();

      // A restart: the service is a singleton that outlives the container, so
      // put it back to the default to prove the read is what restores it.
      NotificationService.instance.preview = NotificationPreview.full;
      final next = ProviderContainer();
      addTearDown(next.dispose);
      next.read(notificationPreviewProvider.notifier);
      // What the service itself waits on before its first banner.
      await NotificationService.instance.previewLoading;
      expect(NotificationService.instance.preview, NotificationPreview.hidden);
    });

    test('the stand-in words follow the app language', () async {
      final c = container.read(notificationPreviewProvider.notifier);
      await c.loaded;
      // The stored language arrives off SharedPreferences after the first
      // build; wait for it the way the app does, by its state changing.
      await container.read(localeControllerProvider.notifier).set(
            const Locale('uk'),
          );
      expect(
        NotificationService.instance.previewStrings.newMessage,
        'Нове повідомлення',
      );
    });

    test('a wipe goes back to showing everything', () async {
      final c = container.read(notificationPreviewProvider.notifier);
      await c.loaded;
      await c.set(NotificationPreview.nameOnly);
      await c.reset();
      expect(NotificationService.instance.preview, NotificationPreview.full);
    });
  });
}
