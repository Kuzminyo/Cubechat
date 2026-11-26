import 'package:flutter/widgets.dart';

/// Brings the keyboard back when the app returns to a text field that had it
/// open when the app was left.
///
/// Leave a chat mid-sentence, come back, and on Android the keyboard was gone:
/// the window comes forward with a snapshot that still shows it, then Android
/// drops it because nothing on the Flutter side asks for it again. The field
/// still has focus and the cursor still blinks, so you tap the field you are
/// already in to keep typing. Reported 2026-11-26 as "the keyboard should not
/// close when you come back".
///
/// It also took the bug that made the map a keyboard short with it: Android
/// started restoring the keyboard and hid it again mid-animation, and the
/// engine kept the inset of a keyboard that was no longer there (see
/// `resyncInsetsAfterKeyboard` in MainActivity). Asked for again, the keyboard
/// arrives and stays, and there is no hide to race.
///
/// Only when the keyboard was actually up on the way out. A field can hold
/// focus with the keyboard put away — Back hides the keyboard and leaves the
/// cursor where it was — and opening it again on return would undo something
/// the person did on purpose.
class KeyboardOnReturn {
  KeyboardOnReturn({double Function()? keyboardInset})
      : _keyboardInset = keyboardInset ?? _viewInset;

  final double Function() _keyboardInset;

  bool _wasUp = false;

  static double _viewInset() {
    final views = WidgetsBinding.instance.platformDispatcher.views;
    return views.isEmpty ? 0 : views.first.viewInsets.bottom;
  }

  /// Feed every lifecycle change. [locked] is whether the app lock is showing
  /// on return: then the keyboard belongs to the lock screen's own field, not
  /// to a chat hidden behind it.
  void onLifecycle(AppLifecycleState state, {bool locked = false}) {
    switch (state) {
      case AppLifecycleState.inactive:
        // The first step out, and the last moment the keyboard is still on
        // screen. Read once: `inactive` comes again on the way back in, when
        // the keyboard is already gone, and must not overwrite the answer.
        if (!_leaving) {
          _leaving = true;
          _wasUp = _keyboardInset() > 0;
        }
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _leaving = true;
      case AppLifecycleState.resumed:
        final wasUp = _wasUp;
        _leaving = false;
        _wasUp = false;
        if (!wasUp || locked) return;
        // After the frame: the route the field lives on has to be built and
        // attached again before it can take the keyboard.
        WidgetsBinding.instance
          ..addPostFrameCallback((_) => _reopen())
          ..scheduleFrame();
      case AppLifecycleState.detached:
        _leaving = false;
        _wasUp = false;
    }
  }

  bool _leaving = false;

  static void _reopen() {
    // EditableText hands its focus node to a Focus it builds below itself, so
    // the field is the nearest EditableText above the focused element. A
    // focused button or list has none, and gets nothing.
    final state = FocusManager.instance.primaryFocus?.context
        ?.findAncestorStateOfType<EditableTextState>();
    if (state == null || !state.mounted || state.widget.readOnly) return;
    state.requestKeyboard();
  }
}
