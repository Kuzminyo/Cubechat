import 'dart:typed_data';

import 'package:cubechat/core/theme/colors.dart';
import 'package:cubechat/features/peers/data/contact_aliases_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/models/known_peer.dart';
import 'package:cubechat/features/radio/data/radio_controller.dart';
import 'package:cubechat/features/radio/presentation/radio_screen.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// The radio screen is a thin skin over [RadioController]: it shows what the
/// controller says and forwards three kinds of touch. So the controller is
/// replaced by one that records the touches and holds whatever state a test
/// wants to look at - the real one needs a microphone, a codec and a transport.
class _FakeRadio extends RadioController {
  _FakeRadio(this.initial);

  final RadioState initial;
  final List<String> calls = [];

  /// What the next [pressToTalk] answers; a refusal also sets this reason.
  RadioBlockedReason? refuseWith;

  @override
  RadioState build() => initial;

  @override
  Future<RadioRoom> joinGroup(String name, String password) async {
    calls.add('join $name|$password');
    final group = RadioRoom(
      name: '#$name',
      hasPassword: password.isNotEmpty,
      tagHex: '0123456789abcdef',
    );
    state = state.copyWith(groups: [...state.groups, group]);
    return group;
  }

  @override
  Future<void> leaveGroup(String tagHex) async {
    calls.add('leave $tagHex');
    state = state.copyWith(
      groups: state.groups.where((g) => g.tagHex != tagHex).toList(),
    );
  }

  @override
  void select(RadioChannel? channel) {
    calls.add('select $channel');
    state = state.copyWith(active: () => channel);
  }

  @override
  Future<bool> pressToTalk() async {
    calls.add('press');
    final reason = refuseWith;
    if (reason != null) {
      state = state.copyWith(blockedReason: () => reason);
      return false;
    }
    state = state.copyWith(floor: Talking(Uint8List(8)));
    return true;
  }

  @override
  Future<void> releaseToTalk() async {
    calls.add('release');
    state = state.copyWith(floor: const Idle());
  }

  @override
  Future<void> setPlayInSilentMode(bool value) async {
    calls.add('silent $value');
    state = state.copyWith(playInSilentMode: value);
  }
}

class _FakePeers extends KnownPeersController {
  _FakePeers(this.roster);

  final Map<String, KnownPeer> roster;

  @override
  Map<String, KnownPeer> build() => roster;
}

class _NoAliases extends ContactAliasesController {
  @override
  Map<String, String> build() => const {};
}

const _group = RadioRoom(
  name: '#patrol',
  hasPassword: true,
  tagHex: 'aabbccddeeff0011',
);

final _alice = 'a1' * 32;

KnownPeer _peer(String hex, String name) => KnownPeer(
      pubkeyHex: hex,
      displayName: name,
      lastSeen: DateTime(2026, 10, 20),
    );

