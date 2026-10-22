import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/radio_audio.dart';
import '../../../core/crypto/radio_crypto.dart';
import '../../../core/transport/radio_chunk.dart';
import '../../../core/util/debug_log.dart';
import '../../channels/models/channel.dart' show normalizeChannelName;
import '../domain/radio_floor.dart';
import '../domain/radio_frames.dart';
import '../domain/radio_jitter_buffer.dart';
import '../models/radio_channel.dart';
import 'radio_inbound.dart';
import 'radio_ports.dart';
import 'radio_reach.dart';

export '../domain/radio_floor.dart' show FloorState, Idle, Listening, Talking;
export '../models/radio_channel.dart';

/// Why the last press of the button did not start a transmission, or why the
/// radio ended one the button had not.
enum RadioBlockedReason {
  /// The press reached [RadioController.maxPress] and was ended for the user:
  /// a missed pointer-up must not leave the microphone on for ever.
  tooLong,

  /// Somebody else holds the channel.
  busy,

  /// A voice call is up; the radio stays out of its way (Ruling 17).
  call,

  /// The microphone permission was refused, or the microphone would not open.
  microphone,

  /// No codec on this platform (the web build has no libopus).
  unavailable,

  /// Nothing is selected, or the selected group is not one we are in.
  noChannel,
}

@immutable
class RadioState {
  const RadioState({
    this.groups = const [],
    this.active,
    this.floor = const Idle(),
    this.playInSilentMode = true,
    this.personalCalls = true,
    this.callTuned = false,
    this.blockedReason,
    this.speakerBusy = false,
  });

  /// Groups joined, oldest first.
  final List<RadioRoom> groups;

  /// What the radio is tuned to. Only this channel is played, and only this
  /// channel's floor is tracked.
  final RadioChannel? active;

  /// Who holds [active]: nobody, me, or somebody else ([Listening.senderId]).
  final FloorState floor;

  /// The «Говорити в беззвучному режимі» switch. On by default: a walkie-talkie
  /// that the silent switch mutes is one that misses the call it exists for.
  final bool playInSilentMode;

  /// The «Приймай особисті виклики» switch (Ruling 27). On by default: while
  /// nothing is tuned, a contact who talks to this phone tunes the radio to
  /// themselves and is heard - the radio's version of a phone ringing.
  final bool personalCalls;

  /// [active] was tuned by a personal call, not by the user (Ruling 32): it
  /// is not kept across a restart, and the radio goes back to idle after
  /// [RadioController.callIdleAfter] with nothing heard or said on it.
  final bool callTuned;

  /// Set when [RadioController.pressToTalk] refused, cleared by the next press
  /// that works and by [RadioController.select].
  final RadioBlockedReason? blockedReason;

  /// Somebody else's voice is still coming out of the speaker, or about to:
  /// from the first chunk of a heard transmission until the speaker is let go
  /// after its last sample. The floor goes Idle the moment the last chunk
  /// arrives, which is up to half a second before it has played; a press in
  /// that half second would talk over the end of their sentence, so
  /// [RadioController.pressToTalk] refuses with `busy` while this is set.
  final bool speakerBusy;

  bool get talking => floor is Talking;

  RadioState copyWith({
    List<RadioRoom>? groups,
    RadioChannel? Function()? active,
    FloorState? floor,
    bool? playInSilentMode,
    bool? personalCalls,
    bool? callTuned,
    RadioBlockedReason? Function()? blockedReason,
    bool? speakerBusy,
  }) =>
      RadioState(
        groups: groups ?? this.groups,
        active: active != null ? active() : this.active,
        floor: floor ?? this.floor,
        playInSilentMode: playInSilentMode ?? this.playInSilentMode,
        personalCalls: personalCalls ?? this.personalCalls,
        callTuned: callTuned ?? this.callTuned,
        blockedReason:
            blockedReason != null ? blockedReason() : this.blockedReason,
        speakerBusy: speakerBusy ?? this.speakerBusy,
      );
}

/// The walkie-talkie: microphone -> chunks -> mesh while the button is held,
/// and mesh -> floor -> jitter buffer -> speaker while somebody else talks.
///
/// One channel at a time, [RadioState.active]. Its floor ([RadioFloor]) and
/// jitter buffer ([RadioJitterBuffer]) are made fresh when it is selected,
/// and a periodic tick drives both - the buffer only finds holes, and the
/// floor only frees itself after a lost last chunk, when asked.
///
/// Everything is keyed on the transmission id, never on the sender id: a
/// group sender is named by fingerprint until this phone learns who they are,
/// and can turn into a canonical id in the middle of a sentence.
class RadioController extends Notifier<RadioState> {
  /// How often the jitter buffer is drained and the floor ticked. A third of a
  /// chunk: often enough that a hole costs at most a tenth of a second more
  /// than the buffer's own one-chunk wait, rarely enough to be nothing at all
  /// while a channel sits open.
  static const Duration tickEvery = Duration(milliseconds: 100);

  /// Added to the moment the last written sample should have played before
  /// the speaker is let go. `stop` throws away whatever is still queued on
  /// both platforms, and the estimate below does not see the output's own
  /// buffer (Android's is four times the minimum, tens of milliseconds) or a
  /// late start; 300 ms - one chunk - is far more than either.
  static const Duration stopMargin = Duration(milliseconds: 300);

  /// Chunks of one press allowed to wait for the transport at once. The
  /// microphone makes one every 300 ms; four waiting means the link has fallen
  /// more than a second behind, and a chunk that late is on its way to being
  /// dropped by every receiver anyway (they refuse one 5 s behind where the
  /// first chunk said it would be). Dropping it here instead keeps the radio
  /// from piling up in front of everybody's text.
  static const int maxQueuedSends = 4;

