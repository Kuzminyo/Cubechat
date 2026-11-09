import 'package:cubechat/core/widgets/floating_glass.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chat/presentation/widgets/message_bubble.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _someone = 'abcdef0123456789';

Message _message(Map<String, Set<String>> reactions) => Message(
      id: 'm1',
      chatId: 'peer',
      text: 'a message long enough to make its bubble properly wide on screen',
      sentAt: DateTime(2026, 11, 9, 10, 11),
      isMine: false,
      reactions: reactions,
    );

Widget _app(Message m, {bool reduced = false}) => ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(
            size: const Size(360, 667),
            disableAnimations: reduced,
          ),
          // Aligned, so the bubble is as tall as it wants and not the screen.
          child: Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: MessageBubble(message: m, chatId: 'peer'),
            ),
          ),
        ),
      ),
    );

/// The drawn chip, not the invisible copy that holds the bubble's size.
Finder _drawn(String emoji) => find.text(emoji).hitTestable();

/// How much room the row of reactions has taken in the bubble, which is what
/// opens and closes it. None while the row is not there.
double _rowHeight(WidgetTester tester) {
  final row = find.byType(Wrap);
  return row.evaluate().isEmpty ? 0 : tester.getSize(row.first).height;
}

void main() {
  group('a reaction on a message', () {
    testWidgets('already there when the bubble is built does not animate',
        (tester) async {
      await tester.pumpWidget(_app(_message({'👍': {_someone}})));
      expect(_drawn('👍'), findsOneWidget);
      expect(
        tester.hasRunningAnimations,
        isFalse,
        reason: 'scrolling back to it must not replay anything',
      );
    });

    testWidgets('grows in, and the bubble opens with it', (tester) async {
      await tester.pumpWidget(_app(_message(const {})));
      expect(_rowHeight(tester), 0);

      await tester.pumpWidget(_app(_message({'👍': {_someone}})));
      await tester.pumpAndSettle();
      final full = _rowHeight(tester);
      expect(full, greaterThan(0));

      await tester.pumpWidget(_app(_message(const {})));
      await tester.pumpAndSettle();
      await tester.pumpWidget(_app(_message({'👍': {_someone}})));
      await tester.pump(const Duration(milliseconds: 60));
      final partWay = _rowHeight(tester);
      expect(partWay, greaterThan(0));
      expect(partWay, lessThan(full), reason: 'on its way, not already there');

      await tester.pumpAndSettle();
      expect(_rowHeight(tester), full);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('leaves by shrinking, and only then is gone', (tester) async {
      await tester.pumpWidget(_app(_message({'👍': {_someone}})));
      final full = _rowHeight(tester);

      await tester.pumpWidget(_app(_message(const {})));
      await tester.pump(const Duration(milliseconds: 80));
      expect(find.text('👍'), findsWidgets, reason: 'still on its way out');
      expect(_rowHeight(tester), lessThan(full));

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();
      expect(find.text('👍'), findsNothing);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('one leaving from the middle keeps its place', (tester) async {
      await tester.pumpWidget(
        _app(_message({'👍': {_someone}, '❤️': {_someone}, '🔥': {_someone}})),
      );
      await tester.pumpWidget(
        _app(_message({'👍': {_someone}, '🔥': {_someone}})),
      );
      await tester.pump(const Duration(milliseconds: 40));
      final heart = tester.getTopLeft(find.text('❤️').last).dx;
      expect(heart, greaterThan(tester.getTopLeft(find.text('👍').last).dx));
      expect(heart, lessThan(tester.getTopLeft(find.text('🔥').last).dx));
      await tester.pumpAndSettle();
      expect(find.text('❤️'), findsNothing);
    });

    testWidgets('put back while leaving comes back and stays', (tester) async {
      final on = _message({'👍': {_someone}});
      await tester.pumpWidget(_app(on));
      await tester.pumpWidget(_app(_message(const {})));
      await tester.pump(const Duration(milliseconds: 60));
      await tester.pumpWidget(_app(on));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_drawn('👍'), findsOneWidget);
    });

    testWidgets('with Reduce Motion is simply there, and simply gone',
        (tester) async {
      await tester.pumpWidget(_app(_message(const {}), reduced: true));
      await tester.pumpWidget(
        _app(_message({'👍': {_someone}}), reduced: true),
      );
      await tester.pump();
      expect(_drawn('👍'), findsOneWidget);
      expect(tester.hasRunningAnimations, isFalse);

      await tester.pumpWidget(_app(_message(const {}), reduced: true));
      await tester.pump();
      expect(find.text('👍'), findsNothing);
    });
  });

  group('a row under the finger', () {
    double scaleOf(WidgetTester tester) =>
        tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale;

    Widget row({bool blur = false}) => MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                FloatingGlass(
                  blur: blur,
                  onTap: () {},
                  child: const SizedBox(height: 80, child: Text('row')),
                ),
                const SizedBox(height: 2000),
              ],
            ),
          ),
        );

    testWidgets('settles while pressed and comes back', (tester) async {
      await tester.pumpWidget(row());
      final finger = await tester.startGesture(
        tester.getCenter(find.text('row')),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(scaleOf(tester), lessThan(1));
      await finger.up();
      await tester.pumpAndSettle();
      expect(scaleOf(tester), 1);
    });

    testWidgets('does not move for a finger starting a scroll', (tester) async {
      await tester.pumpWidget(row());
      final finger = await tester.startGesture(
        tester.getCenter(find.text('row')),
      );
      await tester.pump(const Duration(milliseconds: 20));
      await finger.moveBy(const Offset(0, -60));
      await tester.pump(const Duration(milliseconds: 200));
      expect(scaleOf(tester), 1);
      await finger.up();
      await tester.pumpAndSettle();
    });

    testWidgets('leaves a blurred pane alone', (tester) async {
      await tester.pumpWidget(row(blur: true));
      expect(find.byType(AnimatedScale), findsNothing);
    });
  });
}
