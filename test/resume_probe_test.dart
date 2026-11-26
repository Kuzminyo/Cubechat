import 'dart:io';

import 'package:cubechat/core/util/debug_log.dart';
import 'package:cubechat/core/util/resume_probe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// One [RESUME] line per return, naming the steps that held the thread — so
/// the next "the app froze when I came back" log says which step it was.
void main() {
  testWidgets('a return writes one line with the slow step in it',
      (tester) async {
    // Lines reach the buffer through the debugPrint hook; put the original
    // back before the test ends, which testWidgets checks.
    final original = debugPrint;
    DebugLog.install();
    DebugLog.instance.clear();

    final probe = ResumeProbe.instance;
    probe.begin();
    probe.step('fast', () {});
    probe.step('slow', () => sleep(const Duration(milliseconds: 12)));
    probe.endHandler();
    expect(probe.sinceResume(), isNotNull);
    await tester.pump();

    final lines = DebugLog.instance.entries
        .map((e) => e.line)
        .where((l) => l.contains('[RESUME]'))
        .toList();
    debugPrint = original;
    DebugLog.instance.clear();

    expect(lines, hasLength(1));
    expect(lines.single, contains('slow'));
    expect(
      lines.single,
      isNot(contains('fast')),
      reason: 'steps under a millisecond are not the answer',
    );
    expect(lines.single, contains('first frame'));
  });

  test('outside a return, step just runs', () {
    expect(ResumeProbe.instance.step('x', () => 42), 42);
  });
}