  /// Longest press. A walkie-talkie turn is seconds; a minute is far past
  /// anything said on purpose, and its only job is to bound the case where the
  /// screen never saw the finger lift - otherwise the microphone records, and
  /// the channel stays taken for everyone, until the app is killed. 200
  /// chunks at 300 ms.
  static const Duration maxPress = Duration(seconds: 60);

  static const int _sampleRate = PlatformRadioAudio.sampleRate;
  static const int _frameSamples = 960;

  /// A heard transmission that has stopped arriving but never finished - its
  /// last chunk came and something in front of it is stuck - is closed after
  /// this. The floor's own tail (1 s) closes the ordinary case, a lost last
  /// chunk, well before.
  static const Duration _stuckAfter = Duration(seconds: 2);

  late RadioSender _sender;
  late RadioMicrophone _mic;
  late RadioCodec _codec;
  late RadioAudioSink _sink;
  late DateTime Function() _clock;
  late bool Function() _callBusy;
  late RadioGroupStore _store;

  /// Null until [build]: a screen test's stand-in controller replaces build
  /// and still has its screen report in.
  RadioReach? _reach;
  late int Function() _nearby;

  /// The radio screen is on screen - see [screenShown].
  bool _screenShown = false;

  /// Joined groups by tag hex, in the order they were joined.
  final Map<String, StoredRadioGroup> _stored = {};
  Future<void>? _loading;
  bool _silentTouched = false;

  /// Set once a choice was made in this run - a channel tuned, the switch
  /// flipped, the radio used or wiped - so a load still in flight does not
  /// put the disk's older answer back over it.
  bool _activeTouched = false;
  bool _personalTouched = false;
  bool _usedTouched = false;

  /// A room was added or a channel tuned, ever (`radio.used`). Until then the
  /// radio publishes nothing at all, personal calls included: a phone whose
  /// owner never opened the radio pays nothing for it (Rulings 25, 27).
  bool _used = false;

  /// Open only while personal calls are being listened for - see
  /// [radioContactsProvider] for why not always.
  ProviderSubscription<Set<String>>? _contactsSub;

  /// Fires [callIdleAfter] after the last transmission on a call-tuned
  /// channel ([RadioState.callTuned]) and puts the radio back to idle. One
  /// shot, re-armed by each transmission: nothing ticks while nobody talks
  /// (Ruling 20).
  Timer? _callIdle;
  bool _disposed = false;
  int _generation = 0;

  RadioFloor? _floor;
  RadioJitterBuffer? _buffer;
  Timer? _ticker;

  _Press? _press;
  _Heard? _heard;

  /// Transmissions that are over - finished with their last chunk, or lost a
  /// collision - so a straggler of one is not heard a second time as if it
  /// were a new press. Not one the floor's tail let go of without a last
  /// chunk: that may only be a stall, and when its chunks come back they are
  /// the rest of the sentence.
  final List<Uint8List> _closed = [];
  static const int _closedKept = 8;

  /// Transmissions already named in a `drop tx` line, and when the last such
  /// line was written: one line per transmission, one per [_staleLogEvery].
  final List<Uint8List> _staleLogged = [];
  DateTime? _staleLoggedAt;
  static const Duration _staleLogEvery = Duration(seconds: 10);

  /// Speaker calls in order: start, write and stop are all asynchronous, and a
  /// write that overtook its start would be ignored.
  Future<void> _audio = Future<void>.value();
  bool _speakerOpen = false;

  /// When the last sample written so far should finish playing.
  DateTime? _playEnd;
  Timer? _stopTimer;
  bool _saidNoCodec = false;

  /// Resolves once the groups and the switch on disk are in [state].
  Future<void> get loaded => _loading ?? Future<void>.value();

  @override
  RadioState build() {
    _sender = ref.read(radioSenderProvider);
    _mic = ref.read(radioMicrophoneProvider);
    _codec = ref.read(radioCodecProvider);
    _sink = ref.read(radioAudioProvider);
    _clock = ref.read(radioClockProvider);
    _callBusy = ref.read(radioCallBusyProvider);
    _store = ref.read(radioGroupStoreProvider);
    final reach = ref.read(radioReachProvider);
    _reach = reach;
    _nearby = ref.read(radioNearbyProvider);
    _disposed = false;
    // Nothing is tuned yet, and [state] may not be read before build returns.
    reach
      ..onScreen = null
      ..talking = null;
    final generation = ++_generation;
    _stored.clear();
    _closed.clear();
    _staleLogged.clear();
    _staleLoggedAt = null;
    _silentTouched = false;
    _activeTouched = false;
    _personalTouched = false;
    _usedTouched = false;
    _used = false;
    // A rebuild has already closed the old one with the rest of its listens.
    _contactsSub = null;

    // Listened, not read once: the stream belongs to MessagingService, and
    // an Emergency Wipe (or a restore) builds a new one. Subscribed once, the
    // radio stayed on the old, closed stream and heard nothing until restart.
    StreamSubscription<RadioInbound>? sub;
    ref.listen<Stream<RadioInbound>>(
      radioInboundProvider,
      (_, stream) {
        unawaited(sub?.cancel());
        sub = stream.listen(_onInbound);
      },
      fireImmediately: true,
    );
    ref.onDispose(() {
      _disposed = true;
      reach
        ..onScreen = null
        ..talking = null;
      unawaited(sub?.cancel());
      _teardown();
    });
    unawaited(_loading = _load(generation));
    return const RadioState();
  }

