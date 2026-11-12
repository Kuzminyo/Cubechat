import 'package:cubechat/features/map/data/map_presence_controller.dart';
import 'package:flutter_test/flutter_test.dart';

/// Which positions reach a friend's map. The numbers are from two field logs
/// of 2026-11-09, where pins jumped across the world and back.
void main() {
  bool believable(
    int accuracy, {
    double? metres,
    Duration? since,
  }) =>
      MapPresenceController.fixIsBelievable(
        accuracyMetres: accuracy,
        metresFromLast: metres,
        sinceLast: since,
      );

  const minutes = Duration(minutes: 5);

  test('a position with no real accuracy never goes out', () {
    expect(believable(65535), isFalse, reason: 'the field\'s ceiling');
    expect(believable(18379), isFalse, reason: 'a coarse network guess');
    expect(believable(65535, metres: 10, since: minutes), isFalse);
  });

  test('a vague fix far beyond any journey is refused', () {
    expect(believable(3365, metres: 10682688, since: minutes), isFalse);
  });

  test('a vague fix close enough to be true is kept', () {
    expect(believable(2272, metres: 1542, since: minutes), isTrue);
    expect(believable(3365), isTrue, reason: 'nothing to compare it with');
  });

  test('a long gap makes a long way possible', () {
    expect(
      believable(3000, metres: 5000000, since: const Duration(hours: 6)),
      isTrue,
      reason: 'somebody who flew with the app shut',
    );
  });

  test('a sharp fix is believed however far it went', () {
    expect(
      believable(5, metres: 14148427, since: minutes),
      isTrue,
      reason: 'or a bad point that got through could never be replaced',
    );
  });

  test('the first fix has nothing to be measured against', () {
    expect(believable(10), isTrue);
  });
}
