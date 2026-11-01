import 'dart:async';
import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../storage/hive_cipher.dart';
import '../storage/hive_init.dart';
import '../util/debug_log.dart';
import 'desktop_presence.dart';

const _autostartKey = 'desktop.autostart';

/// Bring a Windows computer onto the tray at launch — see [DesktopPresence].
/// After `runApp`, not awaited: nothing in it decides the first frame.
Future<void> startDesktopPresence(List<String> args) async {
  if (!desktopPresenceSupported) return;
  // The system's language, since the app's own choice is not loaded yet; the
  // tray says two words and Windows draws them, not Flutter.
  final t = lookupAppLocalizations(_supported(PlatformDispatcher.instance.locale));
  try {
    await DesktopPresence(
      shell: PluginDesktopShell(),
      loadAutostart: () async {
        try {
          final box = await hiveCipherProvider
              .openEncryptedBox<dynamic>(HiveBoxes.settings);
          final on = box.get(_autostartKey);
          // On unless switched off: the owner's ruling (2026-11-01).
          return on is bool ? on : true;
        } catch (_) {
          return true;
        }
      },
      saveAutostart: (on) async {
        final box = await hiveCipherProvider
            .openEncryptedBox<dynamic>(HiveBoxes.settings);
        await box.put(_autostartKey, on);
      },
    ).start(
      launchedHidden: args.contains(kLaunchHiddenArg),
      openLabel: t.trayOpen,
      quitLabel: t.trayQuit,
    );
  } catch (e) {
    // Without the tray the computer still works, as it did before it.
    DebugLog.instance.log('DESKTOP', 'tray not started: $e');
  }
}

Locale _supported(Locale locale) =>
    AppLocalizations.supportedLocales.any(
      (l) => l.languageCode == locale.languageCode,
    )
        ? Locale(locale.languageCode)
        : const Locale('en');

/// The «Запускати разом із Windows» switch. Reads and writes through the
/// running [DesktopPresence]; false, and nothing to change, elsewhere.
class DesktopAutostartController extends Notifier<bool> {
  @override
  bool build() => DesktopPresence.instance?.autostart ?? false;

  Future<void> set(bool on) async {
    final presence = DesktopPresence.instance;
    if (presence == null) return;
    await presence.setAutostart(on);
    state = presence.autostart;
  }
}

final desktopAutostartProvider =
    NotifierProvider<DesktopAutostartController, bool>(
  DesktopAutostartController.new,
);
