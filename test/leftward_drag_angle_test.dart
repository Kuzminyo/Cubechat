import 'package:cubechat/core/routing/back_gesture.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// "Иногда влево делаю, но чуть вверх уходит — уходит вверх, а не влево": a
/// swipe to reply that drifts upward must still be the swipe, not a scroll.
void main() {
  late double swiped;
  late ScrollController scroll;

  Future<void> pump(WidgetTester tester) async {
    swiped = 0;
    scroll = ScrollController();
    addTearDown(scroll.dispose);
    await tester.pumpWidget(MaterialApp(
      home: ListView(
        controller: scroll,
        children: [
          for (var i = 0; i < 30; i++)
            RawGestureDetector(
              gestures: <Type, GestureRecognizerFactory>{
                LeftwardDragRecognizer: GestureRecognizerFactoryWithHandlers<
                    LeftwardDragRecognizer>(
                  LeftwardDragRecognizer.new,
                  (r) => r
                    ..dragStartBehavior = DragStartBehavior.down
                    ..onUpdate = (d) => swiped += d.delta.dx,
                ),
              },
              child: SizedBox(height: 60, child: Text('row $i')),
            ),
        ],
      ),
    ));
  }

  Future<void> drag(WidgetTester tester, List<Offset> steps) async {
    final gesture = await tester.startGesture(const Offset(400, 200));
    for (final step in steps) {
      await gesture.moveBy(step);
      await tester.pump();
    }
    await gesture.up();
    await tester.pumpAndSettle();
  }

  testWidgets('left with an upward drift is the swipe', (tester) async {
    await pump(tester);
    // Up a little faster than left at first, the way a thumb arcs, then left.
    await drag(tester, const [
      Offset(-5, -4),
      Offset(-10, -6),
      Offset(-30, -8),
      Offset(-30, -4),
    ]);
    expect(swiped, lessThan(-40));
    expect(scroll.offset, 0, reason: 'the list did not take it');
  });

  testWidgets('mostly up is still a scroll', (tester) async {
    await pump(tester);
    await drag(tester, const [
      Offset(-2, -8),
      Offset(-3, -40),
      Offset(-2, -60),
    ]);
    expect(swiped, 0);
    expect(scroll.offset, greaterThan(50));
  });

  testWidgets('right is handed back', (tester) async {
    await pump(tester);
    await drag(tester, const [Offset(8, 0), Offset(40, 0)]);
    expect(swiped, 0);
  });
}
