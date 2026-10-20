import 'dart:async';

/// How fast the relays answer, and whether that makes the link "slow".
///
/// The relay pool used to judge a socket by fixed clocks: 2 s for the relay's
/// `OK` after a publish, 2 s for the probe that follows a quiet spell. On a
/// good connection that is generous. On EDGE a round trip is already about
/// 0.5-1 s before any queueing behind another upload, so a perfectly healthy
/// socket regularly answered at 2.4 s - and the pool read that as dead, tore
/// it down and opened it again, paying a fresh TLS handshake over the same
/// crawling link. Slow sockets were being turned into missing ones.
///
/// This meter measures instead of guessing. It is fed by the pool (an `OK`
/// that came back, a socket that finished connecting, a publish nobody
/// answered) and answers three questions: is the link slow, how long should
/// the pool now wait for an `OK` or a probe, and which relay is quickest. It
/// has no sockets, timers or Flutter in it, so the whole decision is a unit
/// test with an injected clock.
class LinkQualityMeter {
  /// [clock] is injected so the dwell below can be tested without waiting;
  /// production leaves it null and gets [DateTime.now].
  LinkQualityMeter({DateTime Function()? clock})
      : _clock = clock ?? DateTime.now;

  final DateTime Function() _clock;

  /// `OK` timings kept for the pool-wide median. Six is two thirds of a minute
  /// of ordinary chat traffic: long enough that one stray spike cannot move the
  /// median, short enough that a link which got better (or worse) is noticed
  /// within a handful of messages rather than minutes.
  static const int _window = 6;

  /// Median `OK` above this is slow. A healthy mobile link answers in
  /// 100-400 ms and Wi-Fi in less; EDGE sits at 0.5-1 s idle and goes past
  /// 1.5 s the moment anything else is on the wire. 1.5 s is the line between
  /// "a bit sluggish" and "the 2 s clock is about to fire on a live socket".
  static const Duration _slowMedian = Duration(milliseconds: 1500);

  /// The median is not trusted on fewer samples: one slow `OK` right after
  /// the app wakes up is a cold radio, not a bad network.
  static const int _minSamplesForMedian = 3;

  /// A socket needing more than this to connect was slow. A TLS handshake is
  /// several round trips, so on EDGE it lands at 3-8 s; five seconds is where
  /// a good network rarely goes.
  ///
  /// Rarely, not never, so one is not enough on its own — see [recordConnect].
  /// Until 2026-10-20 it was: the time covers DNS, TCP, TLS and the relay's
  /// own upgrade, for every socket the pool opens (public media, location,
  /// and relays `relay_settings_controller.dart` describes answering badly on
  /// phones while fine from a desktop). One sluggish relay, or nine
  /// handshakes at once on an iOS resume over middling LTE, put a good network
  /// into slow mode for 30 s or more — six sockets closed, presence at 150 s,
  /// a photo sent as economy.
  static const Duration _slowConnect = Duration(seconds: 5);

  /// How close together two slow connects must land to corroborate each
  /// other. On an EDGE cold start every socket handshakes at once and several
  /// pass 5 s within seconds of each other; a minute is long enough to catch
  /// that, short enough that two unrelated sluggish relays an hour apart never
  /// add up to "the link".
  static const Duration _connectWindow = Duration(seconds: 60);

  /// Connects that finish this soon after slow mode ends are not evidence.
  /// Leaving reopens every socket the slow spell let go — six handshakes at
  /// once — and on a link oscillating between EDGE and 3G any one of them
  /// past 5 s used to put the phone straight back: six TLS handshakes a
  /// cycle, on a phone where heat has been a measured problem three times.
  /// A minute covers that burst and its first reconnects; a link that really
  /// is slow again still enters by its `OK`s and silences.
  static const Duration _exitGrace = Duration(seconds: 60);

  /// Publishes that no relay answered, back to back, before silence alone
  /// counts as slow. One is a relay having a bad moment; two in a row across
  /// the pool is the link itself. This also catches the hole the median
  /// cannot: with nothing coming back there are no `OK` timings to measure.
  static const int _silencesToEnter = 2;

