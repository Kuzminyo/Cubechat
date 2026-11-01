import 'dart:async';
import 'dart:io' show Platform;

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../util/debug_log.dart';
import '../util/platform_info.dart';

/// The argument the autostart entry launches with: start in the tray, no
/// window. Read by `main` and by the Windows runner, which then never shows
/// the window on its first frame (`windows/runner/flutter_window.cpp`).
const String kLaunchHiddenArg = '--hidden';

/// What [DesktopPresence] needs from the window, the tray and the autostart
/// entry, behind one seam so the behaviour is tested without a desktop.
abstract class DesktopShell {
  /// Take over the window's close button: it raises [closeRequests] and the
  /// window stays.
  Future<void> interceptClose();
  Stream<void> get closeRequests;

  Future<void> show();
  Future<void> hide();

  /// End the process — the one way out, from the tray's menu.
  Future<void> quit();

  /// A tray icon whose click and "open" item call [onOpen], and whose "quit"
  /// item calls [onQuit].
  Future<void> setTray({
    required String openLabel,
    required String quitLabel,
    required void Function() onOpen,
    required void Function() onQuit,
  });

  Future<bool> autostartEnabled();
  Future<void> setAutostart(bool on);
}

/// A computer stays on the line with its window closed
/// (`docs/superpowers/specs/2026-11-01-desktop-tray-design.md`).
///
/// There is no push to wake a computer: messages and calls reach it only while
/// CubeChat runs with its relay socket open. So on Windows the close button
/// hides the window to the tray instead of ending the process, a call brings
/// the window forward, and CubeChat starts with Windows, straight into the
/// tray, unless that is switched off. The close button hides whatever the
/// switch says — otherwise turning autostart off would quietly bring back
/// "closed the window, stopped ringing".
///
/// The Mac does the platform's own thing natively instead (the app outlives
/// its window; `macos/Runner/AppDelegate.swift`), and the phones never build
/// one of these.
class DesktopPresence {
  DesktopPresence({
    required DesktopShell shell,
    required Future<bool> Function() loadAutostart,
    required Future<void> Function(bool on) saveAutostart,
  })  : _shell = shell,
        _loadAutostart = loadAutostart,
        _saveAutostart = saveAutostart;

  final DesktopShell _shell;
  final Future<bool> Function() _loadAutostart;
  final Future<void> Function(bool on) _saveAutostart;

  /// The running computer's presence, for the call surface — which is built
  /// outside the provider tree — to bring the window forward. Null on a phone.
  static DesktopPresence? instance;

  StreamSubscription<void>? _closes;
  bool _autostart = true;
  bool get autostart => _autostart;

  /// Wire the close button and the tray, and bring the autostart entry in
  /// line with the switch. [launchedHidden] — started by that entry — keeps
  /// the window hidden; otherwise it is shown.
  Future<void> start({
    required bool launchedHidden,
    required String openLabel,
    required String quitLabel,
  }) async {
    await _shell.interceptClose();
    _closes = _shell.closeRequests.listen((_) => unawaited(_shell.hide()));
    await _shell.setTray(
      openLabel: openLabel,
      quitLabel: quitLabel,
      onOpen: () => unawaited(reveal()),
      onQuit: () => unawaited(_shell.quit()),
    );
    _autostart = await _loadAutostart();
    await _applyAutostart();
    if (!launchedHidden) await _shell.show();
    instance = this;
  }

  /// Bring the window to the front: a call came in, or a banner was clicked.
  Future<void> reveal() => _shell.show();

  /// The settings switch. The entry follows at once.
  Future<void> setAutostart(bool on) async {
    _autostart = on;
    await _saveAutostart(on);
    await _applyAutostart();
  }

  Future<void> _applyAutostart() async {
    try {
      if (await _shell.autostartEnabled() != _autostart) {
        await _shell.setAutostart(_autostart);
      }
    } catch (e) {
      // A refused registry write leaves the computer as it was; the window
      // and the tray still work.
      DebugLog.instance.log('DESKTOP', 'autostart not changed: $e');
    }
  }

  Future<void> dispose() async {
    await _closes?.cancel();
    if (identical(instance, this)) instance = null;
  }
}

/// [DesktopShell] on window_manager, tray_manager and launch_at_startup.
/// Windows only — see [DesktopPresence].
class PluginDesktopShell with WindowListener, TrayListener
    implements DesktopShell {
  final _closeRequests = StreamController<void>.broadcast();
  void Function()? _onOpen;
  void Function()? _onQuit;

  static const _openKey = 'open';
  static const _quitKey = 'quit';

  @override
  Future<void> interceptClose() async {
    await windowManager.ensureInitialized();
    await windowManager.setPreventClose(true);
    windowManager.addListener(this);
    launchAtStartup.setup(
      appName: 'CubeChat',
      appPath: Platform.resolvedExecutable,
      args: const [kLaunchHiddenArg],
    );
  }

  @override
  Stream<void> get closeRequests => _closeRequests.stream;

  @override
  void onWindowClose() => _closeRequests.add(null);

  @override
  Future<void> show() async {
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  Future<void> hide() => windowManager.hide();

  @override
  Future<void> quit() async {
    await trayManager.destroy();
    await windowManager.setPreventClose(false);
    await windowManager.destroy();
  }

  @override
  Future<void> setTray({
    required String openLabel,
    required String quitLabel,
    required void Function() onOpen,
    required void Function() onQuit,
  }) async {
    _onOpen = onOpen;
    _onQuit = onQuit;
    // The window's own icon, shipped as an asset so the tray can load it.
    await trayManager.setIcon('assets/tray/cubechat.ico');
    await trayManager.setToolTip('CubeChat');
    await trayManager.setContextMenu(
      Menu(
        items: [
          MenuItem(key: _openKey, label: openLabel),
          MenuItem.separator(),
          MenuItem(key: _quitKey, label: quitLabel),
        ],
      ),
    );
    trayManager.addListener(this);
  }

  @override
  void onTrayIconMouseDown() => _onOpen?.call();

  @override
  void onTrayIconRightMouseDown() => unawaited(trayManager.popUpContextMenu());

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case _openKey:
        _onOpen?.call();
      case _quitKey:
        _onQuit?.call();
    }
  }

  @override
  Future<bool> autostartEnabled() => launchAtStartup.isEnabled();

  @override
  Future<void> setAutostart(bool on) =>
      on ? launchAtStartup.enable() : launchAtStartup.disable();
}

/// Whether this build keeps a computer on the line with its window closed.
bool get desktopPresenceSupported => PlatformInfo.isWindows;
