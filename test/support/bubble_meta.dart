import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The paragraph a bubble's clock line is drawn in.
///
/// Since 1200 the whole line — pin, lock, road mark, time and on ours the
/// tick — is one paragraph with the icons as glyphs of their font, so the
/// time is not a `Text` of its own for `find.text` to match.
Finder bubbleClock(String time, {bool skipOffstage = true}) =>
    find.byWidgetPredicate(
      (w) =>
          w is RichText &&
          w.text.toPlainText(includeSemanticsLabels: false).contains(time),
      description: 'the clock line holding "$time"',
      skipOffstage: skipOffstage,
    );

/// A paragraph that draws [icon] as a glyph — the clock line's marks.
Finder bubbleGlyph(IconData icon) => find.byWidgetPredicate(
      (w) => w is RichText && _draws(w.text, icon),
      description: 'a paragraph drawing $icon',
    );

bool _draws(InlineSpan span, IconData icon) {
  var found = false;
  span.visitChildren((s) {
    if (s is TextSpan &&
        s.text == String.fromCharCode(icon.codePoint) &&
        s.style?.fontFamily == icon.fontFamily) {
      found = true;
      return false;
    }
    return true;
  });
  return found;
}
