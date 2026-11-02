import 'dart:async';
import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../core/notifications/notification_preview.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';
import '../../../l10n/app_localizations.dart';

/// Profile → Notifications → "Show in notifications": how much a banner may
/// say. See [NotificationPreview] for why it exists.
///
/// Installed into [NotificationService] the way quiet hours are, since that
/// service is called from the transport with no Riverpod of its own. Read in
/// `main` before the first frame, because a phone woken by a push composes its
/// banner without ever building a widget.
class NotificationPreviewController extends Notifier<NotificationPreview> {
  static const _key = 'notify.preview';

  Box<dynamic>? _box;
  Future<void>? _loading;

  /// Completes once the stored choice has been read.
  Future<void> get loaded => _loading ?? Future<void>.value();

  @override
  NotificationPreview build() {
    final service = NotificationService.instance;
    ref.listenSelf((_, next) => service.preview = next);
    // The stand-in words, in whatever language the app is set to.
    ref.listen<Locale>(
      localeControllerProvider,
      (_, locale) {
        final t = lookupAppLocalizations(locale);
        service.previewStrings =
            (appName: t.appName, newMessage: t.notifPreviewNewMessage);
      },
      fireImmediately: true,
    );
    _loading = _load();
    // The service waits for this before its first banner: a message that
    // arrives while the choice is still on the disk would otherwise go out
    // under the default, and the default shows everything.
    service.previewLoading = _loading;
    return NotificationPreview.full;
  }

  Future<void> _load() async {
    try {
      final box = await hiveCipherProvider
          .openEncryptedBox<dynamic>(HiveBoxes.settings);
      _box = box;
      state = NotificationPreview.fromWire(box.get(_key));
    } catch (e) {
      debugPrint('Notification preview load failed: $e');
    }
  }

  Future<void> set(NotificationPreview next) async {
    state = next;
    try {
      await _box?.put(_key, next.wire);
    } catch (e) {
      debugPrint('Notification preview persist failed: $e');
    }
  }

  /// Emergency Wipe: back to what a fresh install shows.
  Future<void> reset() async {
    state = NotificationPreview.full;
    try {
      await _box?.delete(_key);
    } catch (e) {
      debugPrint('Notification preview reset failed: $e');
    }
  }
}

final notificationPreviewProvider =
    NotifierProvider<NotificationPreviewController, NotificationPreview>(
  NotificationPreviewController.new,
);
