import 'package:cubechat/features/chat/data/send_queue.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chat/presentation/widgets/send_queue_sheet.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// On a crawling link the row above the chat list stops saying "waiting for a
/// connection" — the messages are not waiting for a road, they are going down
/// a slow one. Only the words change, and only while the queue is not empty.
class _Slow extends SlowNetworkController {
  _Slow(this.initial);

  final bool initial;

  @override
  bool build() => initial;
}

void main() {
  final alice = 'aa' * 32;

  Message mine(String id) => Message(
        id: id,
        chatId: alice,
        text: 'note $id',
        sentAt: DateTime(2026, 10, 20, 12),
        isMine: true,
        status: MessageStatus.sending,
        route: MessageRoute.queued,
        wireId: id.padRight(32, '0'),
      );

  Future<void> pump(
    WidgetTester tester, {
    required bool slow,
    required int queued,
    Locale locale = const Locale('en'),
  }) async {
    final queue = [
      for (var i = 0; i < queued; i++)
        QueuedMessage(chatId: alice, message: mine('q$i')),
    ];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sendQueueProvider.overrideWithValue(queue),
          slowNetworkProvider.overrideWith(() => _Slow(slow)),
        ],
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SendQueueEntry()),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('a slow link says it is sending, not waiting', (tester) async {
    await pump(tester, slow: true, queued: 2);
    expect(find.text('Slow network — sending 2 messages'), findsOneWidget);
    expect(find.text('2 messages waiting for a connection'), findsNothing);
  });

  testWidgets('a single message is singular', (tester) async {
    await pump(tester, slow: true, queued: 1);
    expect(find.text('Slow network — sending 1 message'), findsOneWidget);
  });

  testWidgets('a normal link keeps the old wording', (tester) async {
    await pump(tester, slow: false, queued: 2);
    expect(find.text('2 messages waiting for a connection'), findsOneWidget);
    expect(find.textContaining('Slow network'), findsNothing);
  });

  testWidgets('an empty queue shows nothing even on a slow link',
      (tester) async {
    await pump(tester, slow: true, queued: 0);
    expect(find.textContaining('Slow network'), findsNothing);
    expect(find.byIcon(Icons.cloud_off_rounded), findsNothing);
  });

  testWidgets('Ukrainian plural forms', (tester) async {
    await pump(tester, slow: true, queued: 1, locale: const Locale('uk'));
    expect(
      find.text('Повільна мережа — надсилаємо 1 повідомлення'),
      findsOneWidget,
    );
    await pump(tester, slow: true, queued: 3, locale: const Locale('uk'));
    expect(
      find.text('Повільна мережа — надсилаємо 3 повідомлення'),
      findsOneWidget,
    );
    await pump(tester, slow: true, queued: 5, locale: const Locale('uk'));
    expect(
      find.text('Повільна мережа — надсилаємо 5 повідомлень'),
      findsOneWidget,
    );
  });

  testWidgets('21 queued in Ukrainian reads 21, not 1', (tester) async {
    // `=1{…}` is emitted as the `one` form, and Ukrainian's `one` covers 21,
    // 31, 41… — so the literal "1" in it was shown for all of them.
    await pump(tester, slow: true, queued: 21, locale: const Locale('uk'));
    expect(
      find.text('Повільна мережа — надсилаємо 21 повідомлення'),
      findsOneWidget,
    );
  });

  testWidgets('the waiting row reads 21, not 1, in Ukrainian too',
      (tester) async {
    // Same pattern in the older string beside it.
    await pump(tester, slow: false, queued: 21, locale: const Locale('uk'));
    expect(
      find.text('21 повідомлення чекає на зв’язок'),
      findsOneWidget,
    );
    await pump(tester, slow: false, queued: 1, locale: const Locale('uk'));
    expect(
      find.text('1 повідомлення чекає на зв’язок'),
      findsOneWidget,
    );
  });
}
