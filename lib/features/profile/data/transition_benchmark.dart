import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/glass.dart';
import '../../../core/util/debug_log.dart';
import '../../../core/util/frame_stats.dart';
import '../../../core/util/transition_probe.dart';

/// One way of opening the chat in a scripted run.
enum BenchVariant {
  /// Whatever the phone is set to.
  asIs,

  /// The other answer to [TransitionProbe.keepUnderlay]: the screen underneath
  /// a chat kept painted if the phone takes it off stage, and the reverse.
  ///
  /// It was `opaque` while keeping it painted was the default (1065-1163);
  /// flipping rather than naming one side keeps the comparison when the
  /// default moves, which it did in 1164.
  otherUnderlay,
}

/// Opens and closes one conversation from the chat list, the same way every
/// time, in each [BenchVariant] in turn, and files what each cost.
///
/// Hand-tapped logs could not tell builds apart. 1055 and 1057 are the same
/// code and read 8.6 and 5.7 frames over 8.3 ms per chat open — the noise was
/// as large as any change being measured, because a thumb opens the next chat
/// while the last close is still settling, at a different pace every session,
/// on a phone warming up as it goes. Here every open waits the same time, every
/// close does too, and the variants take turns, so heat and battery drift land
/// on all of them.
///
/// The chat list is put underneath first: opened from Diagnostics, the screen
/// being covered would be Diagnostics, which is not the case being asked
/// about. One unmeasured round goes first, so the decoders and caches a first
/// open fills are not charged to any variant.
///
/// While it runs, a sheet over the whole app says so and swallows touches. The
/// first version had neither: it sat on the chat list for a second and a half
/// before its first open, looking like nothing had happened, and on 1058 it
/// was stopped by a touch in that second and a half three times out of three.
/// A touch on the sheet still stops it — now as a choice.
class TransitionBenchmark {
  TransitionBenchmark._();

  static final TransitionBenchmark instance = TransitionBenchmark._();

  /// Null while idle; otherwise how far it has got.
  final ValueNotifier<String?> progress = ValueNotifier<String?>(null);

  bool get running => progress.value != null;

  /// Long enough for the open's 450 ms window and the frames after it.
  static const Duration afterOpen = Duration(milliseconds: 900);

  /// The close's 520 ms window, and the chat list catching up after it.
  static const Duration afterClose = Duration(milliseconds: 1100);

  /// A drag through the open chat and the fling it leaves, before the close.
  static const Duration afterScroll = Duration(milliseconds: 1300);

  /// While the run's own drag is being fed in, the sheet lets it through.
  final ValueNotifier<bool> _dragging = ValueNotifier<bool>(false);

  var _dragDown = true;

  /// The pointer the run's own drag uses, which the sheet does not count as a
  /// touch.
  static const int _dragPointer = 0x7E57;

  static const Duration _settle = Duration(milliseconds: 1500);

  /// Of each variant: two variants at ten rounds is about forty-five seconds of
  /// leaving the phone alone, which is roughly as long as anyone will.
  ///
  /// Variants come and go with the question. Placeholders and the no-slide
  /// variant answered theirs in 1059 (media changed nothing on the slide) and
  /// grouped-against-separate blur in 1060-1061 (grouped, now the default).
  /// Blur against no blur answered the close's too in 1062: the same six
  /// frames over budget either way, all in its first 90 ms. Keeping the chat
  /// list painted underneath answered what that is in 1063 (6.7 frames to
  /// 0.4). Keeping it painted against a scroll answered in 1164 (off stage
  /// won), so [BenchVariant.otherUnderlay] sits out of [variants] until it is
  /// asked again.
  ///
  /// 1201 compared the lighter bubbles, header and grouped panes against the
  /// 1199 paths on the phone, eight rounds of each: open build p95 5.3 against
  /// 6.8 ms and p99 17.5 against 21.1, raster the same ~9.3, close and scroll
  /// unchanged. 1202 asked whether one of the open chat's three blurs (header,
  /// composer, the scroll-down button) is what holds that raster up, by taking
  /// each away in turn: it is not. Open raster p95 whole 8.9 ms, without the
  /// header's 9.9, without the composer's 9.8, and with a control that
  /// removed nothing 9.2 — no removal came in under the whole, and the control
  /// moved as much as the rest. Both old paths went with their answers.
  static const int defaultRounds = 8;

