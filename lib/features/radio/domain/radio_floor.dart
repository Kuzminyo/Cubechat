import 'dart:typed_data';

import '../../../core/transport/radio_chunk.dart';

/// Who holds a radio channel right now.
sealed class FloorState {
  const FloorState();
}

/// Nobody is talking.
class Idle extends FloorState {
  const Idle();
}

/// I am holding the button. The controller records while this is the state and
/// stops the moment it becomes [Listening].
class Talking extends FloorState {
  const Talking(this.transmissionId);
  final Uint8List transmissionId;
}

/// Somebody else has the channel; their chunks are the ones to play.
class Listening extends FloorState {
  const Listening(this.senderId, this.transmissionId);
  final String senderId;
  final Uint8List transmissionId;
}

/// "Channel busy": one voice per channel at a time, decided locally and the
/// same on every phone.
///
/// There is no server to grant the floor, so two people can press within a few
/// hundred milliseconds of each other and each will start sending. The rule
/// that settles it needs nothing but what is in the chunks: the transmission
/// with the smaller `startedAtMs` wins, and on an exact tie the one with the
/// byte-wise smaller `transmissionId`. Every phone compares the same two
/// numbers, so they all pick the same winner whichever chunk reached them
/// first; the loser hears the winner's chunks, sees [Listening], and the
/// controller stops its microphone.
///
/// The floor is not a lock. If the speaker's last chunk is lost the channel
/// is freed [tail] after the last chunk that did arrive.
class RadioFloor {
  RadioFloor({
    required DateTime Function() clock,
    this.tail = const Duration(seconds: 1),
    this.maxAge = const Duration(seconds: 5),
    this.clockSkew = const Duration(seconds: 30),
  }) : _clock = clock;

  final DateTime Function() _clock;

  /// How long the channel stays held after the last chunk heard. Three
  /// chunks: a hole of one or two (the jitter buffer waits one) must not hand
  /// the floor to someone else in the middle of a sentence.
  final Duration tail;

  /// The same limits as `RadioJitterBuffer`. A chunk the buffer would refuse
  /// as stale or from the future must not win the floor either: a replayed
  /// press from an hour ago has the smallest `startedAtMs` of all, and would
  /// otherwise silence whoever is talking.
  final Duration maxAge;
  final Duration clockSkew;

  FloorState _state = const Idle();

  // What the tie-break needs about the press that holds the floor.
  int _startedAtMs = 0;
  DateTime _lastHeard = DateTime.fromMillisecondsSinceEpoch(0);

  /// Presses of mine that ended, newest last. The mesh can hand my own chunks
  /// back after I let go of the button; they are not someone else talking.
  final List<Uint8List> _mine = [];
  static const int _mineKept = 8;

  /// The press that just ended with its last chunk, so a straggler of it that
  /// was reordered behind that chunk does not reopen the channel.
  Uint8List? _ended;

  FloorState get state => _state;

  /// Takes the floor for my press. False when somebody else is heard.
  bool tryTalk(Uint8List myTxId, int startedAtMs) {
    tick();
    final s = _state;
    if (s is Listening) return false;
    if (s is Talking) return _sameId(s.transmissionId, myTxId);
    _state = Talking(Uint8List.fromList(myTxId));
    _startedAtMs = startedAtMs;
    _remember(myTxId);
    return true;
  }

  void stopTalking() {
    if (_state is Talking) _state = const Idle();
  }

  /// True when this chunk belongs to the transmission that should be played.
  bool onChunk(String senderId, RadioChunk chunk) {
    tick();
    final now = _clock();
    final nowMs = now.millisecondsSinceEpoch;
    final meantAtMs = chunk.startedAtMs +
        chunk.seq * RadioChunk.chunkDuration.inMilliseconds;
    if (meantAtMs < nowMs - maxAge.inMilliseconds) return false;
    if (meantAtMs > nowMs + clockSkew.inMilliseconds) return false;

    final id = chunk.transmissionId;
    if (_isMine(id)) return false;
    final ended = _ended;
    if (ended != null && _sameId(ended, id)) return true;

    final s = _state;
    switch (s) {
      case Idle():
        _hold(senderId, chunk, now);
        return true;
      case Talking():
        if (!_beats(chunk.startedAtMs, id, _startedAtMs, s.transmissionId)) {
          return false;
        }
        // Always Listening here, even for a one-chunk winner: the controller
        // reads "not Talking any more" off this state and must see the floor
        // was taken from me, not that it fell free. The tail clears it.
        _hold(senderId, chunk, now, forceListening: true);
        return true;
      case Listening():
        if (_sameId(s.transmissionId, id)) {
          _lastHeard = now;
          if (chunk.isLast) _release(id);
          return true;
        }
        if (!_beats(chunk.startedAtMs, id, _startedAtMs, s.transmissionId)) {
          return false;
        }
        _hold(senderId, chunk, now);
        return true;
    }
  }

  /// Frees the channel when the speaker has been silent for [tail].
  void tick() {
    final s = _state;
    if (s is Listening && _clock().difference(_lastHeard) >= tail) {
      _state = const Idle();
    }
  }

  void _hold(
    String senderId,
    RadioChunk chunk,
    DateTime now, {
    bool forceListening = false,
  }) {
    final id = Uint8List.fromList(chunk.transmissionId);
    _startedAtMs = chunk.startedAtMs;
    _lastHeard = now;
    _ended = null;
    // A one-chunk press is over as soon as it is heard.
    if (chunk.isLast && !forceListening) {
      _release(id);
    } else {
      _state = Listening(senderId, id);
    }
  }

  void _release(Uint8List id) {
    _state = const Idle();
    _ended = id;
  }

  /// Whether press A beats press B: earlier start, then the smaller id.
  static bool _beats(int aStart, Uint8List aId, int bStart, Uint8List bId) {
    if (aStart != bStart) return aStart < bStart;
    final n = aId.length < bId.length ? aId.length : bId.length;
    for (var i = 0; i < n; i++) {
      if (aId[i] != bId[i]) return aId[i] < bId[i];
    }
    return aId.length < bId.length;
  }

  void _remember(Uint8List id) {
    _mine.add(Uint8List.fromList(id));
    if (_mine.length > _mineKept) _mine.removeAt(0);
  }

  bool _isMine(Uint8List id) => _mine.any((m) => _sameId(m, id));

  static bool _sameId(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
