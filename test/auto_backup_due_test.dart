import 'package:cubechat/features/backup/data/auto_backup_controller.dart';
import 'package:flutter_test/flutter_test.dart';

/// The automatic backup runs at launch and on every return to the app; what
/// keeps that from rewriting the file on every unlock is this one question.
void main() {
  final now = DateTime(2026, 11, 3, 18);

  test('a phone that never made a copy owes one', () {
    expect(autoBackupDue(last: null, now: now), isTrue);
  });

  test('a copy from this morning is enough for today', () {
    expect(
      autoBackupDue(last: now.subtract(const Duration(hours: 9)), now: now),
      isFalse,
    );
  });

  test('a day later the next one is due', () {
    expect(
      autoBackupDue(last: now.subtract(const Duration(hours: 24)), now: now),
      isTrue,
    );
  });

  test('a clock set back does not make a copy due', () {
    expect(
      autoBackupDue(last: now.add(const Duration(hours: 2)), now: now),
      isFalse,
    );
  });

  test('every copy goes to the same file name', () {
    expect(AutoBackupController.fileName, 'cubechat-auto.cchatbackup');
  });
}
