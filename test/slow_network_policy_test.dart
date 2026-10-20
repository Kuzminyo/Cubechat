import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// The rules [MessagingService] follows once the relay pool calls the link
/// slow — pure functions, so they are pinned here without standing a service
/// up. On a fast link every one of them must answer exactly what the code did
/// before the slow mode existed.
void main() {
  final now = DateTime(2026, 10, 20, 12);

  test('a fast link waits 1.5 s for a socket, a slow one 8 s', () {
    expect(
      MessagingService.relayWakeWaitFor(slow: false),
      const Duration(milliseconds: 1500),
    );
    expect(
      MessagingService.relayWakeWaitFor(slow: true),
      const Duration(seconds: 8),
    );
  });

  test('every heartbeat is due on a fast link', () {
    expect(
      MessagingService.heartbeatDue(
        slow: false,
        textWaiting: false,
        lastHeartbeat: now.subtract(const Duration(seconds: 5)),
        now: now,
      ),
      isTrue,
    );
    // A waiting text does not hold a fast link's heartbeat back either.
    expect(
      MessagingService.heartbeatDue(
        slow: false,
        textWaiting: true,
        lastHeartbeat: now.subtract(const Duration(seconds: 5)),
        now: now,
      ),
      isTrue,
    );
  });

  test('a slow link beats every 150 s', () {
    expect(
      MessagingService.heartbeatDue(
        slow: true,
        textWaiting: false,
        lastHeartbeat: now.subtract(const Duration(seconds: 100)),
        now: now,
      ),
      isFalse,
    );
    expect(
      MessagingService.heartbeatDue(
        slow: true,
        textWaiting: false,
        lastHeartbeat: now.subtract(const Duration(seconds: 150)),
        now: now,
      ),
      isTrue,
    );
    expect(
      MessagingService.heartbeatDue(
        slow: true,
        textWaiting: false,
        lastHeartbeat: null,
        now: now,
      ),
      isTrue,
    );
  });

  test('a slow link lets a waiting text go first', () {
    expect(
      MessagingService.heartbeatDue(
        slow: true,
        textWaiting: true,
        lastHeartbeat: null,
        now: now,
      ),
      isFalse,
    );
  });

  test('receipts gather for 30 s on a slow link', () {
    expect(
      MessagingService.readReceiptFlushGapFor(slow: true),
      const Duration(seconds: 30),
    );
    expect(
      MessagingService.readReceiptFlushGapFor(slow: false),
      const Duration(seconds: 5),
    );
  });

  test('the slow-network flag starts fast and follows what is published', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(slowNetworkProvider), isFalse);
    container.read(slowNetworkProvider.notifier).publish(true);
    expect(container.read(slowNetworkProvider), isTrue);
    container.read(slowNetworkProvider.notifier).publish(false);
    expect(container.read(slowNetworkProvider), isFalse);
  });
}
