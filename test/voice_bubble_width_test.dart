import 'package:cubechat/features/chat/presentation/widgets/voice_bubble.dart';
import 'package:flutter_test/flutter_test.dart';

/// A short voice note is drawn the size of a short text, not of a long story.
void main() {
  test('a short note is narrow, a long one has the full width', () {
    expect(voiceBubbleWidth(Duration.zero), 140);
    expect(voiceBubbleWidth(const Duration(seconds: 2)), 146);
    expect(voiceBubbleWidth(const Duration(seconds: 20)), 200);
    expect(voiceBubbleWidth(const Duration(minutes: 3)), 200);
  });

  test('a longer note is never drawn narrower than a shorter one', () {
    var last = 0.0;
    for (var s = 0; s <= 30; s++) {
      final width = voiceBubbleWidth(Duration(seconds: s));
      expect(width, greaterThanOrEqualTo(last), reason: '$s s');
      last = width;
    }
  });
}
