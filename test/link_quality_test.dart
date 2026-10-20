import 'package:cubechat/core/transport/nostr/link_quality.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const floor = Duration(seconds: 2);
  const slowAck = Duration(milliseconds: 2400);
  const fastAck = Duration(milliseconds: 300);

  test('starts fast and keeps the floor', () {
    final m = LinkQualityMeter();
    expect(m.isSlow, isFalse);
    expect(m.ackTimeout(floor: floor), floor);
    expect(m.probeTimeout(floor: floor), floor);
    m.dispose();
  });

  test('three slow acks make it slow and stretch the wait', () {
    final m = LinkQualityMeter();
    for (var i = 0; i < 3; i++) {
      m.recordAck('a', slowAck);
    }
    expect(m.isSlow, isTrue);
    expect(m.ackTimeout(floor: floor), const Duration(milliseconds: 9600));
    // 2.4 s x 3 = 7.2 s for the probe.
    expect(m.probeTimeout(floor: floor), const Duration(milliseconds: 7200));
    m.dispose();
  });

  test('two slow acks are not enough to call it slow', () {
    final m = LinkQualityMeter();
    for (var i = 0; i < 2; i++) {
      m.recordAck('a', slowAck);
    }
    expect(m.isSlow, isFalse);
    m.dispose();
  });

  test('the wait never passes fifteen seconds', () {
    final m = LinkQualityMeter();
    for (var i = 0; i < 3; i++) {
      m.recordAck('a', const Duration(seconds: 6));
    }
    expect(m.isSlow, isTrue);
    expect(m.ackTimeout(floor: floor), const Duration(seconds: 15));
    expect(m.probeTimeout(floor: floor), const Duration(seconds: 10));
    m.dispose();
  });

  test('two silences in a row make it slow', () {
    final m = LinkQualityMeter();
    m.recordSilence('a');
    expect(m.isSlow, isFalse);
    m.recordSilence('b');
    expect(m.isSlow, isTrue);
    expect(m.ackTimeout(floor: floor), const Duration(seconds: 10));
    expect(m.probeTimeout(floor: floor), const Duration(seconds: 6));
    m.dispose();
  });

  test('an ack between two silences breaks the run', () {
    final m = LinkQualityMeter();
    m.recordSilence('a');
    m.recordAck('a', fastAck);
    m.recordSilence('a');
    expect(m.isSlow, isFalse);
    m.dispose();
  });

  test('one slow public handshake beside fast acks does not enter', () {
    // A sluggish public relay, or nine handshakes at once on an iOS resume
    // over middling LTE: one connect past 5 s is not the link.
    final m = LinkQualityMeter();
    for (var i = 0; i < 3; i++) {
      m.recordAck('ours', fastAck);
    }
    m.recordConnect('nostr.mom', const Duration(seconds: 6));
    expect(m.isSlow, isFalse);
    m.dispose();
  });

  test('two slow connects from two relays make it slow', () {
    final m = LinkQualityMeter();
    m.recordConnect('a', const Duration(milliseconds: 4900));
    m.recordConnect('b', const Duration(milliseconds: 4900));
    expect(m.isSlow, isFalse, reason: 'under 5 s is not slow');
    m.recordConnect('a', const Duration(milliseconds: 5100));
    expect(m.isSlow, isFalse, reason: 'one slow connect is not corroborated');
    m.recordConnect('b', const Duration(milliseconds: 5100));
    expect(m.isSlow, isTrue);
    m.dispose();
  });

  test('one relay reconnecting slowly twice is still one witness', () {
    final m = LinkQualityMeter();
    m.recordConnect('a', const Duration(seconds: 6));
    m.recordConnect('a', const Duration(seconds: 6));
    expect(m.isSlow, isFalse);
    m.dispose();
  });

  test('slow connects a minute apart do not corroborate each other', () {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    m.recordConnect('a', const Duration(seconds: 6));
    now = now.add(const Duration(seconds: 61));
    m.recordConnect('b', const Duration(seconds: 6));
    expect(m.isSlow, isFalse);
    m.dispose();
  });

  test('a slow connect of our own relay makes it slow on its own', () {
    final m = LinkQualityMeter();
    m.recordConnect('ours', const Duration(seconds: 6), anchor: true);
    expect(m.isSlow, isTrue);
    m.dispose();
  });

  test('leaving slow mode then one slow reconnect does not re-enter', () {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    m.recordSilence('a');
    m.recordSilence('b');
    expect(m.isSlow, isTrue);
    now = now.add(const Duration(seconds: 31));
    for (var i = 0; i < 4; i++) {
      m.recordAck('a', fastAck);
    }
    expect(m.isSlow, isFalse);
    // The exit reopens every let-go socket at once; one of them is slow.
    now = now.add(const Duration(seconds: 5));
    m.recordConnect('a', const Duration(seconds: 6));
    expect(m.isSlow, isFalse);
    m.dispose();
  });

  test('inside the minute after leaving, no connect counts at all', () {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    m.recordSilence('a');
    m.recordSilence('b');
    now = now.add(const Duration(seconds: 31));
    for (var i = 0; i < 4; i++) {
      m.recordAck('a', fastAck);
    }
    expect(m.isSlow, isFalse);
    now = now.add(const Duration(seconds: 5));
    m.recordConnect('a', const Duration(seconds: 6));
    m.recordConnect('b', const Duration(seconds: 6));
    m.recordConnect('ours', const Duration(seconds: 6), anchor: true);
    expect(m.isSlow, isFalse);
    // Past the minute, connects are evidence again.
    now = now.add(const Duration(seconds: 60));
    m.recordConnect('ours', const Duration(seconds: 6), anchor: true);
    expect(m.isSlow, isTrue);
    m.dispose();
  });

  test('one fast ack does not end slow mode', () {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    for (var i = 0; i < 3; i++) {
      m.recordAck('a', slowAck);
    }
    expect(m.isSlow, isTrue);
    now = now.add(const Duration(seconds: 31));
    m.recordAck('a', fastAck);
    expect(m.isSlow, isTrue);
    m.dispose();
  });

  test('four fast acks inside the dwell do not end slow mode', () {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    m.recordSilence('a');
    m.recordSilence('a');
    expect(m.isSlow, isTrue);
    now = now.add(const Duration(seconds: 10));
    for (var i = 0; i < 4; i++) {
      m.recordAck('a', fastAck);
    }
    expect(m.isSlow, isTrue);
    m.dispose();
  });

  test('a fast ack above the exit bar keeps slow mode', () {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    m.recordSilence('a');
    m.recordSilence('a');
    now = now.add(const Duration(seconds: 31));
    // 800 ms is not "< 800 ms".
    for (var i = 0; i < 4; i++) {
      m.recordAck('a', const Duration(milliseconds: 800));
    }
    expect(m.isSlow, isTrue);
    m.dispose();
  });

  test('exits after four fast acks once the dwell has passed', () async {
    var now = DateTime(2026, 10, 20, 12);
    final m = LinkQualityMeter(clock: () => now);
    final seen = <bool>[];
    final sub = m.changes.listen(seen.add);

    // Airplane mode: silence, then silence, then the link is back.
    m.recordSilence('a');
    m.recordSilence('b');
    expect(m.isSlow, isTrue);

    now = now.add(const Duration(seconds: 10));
    for (var i = 0; i < 4; i++) {
      m.recordAck('a', fastAck);
    }
    expect(m.isSlow, isTrue, reason: 'dwell has not passed yet');

    now = now.add(const Duration(seconds: 21));
    for (var i = 0; i < 4; i++) {
      m.recordAck('a', fastAck);
    }
    expect(m.isSlow, isFalse);
    // Fast again: 300 ms x 4 is under the floor, so the floor wins.
    expect(m.ackTimeout(floor: floor), floor);

    await Future<void>.delayed(Duration.zero);
    expect(seen, <bool>[true, false]);
    await sub.cancel();
    m.dispose();
  });

  test('changes fires only on transitions', () async {
    final m = LinkQualityMeter();
    final seen = <bool>[];
    final sub = m.changes.listen(seen.add);
    for (var i = 0; i < 6; i++) {
      m.recordAck('a', slowAck);
    }
    await Future<void>.delayed(Duration.zero);
    expect(seen, <bool>[true]);
    await sub.cancel();
    m.dispose();
  });

  test('fastestOf picks the lowest median and ignores unmeasured urls', () {
    final m = LinkQualityMeter();
    m.recordAck('a', const Duration(milliseconds: 900));
    m.recordAck('b', const Duration(milliseconds: 400));
    expect(m.fastestOf(<String>['a', 'b']), 'b');
    expect(m.fastestOf(<String>['a', 'b', 'c']), 'b');
    expect(m.fastestOf(<String>['c']), isNull);
    expect(m.fastestOf(const <String>[]), isNull);
    m.dispose();
  });

  test('describe reads like a log line', () {
    final m = LinkQualityMeter();
    expect(m.describe(), 'ok-median n/a, connect n/a');
    for (var i = 0; i < 3; i++) {
      m.recordAck('a', slowAck);
    }
    m.recordConnect('a', const Duration(milliseconds: 7100));
    expect(m.describe(), 'ok-median 2.4 s, connect 7.1 s');
    m.dispose();
  });
}