  /// To leave slow mode the last [_exitSamples] `OK`s must all be faster than
  /// this. Well under [_slowMedian] on purpose, so a link hovering around the
  /// entry line does not flap between the two states on every message.
  static const Duration _fastAck = Duration(milliseconds: 800);

  /// Four in a row: one fast `OK` is luck (a relay that happened to be
  /// close), four across a few sends is the network.
  static const int _exitSamples = 4;

  /// Slow mode lasts at least this long once entered. Coming back from
  /// airplane mode onto Wi-Fi gives fast answers at once, but the slow
  /// behaviours (fewer sockets, patient timeouts) are what keep a message
  /// alive while the radio settles; 30 s is a couple of full send cycles.
  static const Duration _minDwell = Duration(seconds: 30);

  /// The ack wait is this many times the median `OK`: enough headroom that an
  /// ordinary answer is never mistaken for silence, while a real stall still
  /// ends within a few multiples of what the link normally does.
  static const int _ackMedianFactor = 4;

  /// Ceiling for the ack wait. Past 15 s a publish is not slow, it is lost,
  /// and the user watching the clock icon is better served by a resend.
  static const Duration _ackCeiling = Duration(seconds: 15);

  /// Ack wait when the link is slow but nothing has answered yet (the
  /// silence route in): long enough for a 2.4 s EDGE answer with a few
  /// seconds to spare, short enough to still fail over inside one retry.
  static const Duration _ackSlowNoSamples = Duration(seconds: 10);

  /// The probe is a bare ping, one round trip rather than a publish plus a
  /// relay's signature check, so it gets a smaller multiple of the median.
  static const int _probeMedianFactor = 3;

  /// Ceiling for the probe wait; a socket silent for ten seconds is gone.
  static const Duration _probeCeiling = Duration(seconds: 10);

  /// Probe wait when the link is slow and no `OK` has been measured.
  static const Duration _probeSlowNoSamples = Duration(seconds: 6);

  /// Most recent `OK` timings, pool-wide, oldest first.
  final List<Duration> _acks = <Duration>[];

  /// Recent `OK` timings per relay, for [fastestOf].
  final Map<String, List<Duration>> _perUrl = <String, List<Duration>>{};

  Duration? _lastConnect;

  /// Slow connects inside [_connectWindow], by relay, with when they landed.
  final Map<String, DateTime> _slowConnects = <String, DateTime>{};
  int _silenceRun = 0;
  bool _slow = false;
  DateTime? _slowSince;

  /// When slow mode last ended, for [_exitGrace].
  DateTime? _fastSince;
  bool _disposed = false;

  final StreamController<bool> _changes = StreamController<bool>.broadcast();

  /// True while the link is judged slow.
  bool get isSlow => _slow;

  /// Emits `true` / `false` only when [isSlow] changes.
  Stream<bool> get changes => _changes.stream;

  /// A relay answered a publish with `OK` after [elapsed].
  void recordAck(String url, Duration elapsed) {
    _silenceRun = 0;
    _acks.add(elapsed);
    if (_acks.length > _window) _acks.removeAt(0);
    final mine = _perUrl.putIfAbsent(url, () => <Duration>[]);
    mine.add(elapsed);
    if (mine.length > _window) mine.removeAt(0);

    if (!_slow) {
      final median = _median(_acks);
      if (_acks.length >= _minSamplesForMedian &&
          median != null &&
          median > _slowMedian) {
        _setSlow(true);
      }
    } else if (_canExit()) {
      _setSlow(false);
    }
  }

