import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart'
    show MediaStream, RTCVideoRenderer, RTCVideoView, RTCVideoViewObjectFit;
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../core/theme/colors.dart';
import '../../../core/util/debug_log.dart';
import '../../../core/util/motion.dart';
import '../../../core/util/platform_info.dart';
import '../../../core/widgets/bar_glass.dart';
import '../../../l10n/app_localizations.dart';
import '../../peers/presentation/widgets/peer_avatar.dart';
import '../data/call_controller.dart';
import '../data/call_media.dart';
import '../data/call_screen_access.dart';
import '../domain/call_state_machine.dart';

/// Asks the phone not to dim or lock while a call fills the screen. A provider
/// so a test can see the request without a platform underneath it.
///
/// Only the idle timer: Android's near-ear sensor ([NearEar]) still blanks the
/// screen against a cheek. A refusal costs a dimmed screen and nothing else,
/// so it is logged and the call goes on.
final keepScreenOnProvider = Provider<Future<void> Function(bool on)>(
  (ref) => (on) async {
    try {
      await WakelockPlus.toggle(enable: on);
    } catch (e) {
      DebugLog.instance.log('CALL', 'could not hold the screen on: $e');
    }
  },
);

/// The call, drawn over whatever the router is showing.
///
/// Kept inside the app lock: incoming calls never bypass the lock screen.
///
/// **This lives above the router, and that constrains everything under it.**
/// It is mounted in `MaterialApp.router`'s `builder` so a call survives
/// navigation, which means there is no Router, no Navigator and no Overlay
/// above anything it draws. A widget that looks one of those up throws while
/// building, and a release build paints that as an empty rectangle — here the
/// size of the screen. That shipped once: `BackButtonListener` asks for the
/// Router, and tapping Call on a real phone turned the screen white and left it
/// there. So back is taken from the router's own dispatcher, handed in from
/// app.dart, and the controls carry no tooltips (a tooltip needs an Overlay).
/// `test/call_screen_mount_test.dart` mounts this exactly as the app does; it
/// is the check that anything added here can actually be built.
///
/// **A call can be put away, the way Telegram puts one away.** The screen
/// folds into [CallIsland] — a capsule under the status bar with the name, the
/// time, mute and end — and the app underneath is usable again: chats open,
/// messages send, and a tap on the island brings the call back. The rest of the
/// app is told the island is there by a taller top inset, so every header moves
/// down under it instead of hiding behind it.
class CallHost extends ConsumerStatefulWidget {
  const CallHost({
    super.key,
    required this.child,
    required this.backButtonDispatcher,
  });
  final Widget child;

  /// The router's root dispatcher. While a call is on screen a child of it
  /// takes priority, so the back key answers the call screen instead of
  /// popping the page hidden underneath it.
  final BackButtonDispatcher backButtonDispatcher;

  @override
  ConsumerState<CallHost> createState() => _CallHostState();
}