  Future<void> _load(int generation) async {
    bool? silent;
    bool? personal;
    bool? used;
    String? activeRef;
    try {
      silent = await _store.loadPlayInSilentMode();
      personal = await _store.loadPersonalCalls();
      used = await _store.loadUsed();
      activeRef = await _store.loadActive();
    } catch (e) {
      debugPrint('Radio settings load failed: $e');
    }
    var loaded = const <StoredRadioGroup>[];
    try {
      loaded = await _store.loadGroups();
    } catch (e, st) {
      debugPrint('Radio groups load failed: $e\n$st');
    }
    await _awaitContactsFor(activeRef);
    // A restore invalidates this controller while the read is in flight; the
    // rebuild has started its own, over the restored box.
    if (_disposed || generation != _generation) return;
    final sorted = [...loaded]
      ..sort((a, b) => a.joinedAt.compareTo(b.joinedAt));
    // A group joined while the disk was being read wins over the disk's copy.
    final merged = <String, StoredRadioGroup>{
      for (final g in sorted) g.group.tagHex: g,
      ..._stored,
    };
    _stored
      ..clear()
      ..addAll(merged);
    if (!_usedTouched) {
      // A phone upgraded from stage 1 has rooms on disk but no flag: it has
      // used the radio, and its personal calls must work like anyone's.
      _used = (used ?? false) || loaded.isNotEmpty;
      if (_used && used != true) unawaited(_saveUsed());
    }
    state = state.copyWith(
      groups: _groupList(),
      playInSilentMode:
          _silentTouched ? state.playInSilentMode : (silent ?? true),
      personalCalls:
          _personalTouched ? state.personalCalls : (personal ?? true),
    );
    // After the groups, which a stored room is looked up in (Ruling 26).
    if (!_activeTouched && activeRef != null) _restore(activeRef);
    _publishKeys();
  }

  /// [RadioChannelRef.contactId] of [activeRef], once the roster it is to be
  /// judged against has loaded - see [radioContactsReadyProvider].
  Future<void> _awaitContactsFor(String? activeRef) async {
    if (activeRef == null || RadioChannelRef.contactId(activeRef) == null) {
      return;
    }
    try {
      await ref.read(radioContactsReadyProvider)();
    } catch (e) {
      debugPrint('Radio contacts wait failed: $e');
    }
  }

  /// Tunes back to the channel the radio was on before the restart - quietly:
  /// it is the same choice, so nothing is written back. A room left (or
  /// wiped) since is not an error; the radio comes up tuned to nothing, and
  /// the stale entry is dropped. So is a contact who is no longer one, or is
  /// blocked now: the transport would never hand over their voice, and a
  /// radio tuned to them is a radio that hears nobody.
  void _restore(String stored) {
    final tag = RadioChannelRef.roomTag(stored);
    final contact = RadioChannelRef.contactId(stored);
    final channel = tag != null
        ? _stored[tag]?.group
        : contact != null && ref.read(radioContactsProvider).contains(contact)
            ? RadioContact(contact)
            : null;
    if (channel == null) {
      unawaited(_saveActive(null));
      return;
    }
    _tune(channel);
  }

  // ---------------------------------------------------------------- groups

  /// Join (or re-join) a group. The name is normalised the way a channel's is,
  /// so "#Patrol " and "patrol" are one group; the password may be empty.
  /// Only the derived key is kept. Throws [ArgumentError] on an empty name.
  Future<RadioRoom> joinGroup(String name, String password) async {
    final normalized = normalizeChannelName(name);
    if (normalized.isEmpty) throw ArgumentError('radio group name is empty');
    final key = await RadioCrypto.deriveKey(normalized, password);
    final tag = await RadioCrypto.deriveTag(key);
    final group = RadioRoom(
      name: normalized,
      hasPassword: password.isNotEmpty,
      tagHex: radioHex(tag),
    );
    final stored = StoredRadioGroup(
      group: group,
      key: key,
      // A re-join keeps its place in the list.
      joinedAt: _stored[group.tagHex]?.joinedAt ?? _clock(),
    );
    if (_disposed) return group;
    _stored[group.tagHex] = stored;
    _markUsed();
    _publishKeys();
    state = state.copyWith(groups: _groupList());
    try {
      await _store.putGroup(stored);
    } catch (e) {
      debugPrint('Radio group persist(${group.name}) failed: $e');
    }
    return group;
  }

  Future<void> leaveGroup(String tagHex) async {
    if (_stored.remove(tagHex) == null) return;
    final active = state.active;
    if (active is RadioRoom && active.tagHex == tagHex) select(null);
    _publishKeys();
    state = state.copyWith(groups: _groupList());
    try {
      await _store.deleteGroup(tagHex);
    } catch (e) {
      debugPrint('Radio group delete failed: $e');
    }
  }

  /// Forget every group, the tuned channel, the `used` flag and the switches -
  /// Emergency Wipe. The switches go back to their defaults rather than to
  /// whatever the disk says: a wipe leaves nothing of this phone's choices
  /// behind, and a load still in flight must not put the old ones back (the
  /// `_touched` flags). Wiped is never-used: nothing is published again until
  /// a room is added or a channel tuned.
  Future<void> clear() async {
    select(null);
    _stored.clear();
    _silentTouched = true;
    _personalTouched = true;
    _usedTouched = true;
    _used = false;
    state = state.copyWith(
      groups: const [],
      playInSilentMode: true,
      personalCalls: true,
    );
    _publishKeys();
    try {
      await _store.clearGroups();
    } catch (e) {
      debugPrint('Radio groups clear failed: $e');
    }
    try {
      await _store.clearSettings();
    } catch (e) {
      debugPrint('Radio settings clear failed: $e');
    }
  }

