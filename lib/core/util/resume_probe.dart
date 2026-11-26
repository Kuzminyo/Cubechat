import 'package:flutter/scheduler.dart';

import 'debug_log.dart';

/// What coming back to the app costs, one line per return.
///
/// An iPhone log of 2026-11-26 had `[STALL] UI thread did not answer for
/// 336 ms` half a second after a return, and nothing around it that could
/// say why: the relay work that [CostMeter] already counts wrote no `[COST]`
/// line in that window, so the time went somewhere nothing was measuring.
/// About fifteen things start on a resume at once — relays, push, moderation,
/// presence, the map, the BLE scan, read markers — and any of them can do its
/// work synchronously before its first `await`.
///
/// So each step of the app's resume handler is timed ([step]), the first
/// frame after the return is timed, and a stall soon after a return says how
/// long after ([sinceResume], read by [UiStallWatch]). One line:
///
///   `[RESUME] handler 14.2 ms (relays 8.1, presence 3.0), first frame 41 ms`
///
/// Steps under a millisecond are left out of the line; they are not the
/// answer. Instrumentation, not a fix: it is here so the next log names the
/// culprit instead of a guess doing it.
class ResumeProbe {
  ResumeProbe._();
  static final ResumeProbe instance = ResumeProbe._();

  /// How long after a return a stall is still blamed on it.
  static const Duration window = Duration(seconds: 5);

  DateTime? _resumedAt;
  final List<(String, int)> _steps = [];
  Stopwatch? _clock;
  bool _collecting = false;

  /// A return has started. Call first thing in the resume handler.
  void begin() {
    _resumedAt = DateTime.now();
    _steps.clear();
    _collecting = true;
    final clock = Stopwatch()..start();
    _clock = clock;
    SchedulerBinding.instance
      ..addPostFrameCallback((_) => _report(clock.elapsedMicroseconds))
      ..scheduleFrame();
  }

  /// Runs [run] and files how long it held the thread. For an async step that
  /// is the part before its first real suspension — the part a frame pays for.
  T step<T>(String name, T Function() run) {
    if (!_collecting) return run();
    final clock = Stopwatch()..start();
    try {
      return run();
    } finally {
      _steps.add((name, clock.elapsedMicroseconds));
    }
  }

  /// The handler is done; what is left before the first frame is the rest of
  /// the app (other observers, rebuilds).
  void endHandler() {
    if (!_collecting) return;
    _handlerUs = _clock?.elapsedMicroseconds;
  }

  int? _handlerUs;

  /// Time since the last return, while it is recent enough to blame.
  Duration? sinceResume() {
    final at = _resumedAt;
    if (at == null) return null;
    final since = DateTime.now().difference(at);
    return since <= window ? since : null;
  }

  void _report(int firstFrameUs) {
    _collecting = false;
    final handlerUs = _handlerUs ?? firstFrameUs;
    _handlerUs = null;
    final slow = _steps.where((s) => s.$2 >= 1000).toList()
      ..sort((a, b) => b.$2.compareTo(a.$2));
    final parts = slow.map((s) => '${s.$1} ${_ms(s.$2)}').join(', ');
    DebugLog.instance.log(
      'RESUME',
      'handler ${_ms(handlerUs)} ms'
          '${parts.isEmpty ? '' : ' ($parts)'}'
          ', first frame ${_ms(firstFrameUs)} ms',
    );
    _steps.clear();
  }

  static String _ms(int us) => (us / 1000).toStringAsFixed(1);
}
