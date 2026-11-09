import 'package:cubechat/core/widgets/unread_badge.dart';
import 'package:cubechat/core/widgets/value_pop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {bool reduced = false}) => MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: reduced),
        child: Scaffold(body: Center(child: child)),
      ),
    );

void main() {
  testWidgets('a first build shows the value with nothing moving',
      (tester) async {
    await tester.pumpWidget(_app(const UnreadBadge(count: 3)));
    expect(find.text('3'), findsOneWidget);
    expect(
      tester.hasRunningAnimations,
      isFalse,
      reason: 'a list of these appearing must not ripple',
    );
  });

  testWidgets('a new count pops in and leaves nothing running', (tester) async {
    await tester.pumpWidget(_app(const UnreadBadge(count: 3)));
    await tester.pumpWidget(_app(const UnreadBadge(count: 4)));
    expect(tester.hasRunningAnimations, isTrue);
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.text('3'), findsOneWidget, reason: 'still on its way out');
    expect(find.text('4'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('3'), findsNothing);
    expect(find.text('4'), findsOneWidget);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('counts that read the same do not pop', (tester) async {
    await tester.pumpWidget(_app(const UnreadBadge(count: 120)));
    await tester.pumpWidget(_app(const UnreadBadge(count: 121)));
    expect(find.text('99+'), findsOneWidget);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('with Reduce Motion the new value is simply there',
      (tester) async {
    await tester.pumpWidget(_app(const UnreadBadge(count: 3), reduced: true));
    await tester.pumpWidget(_app(const UnreadBadge(count: 4), reduced: true));
    await tester.pump();
    expect(find.text('4'), findsOneWidget);
    expect(find.text('3'), findsNothing);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('the size it takes does not grow with the pop', (tester) async {
    await tester.pumpWidget(
      _app(const ValuePop(value: 1, child: SizedBox(width: 40, height: 20))),
    );
    final before = tester.getSize(find.byType(ValuePop));
    await tester.pumpWidget(
      _app(const ValuePop(value: 2, child: SizedBox(width: 40, height: 20))),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.getSize(find.byType(ValuePop)), before);
    await tester.pumpAndSettle();
  });
}