class _CallHostState extends ConsumerState<CallHost>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ChildBackButtonDispatcher? _back;

  /// **The call screen rises from the bottom and goes back down.** It used to
  /// appear and vanish in a single frame - dialling, answering, putting the
  /// call away and closing it all cut straight to the next picture. "It
  /// should come up smoothly from the bottom and close downwards" was the ask.
  ///
  /// 0 is below the screen, 1 is in place. A slide rather than a fade: moving
  /// a finished layer is the cheap animation (see `BranchContainer`), and it
  /// is also the gesture a sheet makes.
  late final AnimationController _sheet;

  late final Animation<Offset> _slide;

  /// Made in [initState], not lazily: a `late final` first touched in
  /// [dispose] builds a ticker there, and a ticker asks the tree for
  /// `TickerMode` - which an unmounting element may no longer do.
  void _makeSheet() {
    _sheet = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
      reverseDuration: const Duration(milliseconds: 260),
    )..addStatusListener(_onSheetStatus);
    _slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _sheet,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );
  }

  void _onSheetStatus(AnimationStatus status) {
    // Gone for good only once it is out of sight. With Reduce Motion the jump
    // to 0 happens inside build, where a setState is not allowed, so there it
    // waits for the frame to finish.
    if (status != AnimationStatus.dismissed || !mounted) return;
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _sheet.isDismissed) setState(() => _leaving = null);
      });
    } else {
      setState(() => _leaving = null);
    }
  }

  /// The screen as it last looked, drawn while it slides away. The same
  /// widget instance, so nothing under it rebuilds on the way down - a call
  /// that has just been dismissed has no name left to show, and the screen
  /// would otherwise empty itself mid-slide.
  Widget? _leaving;
  bool _expandedBefore = false;

  /// Put away into the island. Reset for every new call, so a call that was
  /// minimised does not make the next one start out of sight.
  bool _minimized = false;
  String? _shownPeer;
  CallPhase? _shownPhase;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _makeSheet();
  }

  // Here rather than in the controller, which is plain Dart with no binding in
  // its tests. This widget lives as long as the app does, above the router.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(callControllerProvider).noteLifecycle(state);
    // Back from the system settings the Profile switch sent somebody to: the
    // only way that answer changes is out there, so it is read again here.
    if (state == AppLifecycleState.resumed) {
      unawaited(ref.read(callScreenAccessProvider.notifier).refresh());
      // Asked again: the system can drop the request while another app has
      // the screen, and nothing tells us it did.
      if (_screenHeld) unawaited(_setScreenOn(true));
    }
  }

  /// A call is filling the screen, so the phone has been asked to stay awake.
  bool _screenHeld = false;

  /// Read once, on first use: [dispose] has to be able to call it, and a
  /// widget that is going away may no longer ask `ref` for anything.
  late final Future<void> Function(bool) _setScreenOn =
      ref.read(keepScreenOnProvider);

  void _holdScreen(bool hold) {
    if (hold == _screenHeld) return;
    _screenHeld = hold;
    unawaited(_setScreenOn(hold));
  }

  Future<bool> _onBack() async {
    final call = ref.read(callControllerProvider);
    if (!call.active) {
      call.dismiss();
    } else if (CallIsland.canMinimize(call)) {
      // Back puts a live call away, as it does in Telegram. Hanging up stays a
      // button: back is a gesture people make without looking.
      setState(() => _minimized = true);
    }
    return true;
  }

  void _holdBack(bool showing) {
    if (showing && _back == null) {
      _back = widget.backButtonDispatcher.createChildBackButtonDispatcher()
        ..addCallback(_onBack)
        ..takePriority();
    } else if (!showing && _back != null) {
      // Removing its last callback makes a child dispatcher step back from
      // its parent on its own, so the router has back again.
      _back!.removeCallback(_onBack);
      _back = null;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _holdBack(false);
    _holdScreen(false);
    _sheet.dispose();
    super.dispose();
  }

  /// Start the slide the call's state asks for, from wherever it is now, so
  /// putting a call away mid-rise turns round instead of jumping.
  void _moveSheet(bool expanded) {
    if (expanded == _expandedBefore) return;
    _expandedBefore = expanded;
    final reduced = AppMotion.reduced(context);
    if (expanded) {
      if (reduced) {
        _sheet.value = 1;
      } else {
        unawaited(_sheet.forward());
      }
    } else {
      if (reduced) {
        _sheet.value = 0;
      } else {
        unawaited(_sheet.reverse());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final call = ref.watch(callControllerProvider);
    if (_shownPeer != call.peerId) {
      _shownPeer = call.peerId;
      _minimized = false;
    }
    // A call that starts ringing here always comes up full screen: the answer
    // button is not something to find inside a capsule.
    if (_shownPhase != call.phase) {
      if (call.phase == CallPhase.incoming) _minimized = false;
      _shownPhase = call.phase;
    }
    // A call that ends while put away has nothing left to show. Its outcome is
    // already in the chat, so it is dismissed rather than unfolding a "call
    // ended" screen over whatever the person was reading.
    if (_minimized && !call.active && call.peerId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final latest = ref.read(callControllerProvider);
        if (!latest.active) latest.dismiss();
      });
    }

    final showing = call.peerId != null;
    final island = showing && _minimized && call.active;
    final expanded = showing && !island && !(_minimized && !call.active);
    _holdBack(expanded);
    _moveSheet(expanded);
    // Full screen and still live ("so the screen does not go out", 2026-11-09).
    // Folded into the island the person is reading chats, and the phone should
    // sleep as it always does; a call that is over has nothing to watch.
    _holdScreen(expanded && call.active);
    if (expanded) {
      _leaving = CallScreen(
        call: call,
        onMinimize: CallIsland.canMinimize(call)
            ? () => setState(() => _minimized = true)
            : null,
      );
    }
    final screen = _leaving;
    final onScreen = screen != null &&
        (expanded || _sheet.status != AnimationStatus.dismissed);

    final media = MediaQuery.of(context);
    return Stack(children: [
      // Every screen under the island reads its top inset from here, so the
      // headers step down by the island's height instead of sitting under it.
      MediaQuery(
        data: island
            ? media.copyWith(
                padding: media.padding.copyWith(
                  top: media.padding.top + CallIsland.reservedHeight,
                ),
                viewPadding: media.viewPadding.copyWith(
                  top: media.viewPadding.top + CallIsland.reservedHeight,
                ),
              )
            : media,
        child: ExcludeFocus(excluding: expanded, child: widget.child),
      ),
      if (island)
        Positioned(
          top: media.padding.top + 4,
          left: 10,
          right: 10,
          child: CallIsland(
            call: call,
            onExpand: () => setState(() => _minimized = false),
          ),
        ),
      if (onScreen)
        Positioned.fill(
          // On its way down it no longer takes touches: the app underneath is
          // already the one being used.
          child: IgnorePointer(
            ignoring: !expanded,
            child: SlideTransition(
              position: _slide,
              child: RepaintBoundary(child: screen),
            ),
          ),
        ),
    ]);
  }
}

