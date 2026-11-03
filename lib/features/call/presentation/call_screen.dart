import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart'
    show MediaStream, RTCVideoRenderer, RTCVideoView, RTCVideoViewObjectFit;
import '../../../core/theme/colors.dart';
import '../../../core/util/motion.dart';
import '../../../core/util/platform_info.dart';
import '../../../core/widgets/bar_glass.dart';
import '../../../l10n/app_localizations.dart';
import '../../peers/presentation/widgets/peer_avatar.dart';
import '../data/call_controller.dart';
import '../data/call_media.dart';
import '../data/call_screen_access.dart';
import '../domain/call_state_machine.dart';

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
    }
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

  CallController get call => widget.call;

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

    // White words everywhere now: over a picture under its shades, and over
    // the coloured field a call without one is drawn on.
    _overVideo = true;
    final top = MediaQuery.paddingOf(context).top;
    // What the person on the other end has to be told about, in pills over
    // the buttons. Their microphone is not here: nothing on the wire says it.
    final notices = <(IconData, String)>[
      if (call.active && call.micMuted)
        (Icons.mic_off_rounded, t.callYourMicOff),
      if (talking && call.video && remote == null)
        (Icons.videocam_off_rounded, t.callTheirCameraOff(call.name)),
    ];
    final cornerSpeaker = flipFirst && call.canUseSpeaker;
    return Material(
      color: AppColors.bgDeep,
      child: Stack(
        children: [
          // A call without a picture is drawn on a field of the theme's own
          // colour: cooler while it is being placed, the brand's once it is
          // talking, so a glance says which. Two stops, one paint — no
          // animation runs while it holds still.
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                gradient: _callField(talking: talking),
              ),
            ),
          ),
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
          // Fills the screen and still scrolls on one too short for it — a
          // landscape phone, a large interface size — with room for the
          // spacers that put the avatar in the middle and the buttons at the
          // foot.
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
                    child: Column(
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
                                    icon: const Icon(
                                      Icons.close_fullscreen_rounded,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(width: 48),
                              const Spacer(),
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
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(width: 48),
                            ],
                          ),
                        ),
                        if (big == null) const Spacer(),
                        // Who and how long, large. Under the avatar while
                        // there is no picture; at the top over a face, which
                        // takes the middle of the screen.
                        Padding(
                          padding: EdgeInsets.only(
                            top: big == null ? 28 : 0,
                            bottom: big == null ? 36 : 0,
                            left: 12,
                            right: 12,
                          ),
                          child: Column(children: [
                            if (big == null) ...[
                              // Their picture when they have shared one, the
                              // same face the chat list shows; initials
                              // otherwise. In two soft rings, so it reads as
                              // the call's subject from across a room.
                              _Halo(
                                child: PeerAvatar(
                                  peerId: call.peerId ?? '',
                                  label: call.name,
                                  size: 150,
                                ),
                              ),
                              const SizedBox(height: 22),
                            ],
                            Text(
                              call.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Semantics(
                              liveRegion: !talking,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (talking && call.linkBars > 0) ...[
                                    _SignalBars(bars: call.linkBars),
                                    const SizedBox(width: 6),
                                  ],
                                  Flexible(
                                    child: Text(
                                      status,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.9),
                                        fontSize: 16,
                                        fontFeatures: const [
                                          FontFeature.tabularFigures(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            for (final (icon, text) in notices)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: _Notice(icon: icon, text: text),
                              ),
                            if (notices.isNotEmpty)
                              const SizedBox(height: 12),
                            Row(
                              children: [
                                for (final control in controls)
                                  Expanded(child: control),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The second picture, small, under the header — where FaceTime and
          // Telegram keep it. A front camera is mirrored, the way a face is
          // used to seeing itself. A tap swaps it with the big one.
          if (small != null)
            Positioned(
              // Below the name and the clock, which now stand at the top over
              // the picture.
              top: top + 150,
              right: 16,
              width: 104,
              height: 144,
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
  }

  // No tooltip: a tooltip needs an Overlay, and there is none above this
  // screen (see [CallHost]). The label is drawn under the button, and the
  // Semantics wrapper gives a screen reader the same word the tooltip did.
  Widget _control(
    IconData icon,
    String label,
    VoidCallback action, {
    bool selected = false,
    Color? tone,
  }) {
    // White when lit, a frosted white when not: over the coloured field and
    // over a picture alike, rather than the theme's glass, which disappears
    // into a field of the theme's own colour.
    final background = tone ??
        (selected ? Colors.white : Colors.white.withValues(alpha: 0.22));
    final foreground = tone != null
        ? Colors.white
        : selected
            ? AppColors.bgDeep
            : Colors.white;
    return Column(
      children: [
        Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: IconButton.filledTonal(
            onPressed: action,
            isSelected: selected,
            style: IconButton.styleFrom(
              minimumSize: const Size(64, 64),
              backgroundColor: background,
              foregroundColor: foreground,
            ),
            // Coloured here: a selected filled-tonal button repaints its icon
            // in its own scheme colour, which is white on the white disc.
            icon: Icon(icon, size: 28, color: foreground),
          ),
        ),
        const SizedBox(height: 8),
        // Shrunk to its cell rather than cut: five controls leave about 72
        // points each on a 360 phone, and "Lautsprecher" or "Altoparlante"
        // ended in an ellipsis that hid which button it was.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _overVideo ? Colors.white : AppColors.textPrimary,
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
  const _VideoSurface({required this.stream, this.mirror = false});

  final MediaStream stream;
  final bool mirror;

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
    _renderer.srcObject = widget.stream;
    setState(() => _ready = true);
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
    if (_ready) unawaited(_renderer.dispose());
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

/// The field a call is drawn on when there is no picture: the theme's own
/// colour, from the brand to its lighter partner, kept dark enough for white
/// words. While the call is being placed the same two colours are turned a
/// sixth of the wheel towards blue, so ringing and talking look different at
/// a glance in every theme.
LinearGradient _callField({required bool talking}) {
  Color tone(Color c, double lightness) {
    final hsl = HSLColor.fromColor(c);
    final hue = talking ? hsl.hue : (hsl.hue + 60) % 360;
    return hsl
        .withHue(hue)
        .withLightness(lightness)
        .withSaturation((hsl.saturation * 0.85).clamp(0.0, 1.0))
        .toColor();
  }

  return LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      tone(AppColors.brandSecondary, 0.50),
      tone(AppColors.brandPrimary, 0.38),
    ],
  );
}

/// The avatar in two soft rings.
class _Halo extends StatelessWidget {
  const _Halo({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: 210,
        height: 210,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.08),
        ),
        child: Container(
          width: 180,
          height: 180,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.10),
          ),
          child: child,
        ),
      );
}

/// Four rising bars, [bars] of them lit — the link as the voice's own
/// feedback measures it ([CallMedia.linkBars]).
class _SignalBars extends StatelessWidget {
  const _SignalBars({required this.bars});

  final int bars;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < 4; i++) ...[
            if (i > 0) const SizedBox(width: 2),
            Container(
              width: 3,
              height: 5.0 + i * 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: Colors.white.withValues(alpha: i < bars ? 1 : 0.35),
              ),
            ),
          ],
        ],
      );
}

/// One thing the other side should know — "your microphone is off" — in a
/// dark pill over the buttons.
class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 15),
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
