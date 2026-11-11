import 'package:cubechat/core/theme/app_theme.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/peers/presentation/contact_content_screen.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _NoMessages extends MessagesController {
  @override
  Map<String, List<Message>> build() => const {};
}

/// "Чтобы жестом можно было выходить с чужой профиль медиа": the tab view used
/// to take every horizontal drag, so a swipe back did nothing but at the edge.
void main() {
  Future<void> pump(WidgetTester tester, {int tab = 0}) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [messagesControllerProvider.overrideWith(_NoMessages.new)],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.dark(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ContactContentScreen(
                      chatId: 'peer',
                      contactName: 'Alice',
                      initialTab: tab,
                    ),
                  ),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(ContactContentScreen), findsOneWidget);
  }

  testWidgets('a swipe right in the middle of the first tab goes back',
      (tester) async {
    await pump(tester);
    await tester.dragFrom(const Offset(200, 500), const Offset(160, 0));
    await tester.pumpAndSettle();
    expect(find.byType(ContactContentScreen), findsNothing);
    expect(find.text('open'), findsOneWidget);
  });

  testWidgets('on a later tab a swipe right still goes to the tab before',
      (tester) async {
    await pump(tester, tab: 2);
    await tester.flingFrom(const Offset(200, 500), const Offset(300, 0), 1500);
    await tester.pumpAndSettle();
    expect(find.byType(ContactContentScreen), findsOneWidget);
    expect(
        DefaultTabController.of(
          tester.element(find.byType(TabBarView)),
        ).index,
        1);
  });

  testWidgets('a swipe left on the first tab still goes to the next tab',
      (tester) async {
    await pump(tester);
    await tester.flingFrom(const Offset(600, 500), const Offset(-300, 0), 1500);
    await tester.pumpAndSettle();
    expect(find.byType(ContactContentScreen), findsOneWidget);
    expect(
        DefaultTabController.of(
          tester.element(find.byType(TabBarView)),
        ).index,
        1);
  });
}