/// The call, folded into a capsule at the top of the app.
///
/// Telegram's shape for the same thing: who, how long, and the two controls a
/// call is most often reached for without going back into it — the microphone
/// and the red button. Everything else is a tap away on the full screen.
class CallIsland extends StatelessWidget {
  const CallIsland({super.key, required this.call, required this.onExpand});

  final CallController call;
  final VoidCallback onExpand;

  static const double height = 52;

  /// What the island takes from the top of the app, its margins included.
  static const double reservedHeight = height + 8;

  /// Any live call can be put away except one still ringing here, whose answer
  /// button has to stay in reach.
  static bool canMinimize(CallController call) =>
      call.active && call.phase != CallPhase.incoming;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final talking = call.phase == CallPhase.talking;
    final status = talking
        ? callClock(call.elapsed)
        : call.preparing
            ? t.callPreparing
            : switch (call.phase) {
                CallPhase.dialing => t.callDialing,
                CallPhase.ringing => t.callRinging,
                CallPhase.connecting => t.callConnecting,
                _ => '',
              };
    // The nav bar's own pane of glass. It was a green gradient with a wide
    // soft shadow of its own, which painted a dark band round the capsule -
    // reported as "there is a background, a shadow or a border behind it, and
    // there should not be; make it like the bar's island". [BarGlass] is that
    // island, with its tight shadows and hairline, so the two cannot drift.
    return Semantics(
      container: true,
      button: true,
      label: '${call.name}, $status',
      child: BarGlass(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onExpand,
            customBorder: const StadiumBorder(),
            child: SizedBox(
              height: height,
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  PeerAvatar(
                    peerId: call.peerId ?? '',
                    label: call.name,
                    size: 40,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          call.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textOnGlass,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          status,
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.brandPrimary,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (talking)
                    _IslandButton(
                      icon: call.micMuted
                          ? Icons.mic_off_rounded
                          : Icons.mic_rounded,
                      label: t.callMicrophone,
                      background: call.micMuted
                          ? AppColors.textOnGlass
                          : AppColors.glass(0.14),
                      foreground: call.micMuted
                          ? AppColors.bgDeep
                          : AppColors.textOnGlass,
                      onTap: () => unawaited(call.toggleMute()),
                    ),
                  const SizedBox(width: 6),
                  _IslandButton(
                    icon: Icons.call_end_rounded,
                    label: t.callEnd,
                    background: AppColors.danger,
                    foreground: Colors.white,
                    onTap: () => call.hangUp(),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IslandButton extends StatelessWidget {
  const _IslandButton({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: label,
        excludeSemantics: true,
        child: Material(
          color: background,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(icon, size: 22, color: foreground),
            ),
          ),
        ),
      );
}

/// `3:07`, `12:45`, `1:02:09` — the way a call's length is read aloud.
String callClock(Duration elapsed) {
  final hours = elapsed.inHours;
  final minutes = elapsed.inMinutes.remainder(60);
  final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (hours > 0) {
    return '$hours:${minutes.toString().padLeft(2, '0')}:$seconds';
  }
  return '$minutes:$seconds';
}

/// How big the small picture is for a video of this width-to-height.
///
/// Shaped like the video, so all of it shows. It was a fixed 104 × 144, and a
/// phone's upright 9:16 picture filled that by losing its top and bottom —
/// asked for against Telegram's, "so it takes in more of the video"
/// (screenshots, 2026-11-09). A computer's camera is wide, so it gets a wide
/// frame rather than a slice out of its middle.
@visibleForTesting
Size smallPictureSize(double aspect) {
  if (aspect >= 1) {
    const width = 176.0;
    return Size(width, (width / aspect).clamp(90.0, 140.0));
  }
  const width = 104.0;
  return Size(width, (width / aspect).clamp(140.0, 200.0));
}

/// How far above the bottom of the screen the small picture sits: just over
/// the buttons and any pills on them, and down in the corner once a tap has
/// sent those away, the way Telegram's does.
@visibleForTesting
double smallPictureBottom({
  required double inset,
  required double rowHeight,
  required int notices,
  required bool controlsHidden,
}) {
  if (controlsHidden) return inset + 16;
  // The screen's 32 under the row, the 12 between row and pills, 34 a pill.
  return inset + 32 + rowHeight + 12 + notices * 34;
}

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key, required this.call, this.onMinimize});

  /// Folds the screen into [CallIsland]. Null while that is not allowed — a
  /// call still ringing here, or one already over.
  final VoidCallback? onMinimize;
  final CallController call;

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  /// The list of places the sound can go, open over the controls.
  bool _routesOpen = false;

  /// Their picture fills the screen, so the words on it are white over a
  /// shade rather than the theme's text colour over the theme's background.
  bool _overVideo = false;

  /// Our camera big and theirs small, after a tap on the small picture.
  bool _swapped = false;

  /// The buttons have floated off the bottom, after a tap on the screen — "tap
  /// and the buttons sail down, like in Telegram" (2026-11-09).
  bool _controlsHidden = false;

  /// Whether a tap may do that at all; see where it is set in [build].
  bool _canHideControls = false;

  /// Width over height of the small picture, once its renderer knows. Upright
  /// until then: that is what a phone sends.
  double _smallAspect = 9 / 16;

  void _noteSmallAspect(double aspect) {
    if (mounted && (aspect - _smallAspect).abs() > 0.01) {
      setState(() => _smallAspect = aspect);
    }
  }

  CallController get call => widget.call;

  /// The whole screen is the switch. Wrapped round the finished screen: a
  /// detector inside the [Stack] would sit under the scroll view, which takes
  /// every hit. The buttons and the small picture are deeper and win their own
  /// taps, so only the empty parts of the screen reach this.
  Widget _tapTogglesControls(Widget screen) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        excludeFromSemantics: true,
        onTap: _canHideControls
            ? () => setState(() => _controlsHidden = !_controlsHidden)
            : null,
        child: screen,
      );

  Future<void> _onSpeaker() async {
    await call.refreshAudioRoutes();
    if (!mounted) return;
    // Two places to choose between is a switch; three or more is a list.
    if (call.hasHeadsetRoute) {
      setState(() => _routesOpen = true);
    } else {
      await call.toggleSpeaker();
    }
  }

  /// The route the sound is on, as far as this screen can tell: chosen by
  /// name, or the speaker switch.
  CallAudioRouteKind get _route =>
      call.audioRoute ??
      (call.speakerOn
          ? CallAudioRouteKind.speaker
          : call.hasHeadsetRoute
              ? call.audioRoutes
                  .firstWhere(
                    (r) =>
                        r.kind == CallAudioRouteKind.bluetooth ||
                        r.kind == CallAudioRouteKind.wired,
                  )
                  .kind
              : CallAudioRouteKind.earpiece);

  static IconData routeIcon(CallAudioRouteKind kind) => switch (kind) {
        CallAudioRouteKind.earpiece => Icons.phone_in_talk_rounded,
        CallAudioRouteKind.speaker => Icons.volume_up_rounded,
        CallAudioRouteKind.bluetooth => Icons.bluetooth_audio_rounded,
        CallAudioRouteKind.wired => Icons.headphones_rounded,
      };

  static String routeLabel(AppLocalizations t, CallAudioRoute route) =>
      switch (route.kind) {
        CallAudioRouteKind.earpiece => t.callRoutePhone,
        CallAudioRouteKind.speaker => t.callSpeaker,
        // The device's own name when it has one: "AirPods Pro" says which
        // headset, where "Bluetooth" does not.
        CallAudioRouteKind.bluetooth =>
          route.label.isEmpty ? t.callRouteBluetooth : route.label,
        CallAudioRouteKind.wired => t.callRouteHeadphones,
      };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final talking = call.phase == CallPhase.talking;
    final incoming = call.phase == CallPhase.incoming && !call.preparing;
    // Their picture while it arrives; their face and name the way a voice
    // call shows them while it does not — camera off, app in the background,
    // or a build without video on their end.
    final remote = call.active ? call.remoteVideo : null;
    final local = call.active && call.cameraOn ? call.localVideo : null;
    // The big picture is theirs. With none arriving it is our own, the way
    // a video call shows you yourself while it rings, and the small one then
    // has nothing to show. A tap on the small one swaps the two.
    final swap = _swapped && remote != null && local != null;
    final big = swap ? local : (remote ?? local);
    final small = swap ? remote : (remote != null ? local : null);
    final mirrorBig = identical(big, local) && call.frontCamera;
    final mirrorSmall = identical(small, local) && call.frontCamera;
    final status = call.preparing
        ? t.callPreparing
        : switch (call.phase) {
            CallPhase.incoming =>
              call.video ? t.callIncomingVideo : t.previewCallIncoming,
            CallPhase.dialing => t.callDialing,
            CallPhase.ringing => t.callRinging,
            CallPhase.connecting => t.callConnecting,
            CallPhase.talking => callClock(call.elapsed),
            _ => switch (call.error) {
                'microphone' => PlatformInfo.isWindows
                    ? t.callMicrophoneWindows
                    : t.callMicrophoneRequired,
                'elsewhere' => t.callElsewhere,
                'turn' => t.callRelayUnavailable,
                'busy' => t.callBusy,
                'noAnswer' => t.callNoAnswer,
                'unavailable' || 'media' || 'failed' => t.callFailed,
                'declined' => t.callDeclined,
                _ => t.callEnded,
              },
          };
    if (_routesOpen && !call.canUseSpeaker) _routesOpen = false;

    final route = _route;
    final routeName = switch (route) {
      CallAudioRouteKind.earpiece => t.callRoutePhone,
      CallAudioRouteKind.speaker => t.callSpeaker,
      CallAudioRouteKind.bluetooth => t.callRouteBluetooth,
      CallAudioRouteKind.wired => t.callRouteHeadphones,
    };

    // One row, spread across the width. The controls used to be a centred
    // `Wrap` of fixed 90-point cells, so two buttons huddled in the middle and
    // four wrapped onto a second line on a narrow phone. Asked for as "align
    // the icons across the width": every button gets an equal share of it.
    //
    // The microphone is there for the whole of a live call, the ringing
    // included: the person being called can answer already muted.
    //
    // Answer before Decline. They were the other way round, and "swap answer
    // and decline" was asked for - which also leaves the red button at the
    // right-hand end in every state of the call, ringing or talking.
    //
    // Left to right (asked for with screenshots, 2026-11-03): where the sound
    // goes, the camera, the microphone, then the red button. With our camera
    // on, the first place is flipping it, and the sound moves to the corner
    // of the header — a face on screen is a phone held away from the ear.
    final flipFirst = local != null && !incoming;
    final controls = <Widget>[
      if (flipFirst)
        _control(
          Icons.cameraswitch_rounded,
          t.callFlipCamera,
          () => unawaited(call.switchCamera()),
          selected: true,
        )
      // From the moment this phone dials, not only once the other side
      // answers: the ringing can go on the loudspeaker too.
      else if (call.canUseSpeaker)
        _control(
          routeIcon(route),
          call.hasHeadsetRoute ? routeName : t.callSpeaker,
          () => unawaited(_onSpeaker()),
          selected: route != CallAudioRouteKind.earpiece,
        ),
      // While a video call rings, so the person called can answer with the
      // camera already off; once any call is answered, so a voice call can
      // become a video one. Lit white while it is *off*, like the muted
      // microphone beside it: white is the state somebody has to notice.
      if (call.canVideo)
        _control(
          call.cameraOn ? Icons.videocam_rounded : Icons.videocam_off_rounded,
          t.callCamera,
          () => unawaited(call.toggleCamera()),
          selected: !call.cameraOn,
        ),
      if (call.active)
        _control(
          call.micMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
          t.callMicrophone,
          () => unawaited(call.toggleMute()),
          selected: call.micMuted,
        ),
      if (incoming)
        _control(
          call.video && call.cameraOn
              ? Icons.videocam_rounded
              : Icons.call_rounded,
          t.callAnswer,
          () => unawaited(call.answer()),
          tone: AppColors.brandPrimary,
        ),
      if (call.active)
        _control(
          Icons.call_end_rounded,
          incoming ? t.callDecline : t.callEnd,
          incoming ? () => call.decline() : () => call.hangUp(),
          tone: AppColors.danger,
        )
      else
        _control(Icons.close_rounded, t.callClose, call.dismiss),
    ];

    _overVideo = big != null;
    // What the person on the other end has to be told about, in pills over
    // the buttons. Their microphone is not here: nothing on the wire says it.
    final micNotice = call.active && call.micMuted;
    final cameraNotice = talking && call.video && remote == null;
    final cornerSpeaker = flipFirst && call.canUseSpeaker;
    // Only during the conversation. Ringing, the answer button must not be one
    // stray tap from invisible; over, neither must Close — and leaving
    // [talking] brings the buttons back by itself. Never for a screen reader
    // either: buttons that have left the screen are buttons it cannot reach.
    _canHideControls =
        talking && !(MediaQuery.maybeAccessibleNavigationOf(context) ?? false);
    if (!_canHideControls) _controlsHidden = false;
    final statusKey = call.preparing ? 'preparing' : call.phase.name;
    final smallSize = smallPictureSize(_smallAspect);
    final smallBottom = smallPictureBottom(
      inset: MediaQuery.paddingOf(context).bottom,
      // The disc, the gap and one line of label — see [_ControlButton].
      rowHeight: 72 + MediaQuery.textScalerOf(context).scale(20),
      notices: (micNotice ? 1 : 0) + (cameraNotice ? 1 : 0),
      controlsHidden: _controlsHidden,
    );
    // From the first moment: `preparing` comes before any of the phases, and
    // a ring that started only after it would look like a late hiccup.
    final pulsing = call.preparing ||
        call.phase == CallPhase.dialing ||
        call.phase == CallPhase.ringing ||
        call.phase == CallPhase.incoming;
    final screen = Material(
      color: AppColors.bgDeep,
      child: Stack(
        children: [
          if (big != null) ...[
            Positioned.fill(
              child: _VideoSurface(stream: big, mirror: mirrorBig),
            ),
            // Two short shades rather than one over the whole picture: the
            // name at the top and the labels at the bottom stay readable on
            // a white wall behind somebody, and the face in the middle is
            // left as it came.
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 150,
              child: _Shade(fromTop: true),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 200,
              child: _Shade(fromTop: false),
            ),
          ],
          SafeArea(
            child: LayoutBuilder(
              builder: (context, bounds) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: bounds.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              if (widget.onMinimize != null)
                                Semantics(
                                  button: true,
                                  label: t.callMinimize,
                                  excludeSemantics: true,
                                  child: IconButton(
                                    onPressed: widget.onMinimize,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                      color: _overVideo
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(width: 48),
                              Expanded(
                                child: big != null
                                    // The face takes the middle, so who and
                                    // how long move up here.
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            call.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            status,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFeatures: [
                                                FontFeature.tabularFigures(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        call.video || call.cameraOn
                                            ? t.callVideo
                                            : t.callVoice,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                              if (cornerSpeaker)
                                Semantics(
                                  button: true,
                                  label: call.hasHeadsetRoute
                                      ? routeName
                                      : t.callSpeaker,
                                  excludeSemantics: true,
                                  child: IconButton(
                                    onPressed: () => unawaited(_onSpeaker()),
                                    icon: Icon(
                                      routeIcon(route),
                                      size: 26,
                                      color: _overVideo
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(width: 48),
                            ],
                          ),
                        ),
                        if (big == null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 36,
                            horizontal: 12,
                          ),
                          child: Column(children: [
                            // Their picture when they have shared one, the same
                            // face the chat list shows; initials otherwise.
                            _PulsingAvatar(
                              pulsing: pulsing,
                              size: 120,
                              child: PeerAvatar(
                                peerId: call.peerId ?? '',
                                label: call.name,
                                size: 120,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              call.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Semantics(
                              liveRegion: !talking,
                              // Keyed by the state, not the words: the clock
                              // changes its text every second and must not
                              // cross-fade with itself.
                              child: AnimatedSwitcher(
                                duration: AppMotion.duration(
                                  context,
                                  AppMotion.control,
                                ),
                                child: Text(
                                  status,
                                  key: ValueKey(statusKey),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontFeatures: const [
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        _ControlsDrawer(
                          hidden: _controlsHidden,
                          child: Column(
                            children: [
                              // No height of its own, the pills standing up
                              // out of it: this column shares the screen with
                              // the centred face by `spaceBetween`, so a pill
                              // that took room made the face jump every time
                              // the microphone was muted.
                              SizedBox(
                                height: 0,
                                width: double.infinity,
                                child: OverflowBox(
                                  alignment: Alignment.bottomCenter,
                                  minHeight: 0,
                                  maxHeight: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _NoticeSlot(
                                          visible: micNotice,
                                          icon: Icons.mic_off_rounded,
                                          text: t.callYourMicOff,
                                        ),
                                        _NoticeSlot(
                                          visible: cameraNotice,
                                          icon: Icons.videocam_off_rounded,
                                          text: t.callTheirCameraOff(call.name),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  for (final control in controls)
                                    Expanded(child: control),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // The second picture, small, in the bottom corner over the buttons
          // — where Telegram keeps it (screenshots, 2026-11-09) — following
          // them down when they go. A front camera is mirrored, the way a
          // face is used to seeing itself. A tap swaps it with the big one.
          if (small != null)
            AnimatedPositioned(
              duration: AppMotion.duration(
                context,
                _controlsHidden ? AppMotion.expand : AppMotion.entrance,
              ),
              curve: AppMotion.curve,
              bottom: smallBottom,
              right: 16,
              width: smallSize.width,
              height: smallSize.height,
              // Fades in, and goes at once: fading it out would keep a
              // renderer on a stream the camera has already let go of, for
              // the sake of 200 ms.
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: AppMotion.duration(context, AppMotion.control),
                builder: (_, opacity, child) =>
                    Opacity(opacity: opacity, child: child),
                child: GestureDetector(
                  onTap: () => setState(() => _swapped = !_swapped),
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.glass(0.22)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: ColoredBox(
                        color: Colors.black,
                        child: _VideoSurface(
                          stream: small,
                          mirror: mirrorSmall,
                          onAspect: _noteSmallAspect,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_routesOpen)
            Positioned.fill(
              child: _RoutePicker(
                routes: call.audioRoutes,
                current: route,
                label: (r) => routeLabel(t, r),
                icon: routeIcon,
                title: t.callAudioOutput,
                onPick: (r) {
                  setState(() => _routesOpen = false);
                  unawaited(call.selectAudioRoute(r));
                },
                onClose: () => setState(() => _routesOpen = false),
              ),
            ),
        ],
      ),
    );
    return _tapTogglesControls(screen);
  }

  Widget _control(
    IconData icon,
    String label,
    VoidCallback action, {
    bool selected = false,
    Color? tone,
  }) =>
      _ControlButton(
        icon: icon,
        label: label,
        onPressed: action,
        selected: selected,
        tone: tone,
        overVideo: _overVideo,
      );
}

/// The buttons and the pills over them, which a tap on the screen sends down
/// off the bottom and a second tap brings back.
///
/// A translation, so the face in the middle does not move: this column keeps
/// its room in the layout the whole time. Opacity goes with it, because with
/// Reduce Motion on the fade is all that is left of the gesture.
class _ControlsDrawer extends StatelessWidget {
  const _ControlsDrawer({required this.hidden, required this.child});

  final bool hidden;
  final Widget child;

  /// In heights of the row: past the bottom inset and the padding under the
  /// row, and far enough that two pills standing on it go too.
  static const double _away = 2.6;

  @override
  Widget build(BuildContext context) {
    final curve = hidden ? Curves.easeInCubic : Curves.easeOutCubic;
    final duration = hidden ? AppMotion.expand : AppMotion.entrance;
    return IgnorePointer(
      ignoring: hidden,
      child: AnimatedSlide(
        offset: hidden && !AppMotion.reduced(context)
            ? const Offset(0, _away)
            : Offset.zero,
        duration: duration,
        curve: curve,
        child: AnimatedOpacity(
          opacity: hidden ? 0 : 1,
          duration: duration,
          curve: curve,
          child: child,
        ),
      ),
    );
  }
}

/// A soft ring breathing out from behind the face while the call rings.
///
/// Stops the moment nobody is waiting any more: a call is the hottest thing
/// this app does, so nothing here runs during the conversation, and the ticker
/// goes away with the screen when the call is folded into the island. Inside
/// a [RepaintBoundary] so a frame of it repaints the ring and not the screen.
/// It takes no room — the ring grows past the avatar's own box — so the name
/// under it stays where it is.
class _PulsingAvatar extends StatefulWidget {
  const _PulsingAvatar({
    required this.pulsing,
    required this.size,
    required this.child,
  });

  final bool pulsing;
  final double size;
  final Widget child;

  @override
  State<_PulsingAvatar> createState() => _PulsingAvatarState();
}

class _PulsingAvatarState extends State<_PulsingAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );

  void _follow() {
    final run = widget.pulsing && !AppMotion.reduced(context);
    if (run && !_pulse.isAnimating) {
      unawaited(_pulse.repeat());
    } else if (!run && _pulse.isAnimating) {
      _pulse.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _follow();
  }

  @override
  void didUpdateWidget(_PulsingAvatar old) {
    super.didUpdateWidget(old);
    _follow();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Widget _disc(double alpha) => SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.textPrimary.withValues(alpha: alpha),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final grown = CurvedAnimation(parent: _pulse, curve: Curves.easeOutCubic);
    // With Reduce Motion the ring holds still rather than disappearing, the
    // way the online dot holds a lit frame: it still says "this is ringing".
    final Widget ring = AppMotion.reduced(context)
        ? Transform.scale(
            key: const ValueKey('still'),
            scale: 1.14,
            child: _disc(0.14),
          )
        : FadeTransition(
            key: const ValueKey('pulse'),
            opacity: Tween<double>(begin: 0.28, end: 0).animate(grown),
            child: ScaleTransition(
              scale: Tween<double>(begin: 1, end: 1.45).animate(grown),
              child: _disc(1),
            ),
          );
    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              // Answering fades the ring out where it stands, instead of
              // cutting it off mid-breath.
              child: AnimatedSwitcher(
                duration: AppMotion.duration(context, AppMotion.control),
                child: widget.pulsing
                    ? ring
                    : const SizedBox.shrink(key: ValueKey('none')),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

/// One round button of the call and the word under it.
///
/// Dips while a finger is on it and eases between its lit and unlit colours,
/// so a mute that took is something you see happen.
class _ControlButton extends StatefulWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.selected,
    required this.tone,
    required this.overVideo,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool selected;
  final Color? tone;
  final bool overVideo;

  @override
  State<_ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<_ControlButton> {
  bool _down = false;

  void _press(bool down) {
    if (_down != down) setState(() => _down = down);
  }

  // No tooltip: a tooltip needs an Overlay, and there is none above this
  // screen (see [CallHost]). The label is drawn under the button, and the
  // Semantics wrapper gives a screen reader the same word the tooltip did.
  @override
  Widget build(BuildContext context) {
    final tone = widget.tone;
    // White when lit, a frosted white when not (asked for with screenshots,
    // 2026-11-03): the same over the dark field and over a picture.
    final background = tone ??
        (widget.selected ? Colors.white : Colors.white.withValues(alpha: 0.22));
    final foreground = tone != null
        ? Colors.white
        : widget.selected
            ? AppColors.bgDeep
            : Colors.white;
    final change = AppMotion.duration(context, AppMotion.control);
    return Column(
      children: [
        Semantics(
          button: true,
          label: widget.label,
          excludeSemantics: true,
          // A Listener and not the button's own callbacks: it sees the finger
          // land and lift without taking part in deciding whether it tapped.
          child: Listener(
            onPointerDown: (_) => _press(true),
            onPointerUp: (_) => _press(false),
            onPointerCancel: (_) => _press(false),
            child: AnimatedScale(
              scale: _down && !AppMotion.reduced(context) ? 0.9 : 1,
              duration: AppMotion.feedback,
              curve: AppMotion.curve,
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(end: background),
                duration: change,
                builder: (_, fill, __) => TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: foreground),
                  duration: change,
                  builder: (_, ink, __) => IconButton.filledTonal(
                    onPressed: widget.onPressed,
                    isSelected: widget.selected,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(64, 64),
                      backgroundColor: fill,
                      foregroundColor: ink,
                    ),
                    // Coloured here: a selected filled-tonal button repaints
                    // its icon in its own scheme colour, which is white on
                    // the white disc.
                    icon: AnimatedSwitcher(
                      duration: change,
                      child: Icon(
                        widget.icon,
                        key: ValueKey(widget.icon),
                        size: 28,
                        color: ink,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Shrunk to its cell rather than cut: five controls leave about 72
        // points each on a 360 phone, and "Lautsprecher" or "Altoparlante"
        // ended in an ellipsis that hid which button it was.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.label,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.overVideo ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

/// One picture of a video call — theirs filling the screen, or ours in the
/// corner. Owns its renderer: made when the picture appears, let go when it
/// does, so a call with the camera off holds no texture at all.
class _VideoSurface extends StatefulWidget {
  const _VideoSurface({
    required this.stream,
    this.mirror = false,
    this.onAspect,
  });

  final MediaStream stream;
  final bool mirror;

  /// Told the picture's width over height when it starts and whenever it
  /// turns or changes size — not per frame.
  final ValueChanged<double>? onAspect;

  @override
  State<_VideoSurface> createState() => _VideoSurfaceState();
}

class _VideoSurfaceState extends State<_VideoSurface> {
  final _renderer = RTCVideoRenderer();
  bool _ready = false;
  bool _gone = false;

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  Future<void> _start() async {
    await _renderer.initialize();
    // Gone while the texture was being made: nobody else will free it.
    if (_gone) {
      await _renderer.dispose();
      return;
    }
    _renderer.addListener(_reportAspect);
    _renderer.srcObject = widget.stream;
    setState(() => _ready = true);
  }

  void _reportAspect() {
    final video = _renderer.value;
    if (video.width > 0 && video.height > 0) {
      widget.onAspect?.call(video.aspectRatio);
    }
  }

  @override
  void didUpdateWidget(_VideoSurface old) {
    super.didUpdateWidget(old);
    if (_ready && old.stream != widget.stream) {
      _renderer.srcObject = widget.stream;
    }
  }

  @override
  void dispose() {
    _gone = true;
    if (_ready) {
      _renderer.removeListener(_reportAspect);
      unawaited(_renderer.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ready
      ? RTCVideoView(
          _renderer,
          mirror: widget.mirror,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        )
      : const SizedBox.expand();
}

/// One thing the other side should know — "your microphone is off" — in a
/// small pill centred over the buttons. It rises from below as it appears and
/// sinks back down as it goes ("appear from the bottom and leave downwards",
/// asked for 2026-11-03), taking its row with it so the pills above close the
/// gap.
class _NoticeSlot extends StatelessWidget {
  const _NoticeSlot({
    required this.visible,
    required this.icon,
    required this.text,
  });

  final bool visible;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: AppMotion.duration(context, AppMotion.entrance),
        reverseDuration: AppMotion.duration(context, AppMotion.control),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => SizeTransition(
          sizeFactor: animation,
          axisAlignment: 1,
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.8),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
        ),
        child: visible
            ? Padding(
                key: const ValueKey(true),
                padding: const EdgeInsets.only(top: 6),
                child: _Notice(icon: icon, text: text),
              )
            : const SizedBox(key: ValueKey(false), width: double.infinity),
      );
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        // Low on purpose ("not so tall", 2026-11-09): two of these stack, and
        // at 15-point text with 8 above and below they were a wall over the
        // buttons.
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          // A frosted white, like the unlit buttons under it: a dark pill
          // vanished into the call's dark field.
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: Colors.white),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      );
}

/// A short fade to black at one edge of the picture.
class _Shade extends StatelessWidget {
  const _Shade({required this.fromTop});

  final bool fromTop;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
              end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
              colors: [
                Colors.black.withValues(alpha: 0.55),
                Colors.black.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      );
}

/// Where the call's sound goes: the phone, the loudspeaker, a wired headset,
/// each Bluetooth one by its own name.
///
/// Drawn inside the call screen rather than as a bottom sheet, because there is
/// no Navigator above it to push one onto (see [CallHost]).
class _RoutePicker extends StatelessWidget {
  const _RoutePicker({
    required this.routes,
    required this.current,
    required this.label,
    required this.icon,
    required this.title,
    required this.onPick,
    required this.onClose,
  });

  final List<CallAudioRoute> routes;
  final CallAudioRouteKind current;
  final String Function(CallAudioRoute) label;
  final IconData Function(CallAudioRouteKind) icon;
  final String title;
  final ValueChanged<CallAudioRoute> onPick;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.45),
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                decoration: BoxDecoration(
                  color: AppColors.bgDeep,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.glass(0.14)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    for (final route in routes)
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => onPick(route),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Icon(icon(route.kind),
                                    color: AppColors.textPrimary),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    label(route),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                if (route.kind == current)
                                  Icon(Icons.check_rounded,
                                      color: AppColors.brandPrimary),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
