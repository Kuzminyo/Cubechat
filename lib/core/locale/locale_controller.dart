import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Where the chosen language is stored.
///
/// Public because the push registration reads it directly instead of waiting
/// for this controller: registration runs at launch, [_restore] is
/// asynchronous, and whichever finishes first decides what the server is told.
/// A registration that wins that race would report `en` for a phone the user
/// set to Ukrainian, and the banner would arrive in the wrong language until
/// something re-registered.
const localePrefsKey = 'app.locale';

/// The languages this app is written in, each under its own name — the list
/// the language picker shows. A name is never translated: someone who cannot
/// read the current interface has to be able to find their own language in it.
///
/// Ukrainian and English first, as the two the app was written in; the rest
/// were added together on 2026-11-03.
const appLanguages = <String, String>{
  'uk': 'Українська',
  'en': 'English',
  'ru': 'Русский',
  'pl': 'Polski',
  'de': 'Deutsch',
  'es': 'Español',
  'fr': 'Français',
  'it': 'Italiano',
  'pt': 'Português',
  'tr': 'Türkçe',
  'cs': 'Čeština',
  'ro': 'Română',
  'kk': 'Қазақша',
  'ka': 'ქართული',
  'zh': '中文',
  'ja': '日本語',
  'ko': '한국어',
  'ar': 'العربية',
  'hi': 'हिन्दी',
};

/// What language to open in when nobody has ever chosen one.
///
/// This returned `const Locale('en')` — a constant, on every phone. `locale:`
/// is passed to MaterialApp unconditionally, and passing it *overrides*
/// Flutter's own resolution against the device, so the system language was
/// never consulted at all: a phone set to Ukrainian opened cubechat in English
/// and stayed there until somebody found the setting.
///
/// The notification is where that hurt, because it is the one screen the user
/// does not choose to look at. [_language] reports this same value to the push
/// server, so the doorbell that wakes a Ukrainian phone at night said "New
/// message" in English — reported as notifications arriving that mean nothing.
///
/// Belarusian resolves to Russian rather than to English: there is no `be`
/// translation, and of the ones that exist it is the one a Belarusian phone
/// can read. (Before `ru` existed, Russian and Belarusian both went to
/// Ukrainian on the same reasoning.) A phone set to anything not in
/// [appLanguages] still gets English.
Locale deviceLocale() =>
    localeForLanguage(PlatformDispatcher.instance.locale.languageCode);

/// The mapping behind [deviceLocale], separated so it can be tested without a
/// platform to ask.
@visibleForTesting
Locale localeForLanguage(String languageCode) {
  final code = languageCode.toLowerCase();
  if (appLanguages.containsKey(code)) return Locale(code);
  if (code == 'be') return const Locale('ru');
  return const Locale('en');
}

class LocaleController extends Notifier<Locale> {
  @override
  Locale build() {
    _restore();
    return deviceLocale();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(localePrefsKey);
    if (code != null && appLanguages.containsKey(code)) {
      state = Locale(code);
    }
  }

  Future<void> set(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(localePrefsKey, locale.languageCode);
  }
}

final localeControllerProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
