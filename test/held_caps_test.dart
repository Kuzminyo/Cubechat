import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// The total cap behind the two holds keyed by something the sender chooses:
/// frames awaiting their sender's announcement, by origin, and channel posts
/// awaiting the roster, by sender. Each was capped per key and not at all
/// across keys, so a fresh key per frame grew them without end.
void main() {
  final t0 = DateTime(2026, 11, 2, 12);
  DateTime at(int s) => t0.add(Duration(seconds: s));

  test('under the cap nothing is touched, stale or not', () {
    final held = {
      'a': [at(0), at(1)],
    };
    final dropped = MessagingService.trimHeldOldest<DateTime>(
      held,
      cap: 5,
      at: (d) => d,
      isFresh: (_) => false,
    );
    expect(dropped, 0);
    expect(held['a'], hasLength(2));
  });

  test('a thousand one-frame keys come down to the cap, newest kept', () {
    final held = <String, List<DateTime>>{};
    for (var i = 0; i < 1000; i++) {
      held['origin$i'] = [at(i)];
      MessagingService.trimHeldOldest<DateTime>(
        held,
        cap: 200,
        at: (d) => d,
        isFresh: (_) => true,
      );
    }
    expect(held.length, 200);
    expect(held.containsKey('origin999'), isTrue);
    expect(held.containsKey('origin799'), isFalse);
  });

  test('stale items go first, so a cap is not spent on them', () {
    final held = {
      'old': [at(0), at(1), at(2)],
      'new': [at(100), at(101)],
    };
    final dropped = MessagingService.trimHeldOldest<DateTime>(
      held,
      cap: 2,
      at: (d) => d,
      isFresh: (d) => d.isAfter(at(50)),
    );
    expect(dropped, 0);
    expect(held.keys, ['new']);
  });

  test('the oldest goes across keys, not within the key being added to', () {
    final held = {
      'quiet': [at(0)],
      'busy': [at(10), at(11), at(12)],
    };
    final dropped = MessagingService.trimHeldOldest<DateTime>(
      held,
      cap: 3,
      at: (d) => d,
      isFresh: (_) => true,
    );
    expect(dropped, 1);
    expect(held.containsKey('quiet'), isFalse);
    expect(held['busy'], hasLength(3));
  });
}
