import 'dart:async';

import 'package:cubechat/core/transport/call_signal.dart';
import 'package:cubechat/core/transport/control_delivery.dart';
import 'package:cubechat/features/call/data/call_controller.dart';
import 'package:cubechat/features/call/data/call_media.dart';
import 'package:cubechat/features/call/data/turn_credentials_controller.dart';
import 'package:cubechat/features/call/domain/call_state_machine.dart';
import 'package:cubechat/features/call/presentation/call_screen.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' show MediaStream;
import 'package:go_router/go_router.dart';

class _Media implements CallMedia {
  final _events = StreamController<CallMediaEvent>.broadcast(sync: true);
  @override
  int get linkBars => 4;
  @override
  Stream<CallMediaEvent> get events => _events.stream;
  @override
  Future<String> offer(
    Map<String, dynamic> configuration, {
    bool video = false,
  }) async =>
      'offer';
  @override
  bool get videoPossible => false;
  @override
  Future<bool> setCamera(bool on) async => on;
  @override
  Future<void> switchCamera() async {}
  @override
  bool get cameraOpen => false;
  @override
  bool get frontCamera => true;
  @override
  MediaStream? get localVideo => null;
  @override
  MediaStream? get remoteVideo => null;
  @override
  Future<String> answer(
          Map<String, dynamic> configuration, String remoteSdp) async =>
      'answer';
  @override
  Future<void> accept(String remoteSdp) async =>
      _events.add(CallMediaEvent.connected);
  @override
  Future<void> setMuted(bool muted) async {}
  @override
  Future<void> setSpeaker(bool speaker) async {}
  @override
  Future<List<CallAudioRoute>> routes() async => const [];
  @override
  Future<void> selectRoute(CallAudioRoute route) async {}
  @override
  Future<void> close() => _events.close();
}

