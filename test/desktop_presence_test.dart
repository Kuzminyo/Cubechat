import 'dart:async';

import 'package:cubechat/core/desktop/desktop_presence.dart';
import 'package:flutter_test/flutter_test.dart';

class _Shell implements DesktopShell {
  _Shell({this.autostartOn = false});

  final calls = <String>[];
  final _closes = StreamController<void>.broadcast();
  bool autostartOn;
  void Function()? onOpen;
  void Function()? onQuit;
  String? openLabel;

  void pressClose() => _closes.add(null);

  @override
  Future<void> interceptClose() async => calls.add('intercept');

  @override
  Stream<void> get closeRequests => _closes.stream;

  @override
  Future<void> show() async => calls.add('show');

  @override
  Future<void> hide() async => calls.add('hide');

  @override
  Future<void> quit() async => calls.add('quit');

  @override
  Future<void> setTray({
    required String openLabel,
    required String quitLabel,
    required void Function() onOpen,
    required void Function() onQuit,
  }) async {
    this.openLabel = openLabel;
    this.onOpen = onOpen;
    this.onQuit = onQuit;
  }

  @override
  Future<bool> autostartEnabled() async => autostartOn;

  @override
  Future<void> setAutostart(bool on) async {
    calls.add('autostart $on');
    autostartOn = on;
  }
}

void main() {
  tearDown(() => DesktopPresence.instance = null);

  Future<(DesktopPresence, _Shell, List<bool>)> start({
    bool hidden = false,
    bool? saved,
    bool registered = false,
  }) async {
    final shell = _Shell(autostartOn: registered);
    final saves = <bool>[];
    final presence = DesktopPresence(
      shell: shell,
      loadAutostart: () async => saved ?? true,
      saveAutostart: (on) async => saves.add(on),
    );
    await presence.start(
      launchedHidden: hidden,
      openLabel: 'Open',
      quitLabel: 'Quit',
    );
    addTearDown(presence.dispose);
    return (presence, shell, saves);
  }

  test('the close button hides the window and ends nothing', () async {
    final (_, shell, _) = await start();
    shell.calls.clear();
    shell.pressClose();
    await Future<void>.delayed(Duration.zero);
    expect(shell.calls, ['hide']);
  });

  test('the tray opens the window and quits the process', () async {
    final (_, shell, _) = await start();
    shell.calls.clear();
    shell.onOpen!();
    shell.onQuit!();
    await Future<void>.delayed(Duration.zero);
    expect(shell.calls, ['show', 'quit']);
    expect(shell.openLabel, 'Open');
  });

  test('autostart is registered by default, and launched hidden stays hidden',
      () async {
    final (presence, shell, _) = await start(hidden: true);
    expect(shell.calls, contains('autostart true'));
    expect(shell.calls, isNot(contains('show')), reason: 'came up in the tray');
    expect(presence.autostart, isTrue);
    expect(DesktopPresence.instance, same(presence));
  });

  test('a launch by hand shows the window', () async {
    final (_, shell, _) = await start();
    expect(shell.calls, contains('show'));
  });

  test('switching autostart off removes the entry and is remembered',
      () async {
    final (presence, shell, saves) = await start(registered: true);
    await presence.setAutostart(false);
    expect(shell.calls, contains('autostart false'));
    expect(saves, [false]);
    expect(presence.autostart, isFalse);

    shell.calls.clear();
    shell.pressClose();
    await Future<void>.delayed(Duration.zero);
    expect(shell.calls, ['hide'], reason: 'still hides, whatever the switch');
  });

  test('a saved "off" removes an entry left behind', () async {
    final (_, shell, _) = await start(saved: false, registered: true);
    expect(shell.calls, contains('autostart false'));
  });

  test('an entry that already matches is left alone', () async {
    final (_, shell, _) = await start(registered: true);
    expect(shell.calls.where((c) => c.startsWith('autostart')), isEmpty);
  });
}
