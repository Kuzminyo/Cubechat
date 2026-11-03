import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/util/debug_log.dart';
import '../../../core/util/open_in.dart';
import 'backup_service.dart';

/// Why the last automatic backup did not land. [folder]: the folder or the
/// permission to it is gone, and only choosing it again helps.
enum AutoBackupProblem { folder, failed }

@immutable
class AutoBackupState {
  const AutoBackupState({
    this.enabled = false,
    this.folder,
    this.lastAt,
    this.problem,
    this.running = false,
  });

  final bool enabled;
  final BackupFolderRef? folder;

  /// When a copy last reached the folder.
  final DateTime? lastAt;
  final AutoBackupProblem? problem;
  final bool running;

  AutoBackupState copyWith({
    bool? enabled,
    BackupFolderRef? folder,
    DateTime? lastAt,
    AutoBackupProblem? problem,
    bool clearProblem = false,
    bool? running,
  }) =>
      AutoBackupState(
        enabled: enabled ?? this.enabled,
        folder: folder ?? this.folder,
        lastAt: lastAt ?? this.lastAt,
        problem: clearProblem ? null : (problem ?? this.problem),
        running: running ?? this.running,
      );
}

/// Whether a copy is owed: none yet, or the last one is a day old.
@visibleForTesting
bool autoBackupDue({required DateTime? last, required DateTime now}) =>
    last == null || now.difference(last) >= AutoBackupController.every;

/// A backup made on its own, once a day, into one file in a folder the user
/// chose once — overwritten each time, so the folder holds one current copy
/// and never a pile of dated ones ("so it just goes into one", 2026-11-03).
///
/// The archive is the same encrypted one the manual button makes, with the
/// same passphrase rules. That passphrase has to be at hand with nobody there
/// to type it, so it is kept in the platform's secure store — Keychain,
/// Keystore — beside the identity key it protects a copy of; restoring still
/// asks for it.
///
/// It runs while the app is open: shortly after launch and on every return
/// to it, when a day has passed. No background job — writing hundreds of
/// megabytes into a cloud folder is not something either platform lets an app
/// do from the background reliably, and a phone that is used gets its copy.
class AutoBackupController extends Notifier<AutoBackupState> {
  static const every = Duration(hours: 24);

  /// The one file name in the folder.
  static const fileName = 'cubechat-auto.cchatbackup';

  static const _enabledKey = 'backup.auto.enabled';
  static const _folderIdKey = 'backup.auto.folder.id';
  static const _folderNameKey = 'backup.auto.folder.name';
  static const _lastKey = 'backup.auto.last';
  static const _passwordKey = 'cubechat.backup.auto.password';

  static const _secure = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    // See IdentityService: the login keychain on a Mac.
    mOptions: MacOsOptions(useDataProtectionKeyChain: false),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  AppLifecycleListener? _lifecycle;
  Timer? _startup;

  @override
  AutoBackupState build() {
    ref.onDispose(() {
      _lifecycle?.dispose();
      _startup?.cancel();
    });
    unawaited(_restore());
    return const AutoBackupState();
  }

  Future<void> _restore() async {
    final SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // No settings store (a test, a broken install): off, as if never set.
      DebugLog.instance.log('BACKUP', 'automatic copy settings unread: $e');
      return;
    }
    final id = prefs.getString(_folderIdKey);
    final name = prefs.getString(_folderNameKey);
    final last = prefs.getInt(_lastKey);
    state = AutoBackupState(
      enabled: prefs.getBool(_enabledKey) ?? false,
      folder: id == null ? null : (id: id, name: name ?? id),
      lastAt: last == null ? null : DateTime.fromMillisecondsSinceEpoch(last),
    );
    if (!state.enabled) return;
    _watch();
    // Not at the first frame: launch is busy enough, and a copy that can wait
    // a day can wait half a minute.
    _startup = Timer(const Duration(seconds: 30), () => unawaited(runIfDue()));
  }

  void _watch() {
    _lifecycle ??= AppLifecycleListener(
      onResume: () => unawaited(runIfDue()),
    );
  }

  /// Turn it on: the folder and the passphrase, then a first copy at once.
  Future<void> enable({
    required BackupFolderRef folder,
    required String password,
  }) async {
    await _secure.write(key: _passwordKey, value: password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, true);
    await prefs.setString(_folderIdKey, folder.id);
    await prefs.setString(_folderNameKey, folder.name);
    state = state.copyWith(enabled: true, folder: folder, clearProblem: true);
    _watch();
    await run();
  }

  Future<void> changeFolder(BackupFolderRef folder) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_folderIdKey, folder.id);
    await prefs.setString(_folderNameKey, folder.name);
    state = state.copyWith(folder: folder, clearProblem: true);
    await run();
  }

  /// Off, and the stored passphrase with it. The copy in the folder stays.
  Future<void> disable() async {
    await _secure.delete(key: _passwordKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, false);
    _lifecycle?.dispose();
    _lifecycle = null;
    _startup?.cancel();
    state = state.copyWith(enabled: false, clearProblem: true);
  }

  Future<void> runIfDue() async {
    if (!state.enabled ||
        !autoBackupDue(last: state.lastAt, now: DateTime.now())) {
      return;
    }
    await run();
  }

  /// Make a copy now and put it in the folder.
  Future<void> run() async {
    final folder = state.folder;
    if (!state.enabled || state.running || folder == null) return;
    final password = await _secure.read(key: _passwordKey);
    if (password == null || password.isEmpty) {
      state = state.copyWith(problem: AutoBackupProblem.failed);
      return;
    }
    state = state.copyWith(running: true);
    Directory? staging;
    try {
      staging = await (await getTemporaryDirectory())
          .createTemp('cubechat-autobackup-');
      final archive = File('${staging.path}/$fileName');
      await ref
          .read(backupServiceProvider)
          .createFile(archive, password: password);
      final written = await BackupFolderAccess.write(
        folder,
        name: fileName,
        path: archive.path,
      );
      final prefs = await SharedPreferences.getInstance();
      if (written.renewedId case final renewed?) {
        await prefs.setString(_folderIdKey, renewed);
        state = state.copyWith(folder: (id: renewed, name: folder.name));
      }
      switch (written.outcome) {
        case FolderWriteOutcome.saved:
          final now = DateTime.now();
          await prefs.setInt(_lastKey, now.millisecondsSinceEpoch);
          state = state.copyWith(lastAt: now, clearProblem: true);
          DebugLog.instance.log('BACKUP', 'automatic copy written');
        case FolderWriteOutcome.denied:
          state = state.copyWith(problem: AutoBackupProblem.folder);
          DebugLog.instance.log('BACKUP', 'automatic copy: folder unreachable');
        case FolderWriteOutcome.failed:
          state = state.copyWith(problem: AutoBackupProblem.failed);
          DebugLog.instance.log('BACKUP', 'automatic copy failed to write');
      }
    } catch (e) {
      DebugLog.instance.log('BACKUP', 'automatic copy failed: ${e.runtimeType}');
      state = state.copyWith(problem: AutoBackupProblem.failed);
    } finally {
      try {
        await staging?.delete(recursive: true);
      } catch (_) {}
      state = state.copyWith(running: false);
    }
  }
}

final autoBackupControllerProvider =
    NotifierProvider<AutoBackupController, AutoBackupState>(
  AutoBackupController.new,
);
