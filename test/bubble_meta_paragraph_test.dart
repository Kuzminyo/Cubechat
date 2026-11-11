import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/util/transition_probe.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chat/presentation/widgets/message_bubble.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/bubble_meta.dart';

/// The clock line is one paragraph since 1200 (see `_BubbleMeta`): the road
/// mark, the time and the tick as glyphs in one `Text.rich`, where 1199 had a
/// row of an Icon, a Text, gaps and a switcher round the tick. What has to
/// survive that: the size of the line, what it says to a screen reader, and
/// the tick popping when it changes.
Message _ours(MessageStatus status, {bool mine = true, String id = 'm1'}) =>
    Message(
      id: id,
      wireId: 'w1',
      chatId: 'peer',
      text: 'hello there',
      sentAt: DateTime(2026, 10, 1, 10, 11),
      isMine: mine,
      status: status,
      route: MessageRoute.bluetooth,
    );

/// The fonts the phone draws with. The test font's metrics are nothing like
/// Inter's or the icon font's, and the question here is whether a line of
/// glyphs comes out the size a row of widgets did — so it is asked in the
/// real ones.
Future<void> _loadFonts() async {
  final inter = FontLoader('Inter')
    ..addFont(_bytes(File('assets/fonts/Inter-Regular.ttf')));
  await inter.load();
  final root = Platform.environment['FLUTTER_ROOT'];
  final icons = File(
    '$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (root != null && icons.existsSync()) {
    final loader = FontLoader('MaterialIcons')..addFont(_bytes(icons));
    await loader.load();
  }
}

Future<ByteData> _bytes(File file) async =>
    ByteData.sublistView(await file.readAsBytes());

Future<void> _pump(WidgetTester tester, Message m) async {
  tester.view.physicalSize = const Size(1080, 2000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(fontFamily: 'Inter'),
        home: Scaffold(body: MessageBubble(message: m, chatId: 'peer')),
      ),
    ),
  );
  await tester.pump();
}

/// Every paragraph that draws [icon].
int _drawn(WidgetTester tester, IconData icon) =>
    tester.widgetList(bubbleGlyph(icon)).length;

/// The painted pane of the bubble: its rounded fill.
Rect _pane(WidgetTester tester) => tester.getRect(
      find
          .byWidgetPredicate(
            (w) =>
                w is DecoratedBox &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).borderRadius != null,
          )
          .first,
    );

void main() {
  setUpAll(_loadFonts);
  tearDown(() => TransitionProbe.instance.previousChat.value = false);

  testWidgets('at rest the road, the time and the tick are one paragraph',
      (tester) async {
    await _pump(tester, _ours(MessageStatus.read));
    final line = bubbleClock('10:11');
    expect(line, findsOneWidget);
    final text = (tester.widget(line) as RichText)
        .text
        .toPlainText(includeSemanticsLabels: false);
    expect(text, contains(String.fromCharCode(Icons.bluetooth_rounded.codePoint)));
    expect(text, contains(String.fromCharCode(Icons.done_all_rounded.codePoint)));
    expect(find.byType(Icon), findsNothing,
        reason: 'no Icon widget left in a plain bubble');
  });

  testWidgets('it says what the row of icons said', (tester) async {
    final semantics = tester.ensureSemantics();
    await _pump(tester, _ours(MessageStatus.read));
    final t = AppLocalizations.of(tester.element(find.byType(MessageBubble)));
    // The bubble's nodes merge into the row's, so the line is a part of
    // what the message reads as, in its order.
    final label = tester.getSemantics(bubbleClock('10:11')).label;
    expect(
      label,
      contains('${t.chatRouteBluetoothDirect} 10:11 ${t.chatRead}'),
    );
    semantics.dispose();
  });

  testWidgets('the tick still pops when it changes, then rejoins the line',
      (tester) async {
    await _pump(tester, _ours(MessageStatus.delivered));
    final before = tester.getRect(bubbleClock('10:11'));
    expect(_drawn(tester, Icons.done_rounded), 1);

    await _pump(tester, _ours(MessageStatus.read));
    // Mid-pop: the old tick shrinking away and the new one growing in, each
    // a paragraph of its own beside the line.
    await tester.pump(const Duration(milliseconds: 60));
    expect(_drawn(tester, Icons.done_rounded), 1);
    expect(_drawn(tester, Icons.done_all_rounded), 1);
    Finder scaling() => find.descendant(
          of: find.byType(MessageBubble),
          matching: find.byType(ScaleTransition),
        );
    expect(scaling(), findsNWidgets(2));

    await tester.pump(const Duration(milliseconds: 400));
    expect(scaling(), findsNothing,
        reason: 'nothing animating is left once the pop is over');
    expect(_drawn(tester, Icons.done_rounded), 0);
    expect(_drawn(tester, Icons.done_all_rounded), 1);
    final after = tester.getRect(bubbleClock('10:11'));
    expect(after.size, before.size,
        reason: 'one glyph for another: the line does not change size');
  });

  for (final mine in [true, false]) {
    final who = mine ? 'ours' : 'theirs';
    testWidgets('$who: the bubble is the size the row of widgets made it',
        (tester) async {
      TransitionProbe.instance.previousChat.value = true;
      await _pump(tester, _ours(MessageStatus.read, mine: mine));
      expect(find.byIcon(Icons.bluetooth_rounded), findsOneWidget,
          reason: 'the 1199 row, for the comparison run');
      final old = _pane(tester);
      final oldRow = tester.getRect(
        find
            .ancestor(of: find.text('10:11'), matching: find.byType(Row))
            .first,
      );

      TransitionProbe.instance.previousChat.value = false;
      // A different key, so the bubble is built afresh in the new shape.
      await _pump(tester, _ours(MessageStatus.read, mine: mine, id: 'm2'));
      final now = _pane(tester);
      final line = tester.getRect(bubbleClock('10:11'));
      // Measured in Inter and the icon font on 1200: the panes identical,
      // the line within 0.3 pt of the row at its left edge.
      expect(now.height, closeTo(old.height, 0.5),
          reason: 'the line keeps the height the row had');
      expect(now.width, closeTo(old.width, 0.5),
          reason: 'the gaps are the row\'s 4 pt, as letter spacing');
      expect(line.top, closeTo(oldRow.top, 0.5));
      expect(line.bottom, closeTo(oldRow.bottom, 0.5));
      expect(line.right, closeTo(oldRow.right, 0.5));
      expect(line.left, closeTo(oldRow.left, 0.5));
    });
  }
}