/// The call screen, mounted the way the app mounts it.
///
/// Tapping "Call" on a real phone turned the whole screen white and left it
/// there. `CallHost` lives in `MaterialApp.router`'s `builder`, which is
/// *above* the router — app.dart says so in a comment beside it — so nothing
/// the call screen draws has a Router, a Navigator or an Overlay above it. A
/// widget that looks one of those up throws while building, and a release
/// build paints a thrown build as an empty rectangle, which here was the size
/// of the screen. No test mounted the screen at all, which is how 1581 green
/// tests shipped it.
void main() {
  late StreamController<ReceivedCallSignal> signals;
  late CallController call;
  late GoRouter router;
  late List<CallSignal> sent;
  late List<bool> screenOn;

  setUp(() {
    sent = [];
    screenOn = [];
    signals = StreamController<ReceivedCallSignal>(sync: true);
    call = CallController(
      signals: signals.stream,
      send: (peer, signal) async {
        sent.add(signal);
        return const ControlDelivery(
          links: 1,
          certainty: DeliveryCertainty.confirmed,
        );
      },
      obtainTurn: () async => TurnAccess(
        urls: const ['turn:test'],
        username: 'u',
        password: 'p',
        expiresAt: DateTime.now().add(const Duration(minutes: 10)),
      ),
      microphone: () async => true,
      createMedia: _Media.new,
      record: (peer, outcome, video) {},
      peerName: (peer) => 'Alice',
      allowed: (_) => true,
      allowDirect: () => false,
      prepareAudio: () async {},
    );
    router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const Scaffold(body: Text('underneath')),
      ),
    ]);
  });

  tearDown(() async {
    // Not disposed here: the ProviderScope owns the controller once it is the
    // override, and unmounting the tree at the end of the test disposes it.
    await signals.close();
  });

  Widget app() => ProviderScope(
        overrides: [
          callControllerProvider.overrideWith((ref) => call),
          keepScreenOnProvider.overrideWithValue((on) async => screenOn.add(on)),
        ],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          // Exactly where app.dart puts it: around the router's output, in
          // the builder, with no route of its own.
          builder: (context, child) => CallHost(
            backButtonDispatcher: router.backButtonDispatcher,
            child: child!,
          ),
        ),
      );

  testWidgets('dialling puts a working call screen on top, not a blank one',
      (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    unawaited(call.dial('peer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull,
        reason: 'a thrown build is the white screen');
    expect(find.text('Alice'), findsOneWidget);
    expect(find.byIcon(Icons.call_end_rounded), findsOneWidget,
        reason: 'the one control a person needs is there to press');

    await tester.tap(find.byIcon(Icons.call_end_rounded));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('a video call builds with its camera button and no picture yet',
      (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    unawaited(call.dial('peer', video: true));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull,
        reason: 'a thrown build is the white screen');
    expect(find.text('Alice'), findsOneWidget,
        reason: 'no picture is arriving, so their face and name stay');
    expect(find.byIcon(Icons.videocam_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.videocam_rounded));
    await tester.pump();
    expect(find.byIcon(Icons.videocam_off_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.call_end_rounded));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('back while a call is showing does not pop the page beneath it',
      (tester) async {
    router = GoRouter(initialLocation: '/second', routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const Scaffold(body: Text('underneath')),
        routes: [
          GoRoute(
            path: 'second',
            builder: (_, __) => const Scaffold(body: Text('second page')),
          ),
        ],
      ),
    ]);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(find.text('second page'), findsOneWidget);

    unawaited(call.dial('peer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // The same path the Android back key takes into the app. Settled, and
    // asked of the router rather than of the widget tree: a page being popped
    // is still in the tree for the length of its exit animation, which made
    // the first version of this test pass with the fix switched off.
    await tester.binding.handlePopRoute();
    // A fixed wait and not pumpAndSettle: a call that is dialling pulses, and
    // a repeating animation never settles.
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
    expect(router.routerDelegate.currentConfiguration.uri.path, '/second',
        reason: 'the call owns back while it is on screen');

    // And gives it back once the call is gone.
    call.hangUp();
    await tester.pump();
    call.dismiss();
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(router.routerDelegate.currentConfiguration.uri.path, '/',
        reason: 'with no call on screen, back is the router\'s again');
  });

  testWidgets('a call folds into an island and the app underneath is usable '
      'again', (tester) async {
    var tapped = 0;
    router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => Scaffold(
          body: SafeArea(
            child: TextButton(
              onPressed: () => tapped++,
              child: const Text('underneath'),
            ),
          ),
        ),
      ),
    ]);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    unawaited(call.dial('peer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    final before = tester.getTopLeft(find.text('underneath'));

    await tester.tap(find.byIcon(Icons.keyboard_arrow_down_rounded));
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byType(CallIsland), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(CallScreen), findsNothing,
        reason: 'gone once it has slid down');

    await tester.tap(find.text('underneath'));
    expect(tapped, 1, reason: 'the chats are usable while the call is away');
    expect(
      tester.getTopLeft(find.text('underneath')).dy,
      greaterThanOrEqualTo(before.dy + CallIsland.height),
      reason: 'headers step down under the island instead of hiding behind it',
    );

    await tester.tap(find.byType(CallIsland));
    await tester.pump();
    expect(find.byType(CallScreen), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 400));

    await tester.tap(find.byIcon(Icons.call_end_rounded));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('a call that ends while folded away does not unfold', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    unawaited(call.dial('peer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down_rounded));
    await tester.pump();

    call.hangUp();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(CallScreen), findsNothing);
    expect(find.byType(CallIsland), findsNothing);
    expect(call.peerId, isNull, reason: 'dismissed, not left behind');
  });

  testWidgets('the call screen rises from the bottom and goes back down',
      (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    final height = tester.view.physicalSize.height / tester.view.devicePixelRatio;

    unawaited(call.dial('peer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));
    final rising = tester.getTopLeft(find.byType(CallScreen)).dy;
    expect(rising, greaterThan(0), reason: 'on its way up, not already there');
    expect(rising, lessThan(height));
    await tester.pump(const Duration(milliseconds: 400));
    expect(tester.getTopLeft(find.byType(CallScreen)).dy, 0);

    call.hangUp();
    await tester.pump();
    call.dismiss();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(CallScreen), findsOneWidget,
        reason: 'still sliding away after the call is dismissed');
    expect(tester.getTopLeft(find.byType(CallScreen)).dy, greaterThan(0));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(CallScreen), findsNothing);
    expect(tester.takeException(), isNull);
  });

  /// The other side picks up the call this phone placed.
  void answered() {
    final signal = CallSignal.accept(callId: sent.first.callId, sdp: 'answer');
    signals.add((chatId: 'peer', signal: signal));
  }

  group('tapping the screen during a call', () {
    /// Dialled and answered, the screen fully risen.
    Future<void> talking(WidgetTester tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        await call.dial('peer');
        answered();
        await Future<void>.delayed(const Duration(milliseconds: 10));
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(call.phase, CallPhase.talking);
    }

    Finder hangUp() => find.byIcon(Icons.call_end_rounded);
    double opacityOf(WidgetTester tester, Finder finder) => tester
        .widget<AnimatedOpacity>(
          find.ancestor(of: finder, matching: find.byType(AnimatedOpacity)),
        )
        .opacity;

    tearDown(() => call.hangUp());

    testWidgets('sends the buttons down without moving the name, and back',
        (tester) async {
      await talking(tester);
      final name = tester.getTopLeft(find.text('Alice'));
      final button = tester.getTopLeft(hangUp());

      await tester.tapAt(tester.getCenter(find.text('Alice')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.getTopLeft(hangUp()).dy, greaterThan(button.dy + 150));
      expect(opacityOf(tester, hangUp()), 0);
      expect(tester.getTopLeft(find.text('Alice')), name);

      await tester.tapAt(tester.getCenter(find.text('Alice')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.getTopLeft(hangUp()), button);
      expect(opacityOf(tester, hangUp()), 1);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a hidden button cannot be pressed', (tester) async {
      await talking(tester);
      final where = tester.getCenter(hangUp());
      await tester.tapAt(tester.getCenter(find.text('Alice')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      await tester.tapAt(where);
      await tester.pump();
      expect(call.phase, CallPhase.talking);
    });

    testWidgets('pressing a button keeps the buttons where they are',
        (tester) async {
      await talking(tester);
      final button = tester.getTopLeft(hangUp());
      await tester.tap(find.byIcon(Icons.mic_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(
        find.byIcon(Icons.mic_off_rounded),
        findsNWidgets(2),
        reason: 'the button itself and the pill above it',
      );
      expect(
        tester.getTopLeft(hangUp()),
        button,
        reason: 'the mute pill stands above the row and takes no room',
      );
    });

    testWidgets('does nothing while the call is only ringing', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.runAsync(() => call.dial('peer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(call.phase, CallPhase.dialing);
      final button = tester.getTopLeft(hangUp());

      await tester.tapAt(tester.getCenter(find.text('Alice')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.getTopLeft(hangUp()), button);
    });

    testWidgets('stays off for a screen reader', (tester) async {
      await talking(tester);
      final button = tester.getTopLeft(hangUp());
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(accessibleNavigation: true);
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      await tester.pump();

      await tester.tapAt(tester.getCenter(find.text('Alice')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.getTopLeft(hangUp()), button);
    });
  });

  group('the screen stays on', () {
    testWidgets('while a call fills it, and is let go when the call folds away',
        (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      expect(screenOn, isEmpty, reason: 'no call, nothing asked');

      unawaited(call.dial('peer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(screenOn, [true]);

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(screenOn, [true, false], reason: 'reading chats, it may sleep');

      await tester.tap(find.byType(CallIsland));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(screenOn, [true, false, true]);

      call.hangUp();
      await tester.pump();
      expect(screenOn.last, isFalse, reason: 'the call is over');
      await tester.pump(const Duration(milliseconds: 400));
    });

    testWidgets('is let go if the app goes away mid-call', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      unawaited(call.dial('peer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      await tester.pumpWidget(const SizedBox());
      expect(screenOn, [true, false]);
    });
  });

  group('the small picture', () {
    test('is shaped like the video, so an upright one is shown whole', () {
      final upright = smallPictureSize(9 / 16);
      expect(upright.width, 104);
      expect(upright.height, closeTo(184.9, 0.1));

      final wide = smallPictureSize(16 / 9);
      expect(wide.width, 176);
      expect(wide.height, closeTo(99, 0.1));
    });

    test('stays a sensible size for a strange video', () {
      expect(smallPictureSize(0.1).height, 200);
      expect(smallPictureSize(0.95).height, 140);
      expect(smallPictureSize(10).height, 90);
    });

    test('sits over the buttons and drops to the corner when they go', () {
      double at({int notices = 0, bool hidden = false}) => smallPictureBottom(
            inset: 34,
            rowHeight: 92,
            notices: notices,
            controlsHidden: hidden,
          );
      expect(at(), 170);
      expect(at(notices: 2), 238, reason: 'clear of the pills');
      expect(at(hidden: true), 50);
      expect(at(notices: 2, hidden: true), 50, reason: 'the pills went too');
    });
  });

  group('the ring round the face', () {
    Finder ring() => find.byKey(const ValueKey('pulse'));

    testWidgets('breathes while dialling and stops when the call is answered',
        (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        await call.dial('peer');
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(ring(), findsOneWidget);
      expect(tester.hasRunningAnimations, isTrue);

      await tester.runAsync(() async {
        answered();
        await Future<void>.delayed(const Duration(milliseconds: 10));
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(call.phase, CallPhase.talking);
      expect(ring(), findsNothing);
      call.hangUp();
      await tester.pump();
    });

    testWidgets('holds still with Reduce Motion', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      unawaited(call.dial('peer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(ring(), findsNothing);
      expect(find.byKey(const ValueKey('still')), findsOneWidget);
      expect(
        tester.hasRunningAnimations,
        isFalse,
        reason: 'nothing schedules a frame while it rings',
      );
      call.hangUp();
      await tester.pump();
    });
  });
}