  /// The «Приймай особисті виклики» switch (Ruling 27).
  Future<void> setPersonalCalls(bool value) async {
    _personalTouched = true;
    state = state.copyWith(personalCalls: value);
    _publishKeys();
    try {
      await _store.savePersonalCalls(value);
    } catch (e) {
      debugPrint('Radio personal-calls persist failed: $e');
    }
  }

  void _markUsed() {
    _usedTouched = true;
    if (_used) return;
    _used = true;
    unawaited(_saveUsed());
  }

  Future<void> _saveUsed() async {
    try {
      await _store.saveUsed(true);
    } catch (e) {
      debugPrint('Radio used-flag persist failed: $e');
    }
  }

  Future<void> _saveActive(RadioChannel? channel) async {
    try {
      await _store.saveActive(
        channel == null ? null : RadioChannelRef.of(channel),
      );
    } catch (e) {
      debugPrint('Radio channel persist failed: $e');
    }
  }

  Future<void> setPlayInSilentMode(bool value) async {
    _silentTouched = true;
    state = state.copyWith(playInSilentMode: value);
    try {
      await _store.savePlayInSilentMode(value);
    } catch (e) {
      debugPrint('Radio switch persist failed: $e');
    }
  }

  List<RadioRoom> _groupList() =>
      List.unmodifiable(_stored.values.map((s) => s.group));

  /// Tells the transport what this radio can play: the tuned group's key, or
  /// the tuned contact - and nothing else. Every joined group's frames used
  /// to be opened and verified, and a pair tag worked out (an X25519 each)
  /// for every contact, by every phone with the app, whether or not anything
  /// would ever play them; only the tuned channel is played (see
  /// [_onInbound]), so only its frames are worth the crypto. A phone with the
  /// radio off does none at all, and a group frame it cannot open is still
  /// forwarded, since that happens before the cipher is read.
  ///
  /// The one exception is an idle radio taking personal calls (Ruling 27):
  /// tuned to nothing, used at least once and with the switch on, it listens
  /// for every contact who is not blocked, so that one of them talking to
  /// this phone can tune it ([_answerPersonalCall]). The transport derives
  /// each pair key once and keeps it, so this is an X25519 per contact once,
  /// not per frame - and none at all on a phone that never used the radio.
  void _publishKeys() {
    if (_disposed) return;
    final active = state.active;
    final room = active is RadioRoom ? _stored[active.tagHex] : null;
    ref.read(radioGroupKeysProvider.notifier).state = Map.unmodifiable({
      if (room != null) room.group.tagHex: room.key,
    });
    final personal = _takingPersonalCalls;
    final contacts = _watchContacts(personal);
    final peers = <String>{
      if (active is RadioContact) active.canonicalId,
      if (personal) ...contacts,
    };
    // Unchanged is left alone: the roster changes with every presence beacon,
    // and a new set object would send the transport to compare its table.
    final pairs = ref.read(radioPairPeersProvider.notifier);
    if (!setEquals(pairs.state, peers)) pairs.state = Set.unmodifiable(peers);
  }

  bool get _takingPersonalCalls =>
      state.active == null && _used && state.personalCalls;

  /// Opens or closes the roster subscription to match [on]; the contacts when
  /// open, nothing when closed.
  Set<String> _watchContacts(bool on) {
    if (!on) {
      _contactsSub?.close();
      _contactsSub = null;
      return const {};
    }
    final sub = _contactsSub ??= ref.listen<Set<String>>(
      radioContactsProvider,
      (_, __) => _publishKeys(),
    );
    return sub.read();
  }

  /// A 1:1 chunk reached a radio tuned to nothing. When personal calls are
  /// being taken and it is from a contact listened for, the radio tunes to
  /// them - call-tuned (Ruling 32): not persisted, and back to idle after
  /// [callIdleAfter] of silence - and the chunk is then handled as on any
  /// tuned channel.
  ///
  /// Never during a call (Ruling 17): the call wins and the radio stays off.
  /// Never for the rest of a transmission the user just switched away from
  /// ([_closed]), or "turn off" would undo itself on the next chunk of the
  /// sentence it cut. Never on a chunk the new floor would refuse for its
  /// timing ([RadioFloor.offClock]) - a sender whose clock is a minute out
  /// would otherwise leave the radio tuned to a voice it then drops.
  bool _answerPersonalCall(RadioInbound m) {
    if (m.groupTag != null || !_takingPersonalCalls) return false;
    final contacts = _contactsSub?.read() ?? const <String>{};
    if (!contacts.contains(m.senderId)) return false;
    if (_callBusy()) return false;
    if (_closed.any((id) => _sameId(id, m.chunk.transmissionId))) return false;
    if (RadioFloor.offClock(m.chunk, _clock()) != null) return false;
    DebugLog.instance.log('RADIO', 'personal call tunes the radio');
    _tune(RadioContact(m.senderId));
    state = state.copyWith(callTuned: true);
    _armCallIdle();
    return true;
  }

  /// How long a call-tuned radio stays on its caller after the last
  /// transmission heard or sent on it (Ruling 32). Two minutes: a reply and
  /// the answer to it fit easily; a radio left tuned to one person for good
  /// by a single "you there?" would deafen it to every other personal call.
  static const Duration callIdleAfter = Duration(minutes: 2);

  /// (Re)starts the call-tuned countdown; harmless when not call-tuned.
  void _armCallIdle() {
    if (_disposed || !state.callTuned) return;
    _callIdle?.cancel();
    _callIdle = Timer(callIdleAfter, _callIdleFired);
  }

