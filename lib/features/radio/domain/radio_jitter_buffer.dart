import 'dart:typed_data';

import '../../../core/transport/radio_chunk.dart';

/// Puts received radio chunks back in order and decides when to play them.
///
/// Mesh delivery reorders, duplicates and loses chunks, and late voice is
/// worse than no voice, so the rules are blunt:
///
/// * A chunk is *meant* to be heard at `startedAtMs + seq * 300 ms`. If that
///   moment is more than [maxAge] behind the clock the chunk is refused; if it
///   is more than [clockSkew] ahead the sender's clock is wrong (or the chunk
///   is forged) and it is refused too.
/// * Playback waits until [prebuffer] of speech is queued, so one slow chunk
///   does not stutter the start. A last chunk, or [prebuffer] of waiting,
///   also starts it: a single short press must not sit forever.
/// * A missing seq is waited for one chunk length, then skipped: the gap comes
///   out as `null` frames, which the decoder turns into concealment.
/// * One transmission at a time. Who wins when two overlap is the floor's
///   decision (`RadioFloor`); the controller calls [reset] when it changes.
class RadioJitterBuffer {
  RadioJitterBuffer({
    required DateTime Function() clock,
    this.prebuffer = const Duration(milliseconds: 400),
    this.maxAge = const Duration(seconds: 5),
    this.clockSkew = const Duration(seconds: 30),
  }) : _clock = clock;

  final DateTime Function() _clock;
  final Duration prebuffer;
  final Duration maxAge;
  final Duration clockSkew;

  Uint8List? _txId;
  int _startedAtMs = 0;
  final Map<int, RadioChunk> _pending = {};
  bool _started = false;
  int _next = 0;
  int? _lastSeq;
  DateTime? _firstArrival;
  DateTime? _gapSince;
  bool _finished = false;

  /// The last chunk has been handed out by [drain].
  bool get finished => _finished;

  /// Forgets the current transmission. For when the floor gave the channel to
  /// someone else, or the sender's last chunk was lost for good.
  void reset() {
    _txId = null;
    _pending.clear();
    _started = false;
    _next = 0;
    _lastSeq = null;
    _firstArrival = null;
    _gapSince = null;
    _finished = false;
  }

  /// False when the chunk was thrown away: a duplicate, too old, too far in
  /// the future, or part of a different transmission than the one playing.
  bool push(RadioChunk chunk) {
    final now = _clock();
    final meantAtMs = chunk.startedAtMs +
        chunk.seq * RadioChunk.chunkDuration.inMilliseconds;
    final nowMs = now.millisecondsSinceEpoch;
    if (meantAtMs < nowMs - maxAge.inMilliseconds) return false;
    if (meantAtMs > nowMs + clockSkew.inMilliseconds) return false;

    final same = _txId != null && _sameId(_txId!, chunk.transmissionId);
    if (_txId != null && !same) {
      // Another press. While this one is still playing it keeps the buffer;
      // once it has finished, the next one starts clean.
      if (!_finished) return false;
      reset();
    } else if (same) {
      // A finished press is closed for good: a replayed or straggling chunk
      // of it must not reopen it.
      if (_finished) return false;
      // Every chunk of one press carries the same start; a different one is
      // not part of it.
      if (chunk.startedAtMs != _startedAtMs) return false;
      if (_pending.containsKey(chunk.seq)) return false;
      if (_started && chunk.seq < _next) return false;
      final last = _lastSeq;
      if (last != null && chunk.seq > last) return false;
    }

    if (_txId == null) {
      _txId = Uint8List.fromList(chunk.transmissionId);
      _startedAtMs = chunk.startedAtMs;
      _firstArrival = now;
    }
    if (chunk.isLast) _lastSeq = chunk.seq;
    _pending[chunk.seq] = chunk;
    return true;
  }

  /// Frames due now, in seq order. A `null` is a frame that never arrived.
  List<Uint8List?> drain() {
    if (_txId == null || _finished) return const [];
    if (!_started) {
      if (!_ready()) return const [];
      _started = true;
      _next = _lowestPending();
    }
    final out = <Uint8List?>[];
    while (_pending.isNotEmpty) {
      final chunk = _pending.remove(_next);
      if (chunk != null) {
        out.addAll(chunk.frames);
        _next++;
        _gapSince = null;
        if (chunk.isLast) {
          _finished = true;
          _pending.clear();
          break;
        }
        continue;
      }
      // A hole with something queued behind it. Give the straggler one chunk
      // length, measured from when the hole was first seen.
      final now = _clock();
      final since = _gapSince ??= now;
      if (now.difference(since) < RadioChunk.chunkDuration) break;
      final lowest = _lowestPending();
      while (_next < lowest) {
        out.addAll(
          List<Uint8List?>.filled(RadioChunk.framesPerChunk, null),
        );
        _next++;
      }
      _gapSince = null;
    }
    return out;
  }

  /// Enough queued to start: [prebuffer] of unbroken speech from the first
  /// seq, a last chunk in that run, or [prebuffer] since the first arrival.
  bool _ready() {
    if (_pending.isEmpty) return false;
    var seq = _lowestPending();
    var queued = Duration.zero;
    while (true) {
      final c = _pending[seq];
      if (c == null) break;
      if (c.isLast) return true;
      queued += RadioChunk.chunkDuration;
      if (queued >= prebuffer) return true;
      seq++;
    }
    return _clock().difference(_firstArrival!) >= prebuffer;
  }

  int _lowestPending() => _pending.keys.reduce((a, b) => a < b ? a : b);

  static bool _sameId(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