  /// A socket to [url] finished connecting after [elapsed]. [anchor] is our
  /// own relay — the one socket a slow link always keeps.
  ///
  /// A slow connect enters slow mode only when something corroborates it:
  /// a second relay connecting slowly inside [_connectWindow], or the slow
  /// one being ours. Ours is a single, known relay on our own machine, so its
  /// handshake crawling is the link, not a stranger's server having a bad
  /// minute. Nothing counts inside [_exitGrace] after leaving slow mode.
  void recordConnect(String url, Duration elapsed, {bool anchor = false}) {
    _lastConnect = elapsed;
    if (_slow || elapsed <= _slowConnect) return;
    final now = _clock();
    final left = _fastSince;
    if (left != null && now.difference(left) < _exitGrace) return;
    _slowConnects[url] = now;
    _slowConnects.removeWhere((_, at) => now.difference(at) > _connectWindow);
    if (anchor || _slowConnects.length >= 2) _setSlow(true);
  }

  /// A publish went out and no relay answered it in time. Counted pool-wide:
  /// it is the run of silences, not which relay stayed quiet, that says the
  /// link is gone. Any [recordAck] ends the run.
  void recordSilence(String url) {
    _silenceRun++;
    if (!_slow && _silenceRun >= _silencesToEnter) _setSlow(true);
  }

  /// How long the pool should wait for a relay's `OK`, never below [floor].
  Duration ackTimeout({required Duration floor}) {
    final median = _median(_acks);
    if (median == null)
      return _slow ? _atLeast(floor, _ackSlowNoSamples) : floor;
    return _clamp(median * _ackMedianFactor, floor, _ackCeiling);
  }

  /// How long the pool should wait for a probe's answer, never below [floor].
  Duration probeTimeout({required Duration floor}) {
    if (!_slow) return floor;
    final median = _median(_acks);
    if (median == null) return _atLeast(floor, _probeSlowNoSamples);
    return _clamp(median * _probeMedianFactor, floor, _probeCeiling);
  }

  /// The url with the lowest median `OK` among [urls]; null when none of them
  /// has been measured.
  String? fastestOf(Iterable<String> urls) {
    String? best;
    Duration? bestMedian;
    for (final url in urls) {
      final samples = _perUrl[url];
      if (samples == null || samples.isEmpty) continue;
      final median = _median(samples)!;
      if (bestMedian == null || median < bestMedian) {
        best = url;
        bestMedian = median;
      }
    }
    return best;
  }

  /// One line for the debug log: `ok-median 2.4 s, connect 7.1 s`.
  String describe() {
    final median = _median(_acks);
    return 'ok-median ${_seconds(median)}, connect ${_seconds(_lastConnect)}';
  }

  void dispose() {
    _disposed = true;
    unawaited(_changes.close());
  }

  bool _canExit() {
    if (_acks.length < _exitSamples) return false;
    final since = _slowSince;
    if (since != null && _clock().difference(since) < _minDwell) return false;
    return _acks
        .sublist(_acks.length - _exitSamples)
        .every((d) => d < _fastAck);
  }

  void _setSlow(bool value) {
    if (_slow == value) return;
    _slow = value;
    _slowSince = value ? _clock() : null;
    _fastSince = value ? null : _clock();
    // A spell's evidence is spent on it; the next one gathers its own.
    _slowConnects.clear();
    if (!_disposed) _changes.add(value);
  }

  /// Median of [samples]; the mean of the two middle ones for an even count.
  static Duration? _median(List<Duration> samples) {
    if (samples.isEmpty) return null;
    final sorted = List<Duration>.of(samples)..sort();
    final mid = sorted.length ~/ 2;
    if (sorted.length.isOdd) return sorted[mid];
    return Duration(
      microseconds:
          (sorted[mid - 1].inMicroseconds + sorted[mid].inMicroseconds) ~/ 2,
    );
  }

  static Duration _atLeast(Duration floor, Duration value) =>
      value < floor ? floor : value;

  /// `value` held to [floor, ceiling]; the floor wins if it exceeds the
  /// ceiling, so a caller's own minimum is never undercut.
  static Duration _clamp(Duration value, Duration floor, Duration ceiling) {
    final capped = value > ceiling ? ceiling : value;
    return capped < floor ? floor : capped;
  }

  static String _seconds(Duration? d) =>
      d == null ? 'n/a' : '${(d.inMilliseconds / 1000).toStringAsFixed(1)} s';
}