  void _callIdleFired() {
    _callIdle = null;
    if (_disposed || !state.callTuned) return;
    // Somebody is still at it: wait another round rather than cut them off.
    final floor = _floor?.state ?? const Idle();
    if (_press != null || _heard != null || floor is! Idle) {
      _armCallIdle();
      return;
    }
    DebugLog.instance.log('RADIO', 'personal call over, radio idle again');
    // Not select(null): nothing was stored for this tuning, so nothing is
    // forgotten either, and the user did not choose it.
    _tune(null);
  }

  // --------------------------------------------------------------- channel

  /// The radio screen tells the radio it is shown ([on]) or gone. While it is
  /// shown on a channel the radio asks the scanner for links to it
  /// ([RadioReach]); that ask is what lets a press be heard by a phone nobody
  /// had connected to yet.
  void screenShown(bool on) {
    if (on == _screenShown) return;
    _screenShown = on;
    _syncReach();
  }

  void _syncReach() {
    _reach
      ?..onScreen = _screenShown ? state.active : null
      ..talking = _press == null ? null : state.active;
  }

  /// Tune to [channel], or to nothing. Whatever was being said or heard on
  /// the old one stops at once. Remembered across restarts (Ruling 26).
  ///
  /// Choosing the channel a personal call tuned the radio to is a choice like
  /// any other: it stops being call-tuned and is kept (Ruling 32).
  void select(RadioChannel? channel) {
    _activeTouched = true;
    if (channel == state.active) {
      if (channel != null && state.callTuned) {
        _endCallTuning();
        unawaited(_saveActive(channel));
      }
      return;
    }
    if (channel != null) _markUsed();
    _tune(channel);
    unawaited(_saveActive(channel));
  }

  void _endCallTuning() {
    _callIdle?.cancel();
    _callIdle = null;
    if (state.callTuned) state = state.copyWith(callTuned: false);
  }

  void _tune(RadioChannel? channel) {
    if (channel == state.active) return;
    _endCallTuning();
    final press = _press;
    if (press != null) unawaited(_endPress(press, sendLast: true));
    // What was being heard is over for this phone: its stragglers must not
    // come back as a personal call ([_answerPersonalCall]).
    final held = _floor?.state;
    if (held is Listening) _markClosed(held.transmissionId);
    _closeHeard(stopNow: true, over: true);
    _ticker?.cancel();
    _ticker = null;
    if (channel == null) {
      _floor = null;
      _buffer = null;
    } else {
      // No ticker yet: a channel can sit tuned for hours - reception keeps
      // working with the screen closed - and a timer firing ten times a
      // second for that whole time is the battery cost this radio promised
      // not to have. [_wake] starts it when somebody talks and [_tick] puts
      // it away when they stop.
      _floor = RadioFloor(clock: _clock);
      _buffer = RadioJitterBuffer(clock: _clock);
    }
    state = state.copyWith(
      active: () => channel,
      floor: _floor?.state ?? const Idle(),
      blockedReason: () => null,
      speakerBusy: _speakerBusy,
    );
    _syncReach();
    _publishKeys();
  }

  // --------------------------------------------------------------- talking

  /// Starts a transmission on the active channel. False - with
  /// [RadioState.blockedReason] saying why - when somebody else holds the
  /// channel, a call is up, or the microphone cannot be had.
  Future<bool> pressToTalk() async {
    if (_press != null) return true;
    final active = state.active;
    final floor = _floor;
    if (active == null || floor == null) {
      return _refuse(RadioBlockedReason.noChannel);
    }
    final send = _sendFor(active);
    if (send == null) return _refuse(RadioBlockedReason.noChannel);
    if (_callBusy()) return _refuse(RadioBlockedReason.call);
    // The last speaker's sentence is still playing: the floor is free on
    // paper, but talking now would cover its end ([RadioState.speakerBusy]).
    if (_speakerBusy) return _refuse(RadioBlockedReason.busy);

    final RadioEncoder encoder;
    try {
      encoder = _codec.encoder();
    } catch (e) {
      if (!_saidNoCodec) {
        _saidNoCodec = true;
        DebugLog.instance.log('RADIO', 'no codec here: $e');
      }
      return _refuse(RadioBlockedReason.unavailable);
    }
    final framer = RadioFramer(encode: encoder.encode, clock: _clock);
    // The same start the chunks carry: the floor's tie-break compares it with
    // the start in other people's chunks, so it must be the number they see.
    if (!floor.tryTalk(framer.transmissionId, framer.startedAtMs)) {
      encoder.dispose();
      _syncFloor();
      return _refuse(RadioBlockedReason.busy);
    }
    final press = _Press(
      framer: framer,
      encoder: encoder,
      floor: floor,
      send: send,
    );
    _press = press;
    _syncReach();
    _wake();
    _armCallIdle();
    state = state.copyWith(floor: floor.state, blockedReason: () => null);
    // A timer, not a check on each piece of PCM: a microphone that stalls
    // must not hold the channel either.
    press.cap = Timer(
      maxPress,
      () => unawaited(_endPress(press, sendLast: true, tooLong: true)),
    );

    final stream = await _mic.open();
    if (stream == null) {
      await _endPress(press, sendLast: false);
      return _refuse(RadioBlockedReason.microphone);
    }
    press.micOpen = true;
    if (press.over || _disposed) {
      // Released, out-talked or torn down while the microphone was opening.
      await _mic.close();
      if (press.lost) return _refuse(RadioBlockedReason.busy);
      return false;
    }
    press.sub = stream.listen(
      (bytes) => _onPcm(press, bytes),
      onError: (Object e) {
        DebugLog.instance.log('RADIO', 'microphone stream: $e');
        unawaited(_endPress(press, sendLast: true));
      },
      onDone: () => unawaited(_endPress(press, sendLast: true)),
    );
    return true;
  }

