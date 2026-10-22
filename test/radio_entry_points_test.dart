import 'dart:async';
import 'dart:io';

import 'package:cubechat/core/routing/app_router.dart';
import 'package:cubechat/core/theme/app_theme.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chat/presentation/chat_screen.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/data/peer_discovery_controller.dart';
import 'package:cubechat/features/peers/data/peripheral_controller.dart';
import 'package:cubechat/features/peers/models/known_peer.dart';
import 'package:cubechat/features/peers/presentation/peers_screen.dart';
import 'package:cubechat/features/radio/data/radio_controller.dart';
import 'package:cubechat/features/radio/presentation/radio_screen.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/accepted_terms.dart';
import 'support/hive_settle.dart';

/// The two ways into the radio screen, and the route they share.
///
/// The screen itself is covered in `radio_screen_test.dart`. What goes wrong
/// at the edges is quieter: a header button that shows for somebody it cannot
/// address, a Nearby row that goes nowhere, or a route that drops the contact
/// on the floor and opens the group list instead.
class _FakeRadio extends RadioController {
  final List<String> calls = [];

  @override
  RadioState build() => const RadioState();

  @override
  void select(RadioChannel? channel) {
    calls.add('select $channel');
    state = state.copyWith(active: () => channel);
  }
}

class _Roster extends KnownPeersController {
  _Roster(this.roster);

  final Map<String, KnownPeer> roster;

  @override
  Map<String, KnownPeer> build() => roster;
}

class _NoMessages extends MessagesController {
  @override
  Map<String, List<Message>> build() => const {};
}

class _IdleDiscovery extends PeerDiscoveryController {
  @override
  PeerDiscoveryState build() => const PeerDiscoveryState(
        status: PeerDiscoveryStatus.idle,
        peers: [],
      );

  @override
  Future<void> start() async {}

  @override
  Future<void> retuneScan() async {}
}

class _Quiet extends PeripheralController {
  @override
  PeripheralState build() => PeripheralState.initial;
}

final _bob = 'b0' * 32;

KnownPeer _peer({DateTime? blockedAt}) => KnownPeer(
      pubkeyHex: _bob,
      displayName: 'Bob',
      lastSeen: DateTime(2026, 10, 20),
      blockedAt: blockedAt,
    );

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_radio_entry_');
    Hive.init(tempDir.path);
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    await settleBackgroundStorage();
    await Hive.close();
    try {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows holds the Hive files briefly after close.
    }
  });

  void mockPlatform(WidgetTester tester) {
    for (final ch in [
      'com.llfbandit.record/messages',
      'plugins.it_nomads.com/flutter_secure_storage',
    ]) {
      tester.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(MethodChannel(ch), (call) async => null);
    }
  }

  group('the /radio route', () {
    Future<(_FakeRadio, GoRouter)> openApp(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2340);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      mockPlatform(tester);
      final fake = _FakeRadio();
      final router = buildRouter();
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            acceptedTermsOverride,
            radioControllerProvider.overrideWith(() => fake),
          ],
          child: MaterialApp.router(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.dark(),
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      return (fake, router);
    }

    testWidgets('opens on the contact it is given, tuned in', (tester) async {
      final (fake, router) = await openApp(tester);

      unawaited(router.push('/radio?contact=$_bob'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(RadioScreen), findsOneWidget);
      expect(fake.calls, ['select RadioContact($_bob)']);
    });

    testWidgets('opens on the group list when there is no contact',
        (tester) async {
      final (fake, router) = await openApp(tester);

      unawaited(router.push('/radio'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(RadioScreen), findsOneWidget);
      expect(fake.calls, isEmpty);
    });
  });

  group('the chat header button', () {
    Future<List<String>> openChat(
      WidgetTester tester, {
      required String peerId,
      required Map<String, KnownPeer> roster,
    }) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      mockPlatform(tester);
      final opened = <String>[];
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => ChatScreen(peerId: peerId, peerLabel: 'Bob'),
          ),
          GoRoute(
            path: '/radio',
            builder: (_, state) {
              opened.add(state.uri.toString());
              return const Scaffold(body: Text('radio stub'));
            },
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            knownPeersControllerProvider.overrideWith(() => _Roster(roster)),
            messagesControllerProvider.overrideWith(_NoMessages.new),
          ],
          child: MaterialApp.router(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.dark(),
            routerConfig: router,
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      tester.takeException();
      return opened;
    }

    testWidgets('is gone: the radio moved to the contact profile',
        (tester) async {
      // Asked for 2026-10-22: the radio sits beside the call button on the
      // profile, and the header keeps search and retry.
      await openChat(tester, peerId: _bob, roster: {_bob: _peer()});

      expect(
        find.byTooltip('Search'),
        findsOneWidget,
        reason: 'the header is up',
      );
      expect(find.byTooltip('Walkie-talkie'), findsNothing);
    });

    testWidgets('is hidden before there is an identity to address',
        (tester) async {
      // A chat opened from a Nearby tap: a BLE address, no key until the
      // handshake lands.
      await openChat(tester, peerId: 'AA:BB:CC:DD:EE:FF', roster: const {});

      expect(
        find.byTooltip('Search'),
        findsOneWidget,
        reason: 'the header is up',
      );
      expect(find.byTooltip('Walkie-talkie'), findsNothing);
    });

    testWidgets('is hidden for somebody blocked', (tester) async {
      await openChat(
        tester,
        peerId: _bob,
        roster: {_bob: _peer(blockedAt: DateTime(2026, 10, 1))},
      );

      expect(
        find.byTooltip('Search'),
        findsOneWidget,
        reason: 'the header is up',
      );
      expect(find.byTooltip('Walkie-talkie'), findsNothing);
    });
  });

  group('the Nearby row', () {
    testWidgets('opens the radio', (tester) async {
      final opened = <String>[];
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Scaffold(body: PeersScreen()),
          ),
          GoRoute(
            path: '/radio',
            builder: (_, state) {
              opened.add(state.uri.toString());
              return const Scaffold(body: Text('radio stub'));
            },
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            peerDiscoveryControllerProvider.overrideWith(_IdleDiscovery.new),
            peripheralControllerProvider.overrideWith(_Quiet.new),
          ],
          child: MaterialApp.router(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.dark(),
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final row = find.byKey(const ValueKey('nearby-radio-entry'));
      expect(row, findsOneWidget);
      expect(
        find.descendant(of: row, matching: find.text('Walkie-talkie')),
        findsOneWidget,
      );

      await tester.tap(row);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(opened, ['/radio']);
      expect(find.text('radio stub'), findsOneWidget);
    });
  });
}
