import 'dart:io';

import 'package:cubechat/features/profile/presentation/customize_screen.dart';
import 'package:cubechat/features/profile/presentation/profile_screen.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/hive_settle.dart';

/// Every settings screen, in every language, on a narrow phone.
///
/// Seventeen languages arrived at once on 2026-11-03, written against an
/// interface laid out for Ukrainian and English. A label that no longer fits
/// throws an overflow here rather than on somebody's phone. The test font
/// draws every glyph a full em wide, wider than any real one, so a screen
/// that passes here has room to spare in practice. Arabic also runs the whole
/// screen right to left.
void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_locales_');
    Hive.init(tempDir.path);
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    await settleBackgroundStorage();
    await Hive.close();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  final screens = <String, Widget>{
    'appearance': const CustomizeScreen(),
    'privacy': const PrivacySectionScreen(),
    'notifications': const NotificationsSectionScreen(),
    'connection': const ConnectionSectionScreen(),
    'chats': const ChatsSectionScreen(),
    'data': const DataSectionScreen(),
  };

  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('settings fit a 360 phone in ${locale.languageCode}',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 4000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      for (final entry in screens.entries) {
        await tester.pumpWidget(
          ProviderScope(
            key: ValueKey(entry.key),
            child: MaterialApp(
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData.dark(useMaterial3: true),
              home: entry.value,
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 400));
        expect(tester.takeException(), isNull, reason: entry.key);
      }
    });
  }
}