  /// Ends the transmission: the microphone is let go and the last chunk, which
  /// tells every listener the press is over, goes out.
  Future<void> releaseToTalk() async {
    final press = _press;
    if (press == null) return;
    await _endPress(press, sendLast: true);
  }

  bool _refuse(RadioBlockedReason reason) {
    if (!_disposed) state = state.copyWith(blockedReason: () => reason);
    return false;
  }

  Future<int> Function(RadioChunk)? _sendFor(RadioChannel channel) {
    switch (channel) {
      case RadioRoom(:final tagHex):
        final key = _stored[tagHex]?.key;
        if (key == null) return null;
        final tag = radioUnhex(tagHex);
        return (chunk) => _sender.toGroup(key, tag, chunk);
      case RadioContact(:final canonicalId):
        return (chunk) => _sender.toContact(canonicalId, chunk);
    }
  }

  void _onPcm(_Press press, Uint8List bytes) {
    if (press.over) return;
    if (press.floor.state is! Talking) {
      unawaited(_endPress(press, sendLast: false, lost: true));
      return;
    }
    press.fed = true;
    try {
      for (final chunk in press.framer.add(bytes)) {
        _queueSend(press, chunk);
      }
    } catch (e) {
      DebugLog.instance.log('RADIO', 'encode failed: $e');
      unawaited(_endPress(press, sendLast: false));
    }
  }

  /// Sends in order, one at a time: a receiver puts chunks back in order
  /// anyway, but there is no reason to hand it a shuffle to undo.
  void _queueSend(_Press press, RadioChunk chunk) {
    if (!chunk.isLast && press.inFlight >= maxQueuedSends) {
      press.dropped++;
      return;
    }
    press.inFlight++;
    press.sent++;
    press.chain = press.chain.then((_) async {
      try {
        press.links += await press.send(chunk);
      } catch (e) {
        debugPrint('radio send failed: $e');
      } finally {
        press.inFlight--;
      }
    });
  }

  Future<void> _endPress(
    _Press press, {
    required bool sendLast,
    bool lost = false,
    bool tooLong = false,
  }) async {
    if (press.over) return;
    press.over = true;
    press.lost = lost;
    press.cap?.cancel();
    if (tooLong && !_disposed) {
      state = state.copyWith(
        blockedReason: () => RadioBlockedReason.tooLong,
      );
    }
    if (identical(_press, press)) _press = null;
    _syncReach();
    final heldMs = _clock().millisecondsSinceEpoch - press.framer.startedAtMs;
    // A press that never got a sample in is not a transmission: nobody has
    // heard of it, and a lone "last" chunk would only flicker their floor.
    if (sendLast && press.fed) {
      try {
        _queueSend(press, press.framer.finish());
      } catch (e) {
        DebugLog.instance.log('RADIO', 'encode failed: $e');
      }
    }
    press.encoder.dispose();
    press.floor.stopTalking();
    _syncFloor();
    // A reply on a call-tuned channel: the two minutes count from here.
    _armCallIdle();

    // Not awaited: nothing after this depends on the cancel having finished
    // (over is set, so a late sample is ignored), and the microphone is let go
    // in this turn rather than after it.
    unawaited(press.sub?.cancel());
    press.sub = null;
    if (press.micOpen) await _mic.close();
    await press.chain;
    if (press.sent == 0) return;
    final note = StringBuffer(
      'sent ${press.sent} chunks in '
      '${(math.max(0, heldMs) / 1000).toStringAsFixed(1)} s',
    );
    if (press.links == 0) {
      // Whether anybody was there to link to: "nobody in reach" with phones
      // in view is a link that was never made, not an empty room.
      final seen = _nearby();
      note.write(', nobody in reach ($seen cubechat phone(s) in view)');
    }
    if (press.dropped > 0) note.write(', ${press.dropped} dropped behind');
    if (lost) note.write(', channel taken');
    if (tooLong) note.write(', cut at ${maxPress.inSeconds} s');
    DebugLog.instance.log('RADIO', note.toString());
  }

  // ------------------------------------------------------------- listening

  void _onInbound(RadioInbound m) {
    if (state.active == null && !_answerPersonalCall(m)) return;
    final active = state.active;
    final floor = _floor;
    final buffer = _buffer;
    if (active == null || floor == null || buffer == null) return;
    if (!_matches(active, m)) return;
    // Dropped, not queued: voice held until the call ends is voice too late.
    if (_callBusy()) return;
    final chunk = m.chunk;
    if (_closed.any((id) => _sameId(id, chunk.transmissionId))) return;

    final accepted = floor.onChunk(m.senderId, chunk);
    final staleBy = floor.staleBy;
    if (staleBy != null) _noteStale(m.senderId, chunk, staleBy);
    if (accepted || floor.state is! Idle) _wake();
    final press = _press;
    if (press != null && floor.state is Listening) {
      // Out-talked: somebody pressed first. Stop the microphone now; what we
      // already sent loses on every phone the same way.
      unawaited(_endPress(press, sendLast: false, lost: true));
    }
    if (accepted) {
      var heard = _heard;
      if (heard == null || !_sameId(heard.txId, chunk.transmissionId)) {
        // A new winner. Whatever the buffer held belongs to a press that is
        // over or out-talked, and would otherwise hold the buffer shut. A
        // press that is still being heard has lost the floor for good.
        _closeHeard(stopNow: false, over: true);
        buffer.reset();
        heard = _heard = _Heard(
          Uint8List.fromList(chunk.transmissionId),
          chunk.startedAtMs,
          _clock(),
        );
        _armCallIdle();
      }
      if (buffer.push(chunk)) heard.note(chunk, _clock());
    }
    _syncFloor();
  }

