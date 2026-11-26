import 'package:cubechat/core/util/keyboard_on_return.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Leave a chat mid-sentence, come back: the keyboard should be there, as it
/// was. Reported 2026-11-26 — Android dropped it on return.
void main() {
  late double inset;
  late KeyboardOnReturn keyboard;
  late FocusNode field;

  Future<void> pumpField(WidgetTester tester) async {
    field = FocusNode();
    addTearDown(field.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: TextField(focusNode: field)),
      ),
    );
    field.requestFocus();
    await tester.pump();
  }

  /// Out and back in, the order Android reports it.
  Future<bool> leaveAndReturn(
    WidgetTester tester, {
    bool locked = false,
  }) async {
    for (final s in [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
    ]) {
      keyboard.onLifecycle(s);
    }
    inset = 0; // gone while away
    tester.testTextInput.log.clear();
    for (final s in [
      AppLifecycleState.hidden,
      AppLifecycleState.inactive,
      AppLifecycleState.resumed,
    ]) {
      keyboard.onLifecycle(s, locked: locked);
    }
    await tester.pump();
    return tester.testTextInput.log
        .any((call) => call.method == 'TextInput.show');
  }

  setUp(() {
    inset = 0;
    keyboard = KeyboardOnReturn(keyboardInset: () => inset);
  });

  testWidgets('a keyboard that was up comes back with the app', (tester) async {
    await pumpField(tester);
    inset = 300;
    expect(await leaveAndReturn(tester), isTrue);
  });

  testWidgets('a keyboard put away before leaving stays away', (tester) async {
    // Back hides the keyboard and leaves the cursor in the field.
    await pumpField(tester);
    inset = 0;
    expect(await leaveAndReturn(tester), isFalse);
  });

  testWidgets('not behind the app lock', (tester) async {
    await pumpField(tester);
    inset = 300;
    expect(await leaveAndReturn(tester, locked: true), isFalse);
  });

  testWidgets('not when no text field has focus', (tester) async {
    await pumpField(tester);
    inset = 300;
    field.unfocus();
    await tester.pump();
    expect(await leaveAndReturn(tester), isFalse);
  });

  testWidgets('only the first inactive on the way out counts', (tester) async {
    // `inactive` comes again on the way back in, with the keyboard gone; it
    // must not overwrite what was seen on the way out.
    await pumpField(tester);
    inset = 300;
    keyboard.onLifecycle(AppLifecycleState.inactive);
    inset = 0;
    keyboard.onLifecycle(AppLifecycleState.paused);
    keyboard.onLifecycle(AppLifecycleState.inactive);
    tester.testTextInput.log.clear();
    keyboard.onLifecycle(AppLifecycleState.resumed);
    await tester.pump();
    expect(
      tester.testTextInput.log.any((c) => c.method == 'TextInput.show'),
      isTrue,
    );
  });
}