void main() {
  Future<_FakeRadio> pump(
    WidgetTester tester, {
    RadioState state = const RadioState(groups: [_group]),
    String? contactId,
  }) async {
    final fake = _FakeRadio(state);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          radioControllerProvider.overrideWith(() => fake),
          knownPeersControllerProvider
              .overrideWith(() => _FakePeers({_alice: _peer(_alice, 'Alice')})),
          contactAliasesControllerProvider.overrideWith(_NoAliases.new),
        ],
        child: MaterialApp(
          locale: const Locale('uk'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData.dark(useMaterial3: true),
          home: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.bgTop, AppColors.bgBottom],
              ),
            ),
            child: RadioScreen(contactId: contactId),
          ),
        ),
      ),
    );
    await tester.pump();
    return fake;
  }

  final button = find.byKey(const ValueKey('radio-talk-button'));

  testWidgets('the button reads busy while someone else talks', (tester) async {
    await pump(
      tester,
      state: RadioState(
        groups: const [_group],
        active: _group,
        floor: Listening(_alice, Uint8List(8)),
      ),
    );

    expect(
      find.descendant(of: button, matching: find.text('Канал зайнятий')),
      findsOneWidget,
    );
    // Named the way a chat header names them, not by the key.
    expect(find.text('Говорить: Alice'), findsOneWidget);
    expect(find.text('Затисни й говори'), findsNothing);
    // A running pulse is a frame scheduled every vsync; this one is allowed
    // only while somebody is talking, and this test is that case, so it is
    // left to the test's own teardown to stop it.
  });

  testWidgets('a speaker nobody knows is a short fingerprint, not a blank',
      (tester) async {
    await pump(
      tester,
      state: RadioState(
        groups: const [_group],
        active: _group,
        floor: Listening('0123456789abcdef', Uint8List(8)),
      ),
    );

    expect(find.text('Говорить: 01234567'), findsOneWidget);
  });

  testWidgets('the button invites a press when the channel is free',
      (tester) async {
    await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );

    expect(
      find.descendant(of: button, matching: find.text('Затисни й говори')),
      findsOneWidget,
    );
  });

  testWidgets('talking says so', (tester) async {
    await pump(
      tester,
      state: RadioState(
        groups: const [_group],
        active: _group,
        floor: Talking(Uint8List(8)),
      ),
    );

    expect(
      find.descendant(of: button, matching: find.text('Говоріть…')),
      findsOneWidget,
    );
  });

  testWidgets('the join sheet needs a name', (tester) async {
    final fake = await pump(tester, state: const RadioState());

    await tester.tap(find.text('Додати рацію').first);
    await tester.pumpAndSettle();

    // Submitted empty: said, and nothing joined.
    await tester.tap(find.byKey(const ValueKey('radio-join-submit')));
    await tester.pump();
    expect(find.text('Введіть назву'), findsOneWidget);
    expect(fake.calls.where((c) => c.startsWith('join')), isEmpty);

    // A name that normalises to nothing is still no name.
    await tester.enterText(find.byKey(const ValueKey('radio-join-name')), ' # ');
    await tester.tap(find.byKey(const ValueKey('radio-join-submit')));
    await tester.pump();
    expect(fake.calls.where((c) => c.startsWith('join')), isEmpty);

    await tester.enterText(
      find.byKey(const ValueKey('radio-join-name')),
      'patrol',
    );
    await tester.enterText(
      find.byKey(const ValueKey('radio-join-password')),
      'secret',
    );
    await tester.tap(find.byKey(const ValueKey('radio-join-submit')));
    await tester.pumpAndSettle();

    // Joined, then tuned to: one step for the person.
    expect(fake.calls, ['join patrol|secret', 'select RadioRoom(#patrol)']);
    expect(find.byKey(const ValueKey('radio-join-name')), findsNothing);
    expect(find.text('#patrol'), findsWidgets);
  });

  testWidgets('the silent-mode switch reflects the state', (tester) async {
    final fake = await pump(tester);

    Switch silent() => tester.widget<Switch>(
          find.descendant(
            of: find.byKey(const ValueKey('radio-silent-tile')),
            matching: find.byType(Switch),
          ),
        );

    expect(find.text('Говорити в беззвучному режимі'), findsOneWidget);
    expect(silent().value, isTrue, reason: 'on by default');

    await tester.tap(find.byKey(const ValueKey('radio-silent-tile')));
    await tester.pump();
    expect(fake.calls, contains('silent false'));
    expect(silent().value, isFalse);
  });

  testWidgets('the switch shows an off state it is handed', (tester) async {
    await pump(
      tester,
      state: const RadioState(groups: [_group], playInSilentMode: false),
    );

    final sw = tester.widget<Switch>(
      find.descendant(
        of: find.byKey(const ValueKey('radio-silent-tile')),
        matching: find.byType(Switch),
      ),
    );
    expect(sw.value, isFalse);
  });

  testWidgets('a press goes down on the pointer and up on the pointer',
      (tester) async {
    final fake = await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );

    final gesture = await tester.startGesture(tester.getCenter(button));
    await tester.pump();
    // Straight away, not after a long-press delay: the start of a sentence is
    // the part that would be lost.
    expect(fake.calls, ['press']);

    await gesture.up();
    await tester.pump();
    expect(fake.calls, ['press', 'release']);
  });

  testWidgets('a pointer cancel releases too', (tester) async {
    final fake = await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );

    final gesture = await tester.startGesture(tester.getCenter(button));
    await tester.pump();
    await gesture.cancel();
    await tester.pump();

    expect(fake.calls, ['press', 'release']);
  });

  testWidgets('a refused press says why, then lets go of the words',
      (tester) async {
    final fake = await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );
    fake.refuseWith = RadioBlockedReason.call;

    final gesture = await tester.startGesture(tester.getCenter(button));
    await tester.pump();
    expect(find.text('Триває дзвінок'), findsOneWidget);

    await gesture.up();
    await tester.pump();
    // No dialog; the line is gone by itself.
    expect(find.byType(AlertDialog), findsNothing);
    await tester.pump(const Duration(seconds: 4));
    expect(find.text('Триває дзвінок'), findsNothing);
  });

  testWidgets('tapping a group tunes to it', (tester) async {
    final fake = await pump(tester);

    await tester.tap(find.text('#patrol'));
    await tester.pump();

    expect(fake.calls, ['select RadioRoom(#patrol)']);
  });

  testWidgets('tapping the tuned group again switches the radio off',
      (tester) async {
    final fake = await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );

    // First in the tree is the list's tile; the panel's title comes after.
    await tester.tap(find.text('#patrol').first);
    await tester.pump();

    expect(fake.calls, ['select null']);
    expect(fake.state.active, isNull);
  });

  testWidgets('the off control un-tunes, and then there is nothing to press',
      (tester) async {
    final fake = await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );
    expect(find.byTooltip('Вимкнути рацію'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('radio-off')));
    await tester.pump();

    expect(fake.calls, ['select null']);
    // The control has done its job and is gone; the panel says to pick again.
    expect(find.byKey(const ValueKey('radio-off')), findsNothing);
    expect(find.text('Оберіть групу або контакт'), findsOneWidget);

    // And the button is dead, not merely dim: a press reaches nobody.
    final gesture = await tester.startGesture(tester.getCenter(button));
    await tester.pump();
    await gesture.up();
    await tester.pump();
    expect(fake.calls, ['select null']);
  });

  testWidgets('with nothing tuned there is no off control', (tester) async {
    await pump(tester);

    expect(find.byKey(const ValueKey('radio-off')), findsNothing);
    expect(find.text('Оберіть групу або контакт'), findsOneWidget);
  });

  testWidgets('the talk button is named for a screen reader', (tester) async {
    final semantics = tester.ensureSemantics();
    await pump(
      tester,
      state: const RadioState(groups: [_group], active: _group),
    );

    final node = tester.getSemantics(button);
    expect(node.label, 'Затисни й говори');
    expect(node.flagsCollection.isButton, isTrue);
    semantics.dispose();
  });

  testWidgets('a group can be left from its menu', (tester) async {
    final fake = await pump(tester);

    await tester.tap(find.byTooltip('Ще'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Вийти з рації'));
    await tester.pumpAndSettle();

    expect(fake.calls, ['leave aabbccddeeff0011']);
    expect(find.text('#patrol'), findsNothing);
  });

  testWidgets('a contact entry opens with that contact tuned in',
      (tester) async {
    final fake = await pump(
      tester,
      state: const RadioState(groups: [_group]),
      contactId: _alice,
    );
    await tester.pump();

    expect(fake.calls, ['select RadioContact($_alice)']);
    expect(fake.state.active, RadioContact(_alice));
    // And the person is on the screen by name.
    expect(find.text('Alice'), findsWidgets);
  });
}