  /// One line for a transmission the floor refused for its timing - almost
  /// always a sender whose clock is a minute or more out, which would
  /// otherwise be a radio that is silent for no reason anybody can see.
  void _noteStale(String senderId, RadioChunk chunk, Duration off) {
    final id = chunk.transmissionId;
    if (_staleLogged.any((x) => _sameId(x, id))) return;
    final now = _clock();
    final last = _staleLoggedAt;
    if (last != null && now.difference(last) < _staleLogEvery) return;
    _staleLoggedAt = now;
    _staleLogged.add(Uint8List.fromList(id));
    if (_staleLogged.length > _closedKept) _staleLogged.removeAt(0);
    final short = senderId.length > 8 ? senderId.substring(0, 8) : senderId;
    DebugLog.instance.log(
      'RADIO',
      'drop tx ${radioHex(Uint8List.sublistView(id, 0, 4))} from $short: '
          '${(off.inMilliseconds / 1000).toStringAsFixed(1)} s off (clock?)',
    );
  }

  static bool _matches(RadioChannel active, RadioInbound m) {
    final tag = m.groupTag;
    return switch (active) {
      RadioRoom(:final tagHex) => tag != null && radioHex(tag) == tagHex,
      RadioContact(:final canonicalId) =>
        tag == null && m.senderId == canonicalId,
    };
  }

  void _tick() {
    final floor = _floor;
    final buffer = _buffer;
    if (floor == null || buffer == null) return;
    // Before the call check: the floor must still free itself after its tail
    // while a call is up, or the screen reads "busy" for the whole call.
    floor.tick();
    if (_callBusy()) {
      final press = _press;
      if (press != null) unawaited(_endPress(press, sendLast: true));
      _closeHeard(stopNow: true);
      _syncFloor();
      _sleepIfIdle(floor);
      return;
    }
    final heard = _heard;
    if (heard != null) {
      final frames = buffer.drain();
      if (frames.isNotEmpty) _play(heard, frames);
      final f = floor.state;
      final stillHeld = f is Listening && _sameId(f.transmissionId, heard.txId);
      if (buffer.finished) {
        _closeHeard(stopNow: false, over: true);
      } else if (!heard.lastArrived && !stillHeld) {
        // The floor let go after its tail: the buffer would wait for the last
        // chunk for ever. Not marked over - a second's stall in the middle
        // of a sentence looks the same from here, and if its chunks come back
        // the floor takes them as Listening again and they play.
        _closeHeard(stopNow: false);
      } else if (_clock().difference(heard.lastArrival) > _stuckAfter) {
        _closeHeard(stopNow: false, over: heard.lastArrived);
      }
    }
    _syncFloor();
    _sleepIfIdle(floor);
  }

  /// Starts the tick if it is not running. Called when something begins that
  /// the tick has to carry through: a press, or a chunk that took the floor.
  void _wake() {
    if (_disposed || _floor == null) return;
    _ticker ??= Timer.periodic(tickEvery, (_) => _tick());
  }