  /// The variants a run takes turns between, in this order. One, until the
  /// next question brings a second: a run is then eight identical rounds,
  /// which is what to compare one build's open against another's, run back to
  /// back.
  static const List<BenchVariant> variants = [BenchVariant.asIs];

  bool _touched = false;

  /// [chat] is a location as [GoRouter.push] takes it. [overlay] is where the
  /// "running" sheet goes: the root one, which outlives the screens the run
  /// moves between.
  Future<void> run({
    required GoRouter router,
    required OverlayState overlay,
    required String chat,
    int rounds = defaultRounds,
  }) async {
    if (running) return;
    final probe = TransitionProbe.instance;
    final wasArmed = probe.armed.value;
    final wasPlaceholders = probe.placeholderMedia.value;
    final wasInstant = probe.instantTransitions.value;
    final wasBlur = AppBlur.panes;
    final wasUnderlay = probe.keepUnderlay.value;
    final stats = FrameStats.instance;
    final wasMeasuring = stats.isRunning;
    final wasReportOverUs = stats.reportOverUs;
    final total = rounds * variants.length;
    progress.value = 'starting';
    _touched = false;
    final sheet = OverlayEntry(builder: (_) => _RunningSheet(bench: this));
    overlay.insert(sheet);
    DebugLog.instance.log(
      'BENCH',
      'start · $rounds opens and closes each of '
          '${variants.map((v) => v.name).join(', ')}, taking turns · '
          'open ${afterOpen.inMilliseconds} ms, '
          'close ${afterClose.inMilliseconds} ms',
    );
    var finished = false;
    void apply(BenchVariant v) {
      AppBlur.panes = wasBlur;
      probe
        ..placeholderMedia.value = false
        ..instantTransitions.value = false
        ..keepUnderlay.value =
            v == BenchVariant.otherUnderlay ? !wasUnderlay : wasUnderlay;
    }

    try {
      apply(BenchVariant.asIs);
      router.go('/chats');
      await Future<void>.delayed(_settle);
      progress.value = 'warm-up';
      if (!await _cycle(router, chat)) return;

      probe
        ..resetSummary()
        ..scripted = true
        ..arm(true);
      // The frame meter times the chat's list, header and composer, but only
      // while it is listening, and prints a frame only past 16.7 ms. The open
      // chat's first frame is 17-21 ms of build, so the run listens and
      // prints from 12 ms: raster sits at ~10 ms, below it, and cannot crowd
      // the once-a-second limit out of the frame this is after.
      stats
        ..start()
        ..reportOverUs = 12000;
      for (var i = 0; i < total; i++) {
        final variant = variants[i % variants.length];
        apply(variant);
        // The drag used to flip on every cycle while the variants also
        // alternated every cycle, so one variant always flung up and the
        // other always down. Up runs into the end of the list and dies in
        // ~570 ms; the other kept going for ~1100 ms, and the 1200 log read
        // "scroll build p95 0.6 against 3.0, 61 frames against 111" as a win
        // for the new code. Now every variant takes the same direction in
        // turn: the direction changes once per pass through the variants.
        _dragDown = (i ~/ variants.length).isOdd;
        progress.value = '${i + 1}/$total · ${variant.name}';
        if (!await _cycle(router, chat)) return;
      }
      apply(BenchVariant.asIs);
      // Release builds hand frame timings over up to a second late.
      await Future<void>.delayed(_settle);
      probe.logSummary();
      finished = true;
    } finally {
      sheet
        ..remove()
        ..dispose();
      AppBlur.panes = wasBlur;
      probe
        ..scripted = false
        ..keepUnderlay.value = wasUnderlay
        ..placeholderMedia.value = wasPlaceholders
        ..instantTransitions.value = wasInstant;
      if (!wasArmed) probe.arm(false);
      stats.reportOverUs = wasReportOverUs;
      if (!wasMeasuring) stats.stop();
      DebugLog.instance.log(
        'BENCH',
        finished
            ? 'done'
            : 'stopped at ${progress.value}'
                '${_touched ? ' — stopped by a touch' : ''}'
                '${_foreground ? '' : ' — the app left the screen'}',
      );
      progress.value = null;
      if (_foreground) unawaited(router.push<void>('/diagnostics'));
    }
  }

  Future<bool> _cycle(GoRouter router, String chat) async {
    if (_interrupted) return false;
    unawaited(router.push<void>(chat));
    await Future<void>.delayed(afterOpen);
    if (_interrupted) return false;
    _logBlurLayers();
    TransitionProbe.instance.noteScroll();
    await _drag();
    await Future<void>.delayed(afterScroll);
    if (_interrupted || !router.canPop()) return false;
    router.pop();
    await Future<void>.delayed(afterClose);
    return !_interrupted;
  }

