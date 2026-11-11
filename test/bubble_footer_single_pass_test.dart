import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chat/presentation/widgets/message_bubble.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/bubble_meta.dart';

/// A bubble with no reactions builds its clock row once.
///
/// It used to build it twice — an invisible copy in the column to size the
/// bubble, and the drawn one laid over it at the right. The row is three or
/// four paragraphs (route badge, lock, time, tick), and on the S24+ (1194,
/// 2026-11-10) it cost more than the message text itself: `meta.layout` 26-39
/// ms against `text.layout` 11-16 ms per scroll window. These pin the geometry
/// the copy existed for, so the one-pass layout cannot drift from it.
Message _message({required bool mine, required String text}) => Message(
      id: 'm1',
      chatId: 'peer',
      text: text,
      sentAt: DateTime(2026, 10, 1, 10, 11),
      isMine: mine,
      status: MessageStatus.read,
    );

Future<void> _pump(WidgetTester tester, Message m) async {
  tester.view.physicalSize = const Size(1080, 2000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: MessageBubble(message: m, chatId: 'peer')),
      ),
    ),
  );
  await tester.pump();
}

/// The drawn clock — while the invisible sizing copy existed, the one a tap
/// could reach.
Finder _clock() => bubbleClock('10:11').hitTestable().first;

/// The whole clock row — time, and on ours the tick after it. One paragraph
/// since 1200 (see `_BubbleMeta`), so the row is the paragraph.
Rect _row(WidgetTester tester) => tester.getRect(_clock());

/// The painted pane of the bubble: its rounded fill. (It was the clip around
/// the fill until 1200, which dropped the clip from bubbles whose content
/// sits inside padding.)
Rect _pane(WidgetTester tester) => tester.getRect(
      find
          .ancestor(
            of: _clock(),
            matching: find.byWidgetPredicate(
              (w) =>
                  w is DecoratedBox &&
                  w.decoration is BoxDecoration &&
                  (w.decoration as BoxDecoration).borderRadius != null,
            ),
          )
          .first,
    );

void main() {
  testWidgets('a first reaction keeps the text it was put on', (tester) async {
    const words = 'something worth reacting to';
    final plain = _message(mine: false, text: words);
    await _pump(tester, plain);
    final before = tester.renderObject(find.text(words));

    await _pump(
      tester,
      plain.copyWith(
        reactions: const {
          '👍': {'abcdef0123456789'},
        },
      ),
    );
    // The chip grows in; let it arrive.
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('👍').hitTestable(), findsOneWidget);
    // The same render object: the content was not unmounted and rebuilt
    // under a different parent when the reactions row arrived.
    expect(identical(tester.renderObject(find.text(words)), before), isTrue);
  });

  for (final mine in [true, false]) {
    final who = mine ? 'ours' : 'theirs';

    testWidgets('$who: the clock row is built once', (tester) async {
      await _pump(tester, _message(mine: mine, text: 'hello there'));
      expect(bubbleClock('10:11'), findsOneWidget);
    });

    testWidgets('$who, long text: the clock sits at the bottom right',
        (tester) async {
      await _pump(
        tester,
        _message(
          mine: mine,
          text: 'a message long enough to make its bubble properly wide',
        ),
      );
      final pane = _pane(tester);
      final text = tester.getRect(find.textContaining('a message long'));
      final clock = _row(tester);
      // 14 pt of padding on the right, 10 at the bottom.
      expect(pane.right - clock.right, closeTo(14, 4));
      expect(pane.bottom - clock.bottom, closeTo(10, 4));
      expect(clock.top, greaterThanOrEqualTo(text.bottom),
          reason: 'below the text, on its own line');
      expect(text.left - pane.left, closeTo(14, 1));
    });

    testWidgets('$who, short text: the bubble is as wide as the clock row',
        (tester) async {
      await _pump(tester, _message(mine: mine, text: 'k'));
      final pane = _pane(tester);
      final text = tester.getRect(find.text('k'));
      final clock = _row(tester);
      expect(pane.right - clock.right, closeTo(14, 4));
      expect(text.left - pane.left, closeTo(14, 1),
          reason: 'the text keeps the start, not the clock row');
      expect(pane.width, lessThan(200),
          reason: 'not stretched to the full width');
    });
  }
}