  /// Puts the tick away once there is nothing for it to do: nobody holds the
  /// floor (its tail has run out), nothing is being heard, nothing is being
  /// sent. The speaker's own stop is a one-shot timer of its own
  /// ([_stopTimer]) and does not need this one.
  void _sleepIfIdle(RadioFloor floor) {
    if (floor.state is Idle && _heard == null && _press == null) {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  void _play(_Heard heard, List<Uint8List?> frames) {
    final decoder = heard.decoder ??= _openDecoder();
    if (decoder == null) return;
    final parts = <Int16List>[];
    var total = 0;
    for (final f in frames) {
      Int16List samples;
      if (f == null) {
        // A chunk that never came: 20 ms of silence per frame (Ruling 9).
        samples = Int16List(_frameSamples);
      } else {
        try {
          samples = decoder.decode(f);
        } catch (_) {
          samples = Int16List(_frameSamples);
        }
      }
      parts.add(samples);
      total += samples.length;
    }
    final pcm = Int16List(total);
    var o = 0;
    for (final p in parts) {
      pcm.setAll(o, p);
      o += p.length;
    }

    final now = _clock();
    if (!heard.speakerStarted) {
      // Started for every transmission, not once: an interruption (a call, a
      // route change) leaves the native player stopped, and a start on an
      // open one restarts it cleanly.
      heard.speakerStarted = true;
      _stopTimer?.cancel();
      _stopTimer = null;
      _speakerOpen = true;
      _playEnd = now;
      final silent = state.playInSilentMode;
      final inCall = _inCall();
      _audioDo(() => _sink.start(playInSilentMode: silent, inCall: inCall));
    }
    // From the later of now and the end of what is queued: a gap in what was
    // written (the buffer waiting on a hole) is a gap the speaker sat idle in.
    final from = _playEnd != null && _playEnd!.isAfter(now) ? _playEnd! : now;
    _playEnd = from.add(
      Duration(
        microseconds: total * Duration.microsecondsPerSecond ~/ _sampleRate,
      ),
    );
    _audioDo(() => _sink.write(pcm));
  }

  RadioDecoder? _openDecoder() {
    try {
      return _codec.decoder();
    } catch (e) {
      if (!_saidNoCodec) {
        _saidNoCodec = true;
        DebugLog.instance.log('RADIO', 'no codec here: $e');
      }
      return null;
    }
  }

  /// Ends the transmission being heard: one log line, and the speaker let go
  /// once what was written has played - or at once, when [stopNow]. [over]
  /// when the transmission itself is over (see [_closed]), not only this
  /// phone's playback of it.
  void _closeHeard({required bool stopNow, bool over = false}) {
    final heard = _heard;
    if (heard != null) {
      _heard = null;
      _armCallIdle();
      _buffer?.reset();
      heard.decoder?.dispose();
      if (over) _markClosed(heard.txId);
      if (heard.count > 0) {
        final latencyMs = math.max(
          0,
          heard.firstArrival.millisecondsSinceEpoch - heard.startedAtMs,
        );
        DebugLog.instance.log(
          'RADIO',
          'heard ${heard.count} chunks, '
              '${(latencyMs / 1000).toStringAsFixed(1)} s latency, '
              '${heard.lost} lost',
        );
      }
    }
    if (!_speakerOpen) return;
    if (stopNow) {
      _stopSpeaker();
      return;
    }
    final now = _clock();
    final end = _playEnd ?? now;
    final wait =
        (end.isAfter(now) ? end.difference(now) : Duration.zero) + stopMargin;
    _stopTimer?.cancel();
    _stopTimer = Timer(wait, _stopSpeaker);
  }

  void _markClosed(Uint8List txId) {
    if (_closed.any((id) => _sameId(id, txId))) return;
    _closed.add(Uint8List.fromList(txId));
    if (_closed.length > _closedKept) _closed.removeAt(0);
  }

  void _stopSpeaker() {
    _stopTimer?.cancel();
    _stopTimer = null;
    if (!_speakerOpen) return;
    _speakerOpen = false;
    _playEnd = null;
    final inCall = _inCall();
    _audioDo(() => _sink.stop(inCall: inCall));
    _syncFloor();
  }

  /// [_callBusy] for the speaker's sake. It reads another provider, which a
  /// teardown may run after; not knowing is "no call", as it was before Dart
  /// said anything about it.
  bool _inCall() {
    try {
      return _callBusy();
    } catch (_) {
      return false;
    }
  }

  void _audioDo(Future<void> Function() op) {
    _audio = _audio.then((_) => op()).catchError((Object e) {
      debugPrint('radio audio failed: $e');
    });
  }

  /// A transmission is being heard, or its sound has not finished playing.
  bool get _speakerBusy => _heard != null || _speakerOpen;

  /// Publishes the floor and [RadioState.speakerBusy] when either changed.
  void _syncFloor() {
    if (_disposed) return;
    final f = _floor?.state ?? const Idle();
    final busy = _speakerBusy;
    if (!_sameFloor(f, state.floor) || busy != state.speakerBusy) {
      state = state.copyWith(floor: f, speakerBusy: busy);
    }
  }

  /// Everything the controller holds open, let go without waiting.
  void _teardown() {
    _ticker?.cancel();
    _ticker = null;
    _stopTimer?.cancel();
    _stopTimer = null;
    _callIdle?.cancel();
    _callIdle = null;
    final press = _press;
    _press = null;
    press?.cap?.cancel();
    if (press != null && !press.over) {
      press.over = true;
      unawaited(press.sub?.cancel());
      if (press.micOpen) unawaited(_mic.close());
      press.encoder.dispose();
    }
    _heard?.decoder?.dispose();
    _heard = null;
    if (_speakerOpen) {
      _speakerOpen = false;
      // Through the chain: a start or write still queued in it would
      // otherwise run after this stop and reopen the player with nobody left
      // to close it.
      final inCall = _inCall();
      _audioDo(() => _sink.stop(inCall: inCall));
    }
  }

  static bool _sameFloor(FloorState a, FloorState b) => switch ((a, b)) {
        (Idle(), Idle()) => true,
        (Talking(transmissionId: final x), Talking(transmissionId: final y)) =>
          _sameId(x, y),
        (
          Listening(senderId: final s, transmissionId: final x),
          Listening(senderId: final t, transmissionId: final y),
        ) =>
          s == t && _sameId(x, y),
        _ => false,
      };

  static bool _sameId(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// One press of the button, from tryTalk to the last chunk sent.
class _Press {
  _Press({
    required this.framer,
    required this.encoder,
    required this.floor,
    required this.send,
  });

  final RadioFramer framer;
  final RadioEncoder encoder;

  /// The floor it was granted on - not whatever floor is current when it
  /// ends, which after a channel switch is another channel's.
  final RadioFloor floor;
  final Future<int> Function(RadioChunk) send;

  StreamSubscription<Uint8List>? sub;

  /// Ends the press at [RadioController.maxPress].
  Timer? cap;
  bool micOpen = false;
  bool fed = false;
  bool over = false;
  bool lost = false;

  Future<void> chain = Future<void>.value();
  int inFlight = 0;
  int sent = 0;
  int links = 0;
  int dropped = 0;
}

/// One transmission being heard, for its playback and its one log line.
class _Heard {
  _Heard(this.txId, this.startedAtMs, this.firstArrival)
      : lastArrival = firstArrival;

  final Uint8List txId;
  final int startedAtMs;
  final DateTime firstArrival;
  DateTime lastArrival;

  RadioDecoder? decoder;
  bool speakerStarted = false;

  int count = 0;
  int maxSeq = -1;
  int? lastSeq;

  bool get lastArrived => lastSeq != null;

  /// Chunks that should have come and did not: the gaps, plus at least one
  /// when the last chunk itself never arrived.
  int get lost {
    final expected = (lastSeq ?? maxSeq) + 1 + (lastSeq == null ? 1 : 0);
    return math.max(0, expected - count);
  }

  void note(RadioChunk chunk, DateTime now) {
    count++;
    lastArrival = now;
    if (chunk.seq > maxSeq) maxSeq = chunk.seq;
    if (chunk.isLast) lastSeq = chunk.seq;
  }
}

final radioControllerProvider =
    NotifierProvider<RadioController, RadioState>(RadioController.new);