  bool get _interrupted => _touched || !_foreground;

  /// How many backdrop filters the open chat has alive, and how many of them
  /// share a group key, so a raster-bound open (9-10 ms against 8.3) can be
  /// told apart from "too many blurs" without a profiler.
  void _logBlurLayers() {
    var all = 0;
    var grouped = 0;
    final where = <String>[];
    void visit(RenderObject node) {
      if (node is RenderBackdropFilter) {
        all++;
        if (node.backdropKey != null) grouped++;
        // Which island it is, by size and place: top left and width x height.
        if (node.attached && node.hasSize) {
          final at = node.localToGlobal(Offset.zero);
          where.add('${at.dx.round()},${at.dy.round()} '
              '${node.size.width.round()}x${node.size.height.round()}');
        }
      }
      node.visitChildren(visit);
    }

    for (final view in RendererBinding.instance.renderViews) {
      visit(view);
    }
    DebugLog.instance.log(
      'NAV-COST',
      'blur layers in the open chat: $all, grouped: $grouped '
          '[${where.join(' | ')}]',
    );
  }

  /// A thumb's flick through the middle of the screen: 35% of its height in
  /// 120 ms, down one round and up the next so the conversation is not walked
  /// ever further back into its history as the run goes on.
  ///
  /// Real pointer events through the gesture system, so the list sees a drag
  /// and a fling exactly as it would from a finger — the scroll physics, the
  /// "is scrolling" signal the panes read, all of it.
  Future<void> _drag() async {
    final view = WidgetsBinding.instance.platformDispatcher.implicitView;
    if (view == null) return;
    final size = view.physicalSize / view.devicePixelRatio;
    final x = size.width / 2;
    final from = size.height * (_dragDown ? 0.35 : 0.70);
    final to = size.height * (_dragDown ? 0.70 : 0.35);
    _dragDown = !_dragDown;
    const pointer = _dragPointer;
    const steps = 10;
    final clock = Stopwatch()..start();
    Duration stamp() => Duration(microseconds: clock.elapsedMicroseconds);
    final binding = GestureBinding.instance;
    _dragging.value = true;
    try {
      // The sheet lets touches through from its next build, not from this
      // line: a drag fed in straight away landed on the sheet and stopped the
      // run as though somebody had touched it.
      await WidgetsBinding.instance.endOfFrame;
      var at = Offset(x, from);
      binding.handlePointerEvent(
        PointerDownEvent(
          viewId: view.viewId,
          pointer: pointer,
          position: at,
          timeStamp: stamp(),
        ),
      );
      for (var i = 1; i <= steps; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 12));
        final next = Offset(x, from + (to - from) * i / steps);
        binding.handlePointerEvent(
          PointerMoveEvent(
            viewId: view.viewId,
            pointer: pointer,
            position: next,
            delta: next - at,
            timeStamp: stamp(),
          ),
        );
        at = next;
      }
      binding.handlePointerEvent(
        PointerUpEvent(
          viewId: view.viewId,
          pointer: pointer,
          position: at,
          timeStamp: stamp(),
        ),
      );
    } finally {
      _dragging.value = false;
    }
  }

  static bool get _foreground {
    final state = WidgetsBinding.instance.lifecycleState;
    return state == null || state == AppLifecycleState.resumed;
  }
}

/// Over the whole app while a run goes: what it is doing, and a place for a
/// touch to land that is not a chat.
///
/// Drawn in every measured frame, so it is as little as can say the thing — a
/// dark capsule of text, no blur, no animation — and every variant pays for it
/// alike.
class _RunningSheet extends StatelessWidget {
  const _RunningSheet({required this.bench});

  final TransitionBenchmark bench;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ValueListenableBuilder<bool>(
        valueListenable: bench._dragging,
        builder: (context, dragging, sheet) =>
            IgnorePointer(ignoring: dragging, child: sheet),
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (event) {
            if (event.pointer != TransitionBenchmark._dragPointer) {
              bench._touched = true;
            }
          },
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xE6000000),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: ValueListenableBuilder<String?>(
                      valueListenable: bench.progress,
                      builder: (context, progress, _) => Text(
                        'scripted run ${progress ?? ''}\n'
                        'hands off · touch to stop',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
