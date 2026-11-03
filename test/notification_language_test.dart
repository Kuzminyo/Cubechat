import 'dart:ui';

import 'package:cubechat/core/locale/locale_controller.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/nostr/nostr_transport.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// Two reports that turned out to be the same kind of fault: a line the app
/// prints without ever asking whether it is true.
///
/// "Уведомления приходят непонятные" was the app opening in English on a phone
/// that is not, because `locale:` was a constant and passing it to MaterialApp
/// overrides the device resolution that would otherwise have happened. The
/// notification is where it showed, since that is the one screen nobody
/// chooses to look at.
///
/// The relay receipt is the same shape from the other side: a count printed as
/// a verdict when nobody had finished collecting it.
void main() {
  group('the language the phone is in', () {
    test('a supported language is taken as it is', () {
      for (final code in appLanguages.keys) {
        expect(localeForLanguage(code), Locale(code), reason: code);
      }
    });

    test('every language offered has a translation behind it', () {
      // A name in the picker with no app_<code>.arb would switch to a locale
      // the delegate cannot load.
      final translated =
          AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
      expect(appLanguages.keys.toSet(), translated);
    });

    test('case does not decide it', () {
      expect(localeForLanguage('UK'), const Locale('uk'));
    });

    test('Belarusian lands on Russian, not English', () {
      // Deliberate second best. There is no `be` translation; the question is
      // only which of those that exist a Belarusian phone can read.
      expect(localeForLanguage('be'), const Locale('ru'));
    });

    test('anything else falls back to English', () {
      expect(localeForLanguage('nl'), const Locale('en'));
      expect(localeForLanguage(''), const Locale('en'));
    });
  });

  group('a publish receipt says what it actually knows', () {
    test('stopping at the first OK is not called silence', () {
      // The shape 304 of 310 publishes had in a shipped log. `silent: 2` read
      // as two dead relays; they were never asked.
      const receipt = PublishReceipt(sentTo: 3, accepted: 1, rejected: 0);
      final line = receipt.toString();
      expect(line, contains('ok: 1'));
      expect(line, contains('not waited for'));
      expect(line, isNot(contains('silent')));
    });

    test('a full count is printed as a full count', () {
      const receipt = PublishReceipt(sentTo: 3, accepted: 2, rejected: 1);
      expect(receipt.toString(), 'PublishReceipt(sent: 3, ok: 2, no: 1)');
    });

    test('nothing heard from anybody is still reported as silence', () {
      const receipt = PublishReceipt(sentTo: 3, accepted: 0, rejected: 0);
      final line = receipt.toString();
      expect(line, contains('no answer from 3'));
      expect(line, isNot(contains('ok:')));
    });

    test('a refusal with a straggler names both', () {
      const receipt = PublishReceipt(sentTo: 3, accepted: 0, rejected: 2);
      final line = receipt.toString();
      expect(line, contains('no answer from 1'));
      expect(line, contains('no: 2'));
    });
  });

  group('a frame waiting on an announcement that never comes', () {
    // The queue in a shipped log climbed 1, 2, 3 ... 17 over thirty-five
    // minutes with a one-minute TTL and no replay beside it, because the only
    // sweep lived on the announcement path. These pin the relationship that
    // made it invisible: at the arrival cadence in that log, a correctly swept
    // queue is a queue of one.
    final now = DateTime(2026, 9, 7, 15, 0);

    test('a frame from a moment ago is kept', () {
      expect(
        MessagingService.heldFrameIsFresh(
            now.subtract(const Duration(seconds: 30)), now),
        isTrue,
      );
    });

    test('a frame from the previous map beacon is not', () {
      // Ninety seconds is the beacon cadence, and it is longer than the TTL --
      // so each arrival should find the last one already expired.
      expect(
        MessagingService.heldFrameIsFresh(
            now.subtract(const Duration(seconds: 90)), now),
        isFalse,
      );
    });

    test('the boundary itself is kept, not dropped', () {
      expect(
        MessagingService.heldFrameIsFresh(
            now.subtract(const Duration(minutes: 1)), now),
        isTrue,
      );
    });
  });
}
