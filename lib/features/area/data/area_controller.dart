import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/nostr/area_relay_link.dart';
import '../../../core/transport/nostr/nostr_event.dart';
import '../../../core/transport/nostr/nostr_signer.dart';
import '../../../core/transport/nostr/nostr_transport.dart';
import '../../../core/util/debug_log.dart';
import '../../../core/util/location_service.dart';
import '../../moderation/domain/report.dart';
import '../domain/area_event.dart';
import '../domain/area_level.dart';
import '../domain/area_room.dart';
import '../domain/area_send_limits.dart';
import 'area_ban_list.dart';
import 'area_keys.dart';
import 'area_location.dart';
import 'area_report.dart';
import 'area_settings.dart';
import 'area_store.dart';

/// Builds the socket; a fake in tests.
typedef AreaLinkFactory = AreaRelayLink Function({
  required void Function(NostrEvent event) onEvent,
  required void Function(bool connected) onConnection,
});

final areaLinkFactoryProvider = Provider<AreaLinkFactory>(
  (ref) => ({required onEvent, required onConnection}) =>
      AreaRelayLink(onEvent: onEvent, onConnection: onConnection),
);
final areaBanFetcherProvider =
    Provider<AreaBanFetcher>((ref) => fetchAreaBanList);
final areaMinerProvider = Provider<AreaMiner>((ref) => mineOffThread);
final areaSignatureCheckProvider = Provider<AreaSignatureCheck?>((ref) => null);
final areaClockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// What happened to something the person tried to send.
enum AreaSendResult {
  sent,

  /// The phone's own limits, or the relay's: "wait a little".
  tooFast,
  offline,

  /// A city read from the map: writing is only where one is.
  readOnly,

  /// No fix yet, so no own place to write in.
  noPlace,
}

@immutable
class AreaState {
  const AreaState({
    this.place,
    this.locating = false,
    this.locationFailure,
    this.connected = false,
    this.foreignCell,
    this.revision = 0,
  });

  /// Where the phone's own fix puts it. Null until one arrives.
  final AreaPlace? place;
  final bool locating;
  final LocationFailure? locationFailure;
  final bool connected;

  /// The city or region being read from the map, if any.
  final String? foreignCell;

  /// Bumped on every change to the rooms, which live outside this object.
  final int revision;

  AreaState copyWith({
    AreaPlace? place,
    bool? locating,
    LocationFailure? locationFailure,
    bool clearFailure = false,
    bool? connected,
    String? foreignCell,
    bool clearForeign = false,
    bool bump = false,
  }) =>
      AreaState(
        place: place ?? this.place,
        locating: locating ?? this.locating,
        locationFailure:
            clearFailure ? null : locationFailure ?? this.locationFailure,
        connected: connected ?? this.connected,
        foreignCell: clearForeign ? null : foreignCell ?? this.foreignCell,
        revision: bump ? revision + 1 : revision,
      );
}

/// One of this phone's own notes, kept on disk until it expires — only so it
/// can be deleted, by its own key.
class _OwnNote {
  _OwnNote({
    required this.id,
    required this.seed,
    required this.expiration,
    required this.madeAt,
  });

  final String id;
  final String seed;
  final int expiration;
  final int madeAt;

  Map<String, Object> toJson() => {
        'id': id,
        'seed': seed,
        'expiration': expiration,
        'madeAt': madeAt,
      };

  static _OwnNote? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final id = raw['id'], seed = raw['seed'];
    final expiration = raw['expiration'], madeAt = raw['madeAt'];
    if (id is! String || seed is! String || expiration is! int) return null;
    return _OwnNote(
      id: id,
      seed: seed,
      expiration: expiration,
      madeAt: madeAt is int ? madeAt : 0,
    );
  }
}

/// The area chat: where the phone is, the socket, the rooms, and everything
/// this phone says there.
///
/// **Nothing here answers anything.** Every event this phone publishes comes
/// from a person's tap or from the presence timer, which does not look at
/// what arrives. bitchat's district keys signed a "delivered" for any direct
/// message, and anybody could ask whether a known key was online right now
/// (H6). Inbound events only change the rooms.
///
/// Runs only while somebody holds a session — "Nearby", an area chat, the
/// notes — and ~30 s after the last one lets go, so switching levels does not
/// reconnect. No session: no fix, no socket.
class AreaController extends Notifier<AreaState> {
  static const Duration linger = Duration(seconds: 30);
  static const Duration fixEvery = Duration(minutes: 5);
  static const Duration banListEvery = Duration(minutes: 10);

  /// Presence every 60 ± 20 s.
  static const Duration presenceBase = Duration(seconds: 60);
  static const int presenceJitterSeconds = 20;

  /// An author blocked here stays blocked a day: longer than any key lives.
  static const Duration hiddenFor = Duration(days: 1);

  late AreaKeyring _keyring;
  late AreaKv _kv;
  late DateTime Function() _clock;
  final AreaCellTracker _tracker = AreaCellTracker();
  final AreaSendLimits _limits = AreaSendLimits();
  final Map<AreaRoomId, AreaRoom> _rooms = {};
  final Map<AreaLevel, AreaIdentity> _identities = {};
  final Set<String> _hiddenPosts = {};
  final Map<String, int> _hiddenAuthors = {};
  final List<_OwnNote> _ownNotes = [];
  AreaBanList _bans = const AreaBanList();
  final Random _random = Random();

  AreaRelayLink? _link;
  int _holders = 0;
  bool _running = false;
  Timer? _lingerTimer;
  Timer? _fixTimer;
  Timer? _banTimer;
  Timer? _presenceTimer;
  AreaRoomId? _presenceRoom;
  bool _loaded = false;

  @override
  AreaState build() {
    _keyring = ref.watch(areaKeyringProvider);
    _kv = ref.watch(areaKvProvider);
    _clock = ref.watch(areaClockProvider);
    ref.listen(areaSettingsProvider, (previous, next) {
      if (!next.enabled || !next.consented) {
        _stop();
      } else if (_holders > 0 && !_running) {
        _start();
      }
      if (previous?.showPresence != next.showPresence) {
        _schedulePresence();
        _bump();
      }
    });
    ref.onDispose(_dispose);
    return const AreaState();
  }

  // ---------------------------------------------------------------- reading

  AreaRoom room(AreaRoomId id) => _rooms.putIfAbsent(id, AreaRoom.new);

  /// Whether a message's author was hidden or blocked here, or banned.
  bool isHidden(AreaPost post) =>
      _hiddenPosts.contains(post.id) ||
      _hiddenAuthors.containsKey(post.pubkey) ||
      _bans.keys.contains(post.pubkey) ||
      _bans.events.contains(post.id);

  /// "≈N here" for [id], or null where it is not shown: in a district, in a
  /// city being read from the map, and to anybody not shown themselves —
  /// symmetric like last seen (owner's answer 5).
  int? presentCount(AreaRoomId id) {
    if (id.readOnly || id.level == null || !id.level!.coarse) return null;
    if (!ref.read(areaSettingsProvider).showPresence) return null;
    return room(id).presentCount(_nowSeconds());
  }

  /// This phone's key in [level] of its own place, if it has one yet.
  AreaIdentity? identity(AreaLevel level) => _identities[level];

  /// Every note held, for the map: the own city's and region's and the
  /// city being read.
  List<AreaNote> allNotes() {
    final now = _nowSeconds();
    return [
      for (final r in _rooms.values)
        for (final n in r.notesAt(now))
          if (!_hiddenAuthors.containsKey(n.pubkey) &&
              !_bans.keys.contains(n.pubkey) &&
              !_bans.events.contains(n.id))
            n,
    ];
  }

  bool canLeaveNote() => AreaSendLimits.canLeaveNote(
        _ownNotes.map((n) => DateTime.fromMillisecondsSinceEpoch(n.madeAt)),
        _clock(),
      );

  // -------------------------------------------------------------- sessions

  /// A screen of the area chat is on screen. Pair with [release].
  void acquire() {
    _holders++;
    _lingerTimer?.cancel();
    _lingerTimer = null;
    if (!_running) _start();
  }

  void release() {
    if (_holders == 0) return;
    _holders--;
    if (_holders > 0) return;
    _lingerTimer?.cancel();
    _lingerTimer = Timer(linger, () {
      _lingerTimer = null;
      if (_holders == 0) _stop();
    });
  }

  /// Read the city or region [cell] from the map. Only the subscription
  /// leaves the phone for it: no key, no presence, nothing to write.
  void openForeign(String cell) {
    if (cell.length != 3 && cell.length != 4) {
      throw ArgumentError.value(cell, 'cell', 'a city or a region');
    }
    final place = state.place;
    if (place != null && (cell == place.city || cell == place.region)) return;
    if (state.foreignCell != cell) {
      final old = state.foreignCell;
      if (old != null) _rooms.remove(AreaRoomId.foreign(old));
      state = state.copyWith(foreignCell: cell, bump: true);
    }
    _resubscribe();
  }

  /// Stops reading the city from the map — [only] that one, if given, so a
  /// screen closing late cannot close another's.
  void closeForeign({String? only}) {
    final old = state.foreignCell;
    if (old == null || (only != null && old != only)) return;
    _rooms.remove(AreaRoomId.foreign(old));
    state = state.copyWith(clearForeign: true, bump: true);
    _resubscribe();
  }

  /// The chat of [id] is on screen (or nothing is, for null). Presence goes
  /// only to that level and only while it is open — not to every level while
  /// the app is, as bitchat's did.
  void setPresenceRoom(AreaRoomId? id) {
    _presenceRoom = id;
    _schedulePresence();
  }

  void _start() {
    final settings = ref.read(areaSettingsProvider);
    if (!settings.enabled || !settings.consented || _running) return;
    _running = true;
    unawaited(_loadDisk());
    _link ??= ref.read(areaLinkFactoryProvider)(
      onEvent: (e) => unawaited(_onRaw(e)),
      onConnection: (up) {
        if (state.connected != up) state = state.copyWith(connected: up);
      },
    );
    unawaited(_readFix());
    _fixTimer = Timer.periodic(fixEvery, (_) => unawaited(_readFix()));
    unawaited(_refreshBans());
    _banTimer = Timer.periodic(banListEvery, (_) => unawaited(_refreshBans()));
    _resubscribe();
    _schedulePresence();
  }

  void _stop() {
    _running = false;
    _lingerTimer?.cancel();
    _lingerTimer = null;
    _fixTimer?.cancel();
    _fixTimer = null;
    _banTimer?.cancel();
    _banTimer = null;
    _presenceTimer?.cancel();
    _presenceTimer = null;
    final link = _link;
    _link = null;
    if (link != null) unawaited(link.dispose());
    if (state.connected || state.locating) {
      state = state.copyWith(connected: false, locating: false);
    }
  }

  void _dispose() {
    _stop();
  }

  // -------------------------------------------------------------- location

  Future<void> _readFix() async {
    if (!_running) return;
    state = state.copyWith(locating: true);
    final (district, failure) = await ref.read(areaDistrictReaderProvider)();
    if (!_running) return;
    if (district == null) {
      state = state.copyWith(locating: false, locationFailure: failure);
      return;
    }
    final chosen = _tracker.accept(district);
    final previous = state.place;
    final place = AreaPlace(chosen);
    if (previous != place) {
      // A new place is new rooms and new keys; what was said in the old one
      // is not shown as if it were here.
      for (final level in AreaLevel.values) {
        if (previous == null ||
            previous.cellOf(level) != place.cellOf(level)) {
          _rooms.remove(AreaRoomId.own(level));
          _identities.remove(level);
        }
      }
      final foreign = state.foreignCell;
      if (foreign != null && (foreign == place.city || foreign == place.region)) {
        _rooms.remove(AreaRoomId.foreign(foreign));
        state = state.copyWith(clearForeign: true);
      }
    }
    state = state.copyWith(
      place: place,
      locating: false,
      clearFailure: true,
      bump: true,
    );
    await _loadIdentities(place);
    _resubscribe();
  }

  Future<void> _loadIdentities(AreaPlace place) async {
    for (final level in AreaLevel.values) {
      try {
        _identities[level] =
            await _keyring.identityFor(level, place.cellOf(level));
      } catch (e) {
        DebugLog.instance.log('AREA', 'no key for $level: $e');
      }
    }
    _bump();
  }

  /// "New name": a new key for [level] now.
  Future<void> renewIdentity(AreaLevel level) async {
    final place = state.place;
    if (place == null) return;
    _identities[level] = await _keyring.renew(level, place.cellOf(level));
    _bump();
  }

  /// Sets a name by hand. Returns true when this phone already goes by that
  /// name somewhere else — the screen warns that it ties the two together.
  Future<bool> setCustomName(AreaLevel level, String? name) async {
    final place = state.place;
    if (place == null) return false;
    final cell = place.cellOf(level);
    final clash = name != null &&
        await _keyring.nameUsedElsewhere(name, level, cell);
    _identities[level] = await _keyring.setName(level, cell, name);
    _bump();
    return clash;
  }

  // ---------------------------------------------------------- subscription

  Set<String> _subscribedCells() => {
        ...?state.place?.subscription,
        if (state.foreignCell != null) state.foreignCell!,
      };

  void _resubscribe() {
    final link = _link;
    if (link == null || !_running) return;
    link.setFilters(
      areaSubscriptionFilters(_subscribedCells(), nowSeconds: _nowSeconds()),
    );
  }

  Future<void> _onRaw(NostrEvent event) async {
    final (inbound, _) = await verifyAreaEvent(
      event,
      nowSeconds: _nowSeconds(),
      signature: ref.read(areaSignatureCheckProvider),
    );
    if (inbound == null || !_running) return;
    if (_bans.events.contains(inbound.id) ||
        _bans.keys.contains(inbound.pubkey) ||
        _hiddenAuthors.containsKey(inbound.pubkey)) {
      return;
    }
    final target = _roomFor(inbound);
    if (target == null) return;
    final r = room(target);
    final mine = _isMine(inbound);
    var changed = true;
    if (inbound.kind == kAreaMessageKind) {
      changed = r.addPost(inbound, mine: mine);
    } else if (inbound.kind == kAreaNoteKind) {
      changed = r.addNote(inbound, mine: mine);
    } else {
      r.addPresence(inbound);
    }
    if (changed) _bump();
  }

  bool _isMine(AreaInbound e) =>
      _identities.values.any((i) => i.pubkey == e.pubkey) ||
      _ownNotes.any((n) => n.id == e.id);

  /// Which room an event belongs in, or null for one subscribed only for its
  /// neighbours' sake (a neighbouring city's own chat).
  AreaRoomId? _roomFor(AreaInbound e) {
    final place = state.place;
    final foreign = state.foreignCell;
    final cell = e.content?.cell;
    if (e.kind == kAreaMessageKind && cell != null) {
      if (place != null && place.viewDistricts.contains(cell)) {
        return const AreaRoomId.own(AreaLevel.district);
      }
      return foreign != null && e.g == foreign
          ? AreaRoomId.foreign(foreign)
          : null;
    }
    if (place != null && e.g == place.city) {
      return const AreaRoomId.own(AreaLevel.city);
    }
    if (place != null && e.g == place.region) {
      return const AreaRoomId.own(AreaLevel.region);
    }
    if (foreign != null && e.g == foreign) return AreaRoomId.foreign(foreign);
    return null;
  }

  // --------------------------------------------------------------- writing

  /// Sends [text] to [id]'s chat.
  Future<AreaSendResult> send(
    AreaRoomId id,
    String text, {
    String? replyTo,
  }) async {
    if (id.readOnly) return AreaSendResult.readOnly;
    final place = state.place;
    final link = _link;
    if (place == null) return AreaSendResult.noPlace;
    if (link == null || !link.connected) return AreaSendResult.offline;
    final level = id.level!;
    final clean = clipAreaText(cleanAreaText(text), kAreaMaxTextChars);
    if (clean.isEmpty) return AreaSendResult.sent;
    final now = _clock();
    if (!_limits.canSend(level, now)) return AreaSendResult.tooFast;
    _limits.noteSent(level, now);

    final identity = await _keyring.identityFor(level, place.cellOf(level));
    _identities[level] = identity;
    final unsigned = areaMessageEvent(
      pubkey: identity.pubkey,
      g: level == AreaLevel.district ? place.city : place.cellOf(level),
      cell: level == AreaLevel.district ? place.district : null,
      text: clean,
      name: identity.customName,
      replyTo: replyTo,
      now: now,
    );
    final signed = await _finish(unsigned, identity.signer);
    final outcome = await link.publish(signed);
    if (outcome != AreaPublishOutcome.accepted) {
      return outcome == AreaPublishOutcome.refused
          ? AreaSendResult.tooFast
          : AreaSendResult.offline;
    }
    final (echo, _) = await verifyAreaEvent(
      signed,
      nowSeconds: _nowSeconds(),
      signature: (_) async => true,
    );
    if (echo != null) {
      room(id).addPost(echo, mine: true);
      _bump();
    }
    return AreaSendResult.sent;
  }

  /// Leaves a note on the own city. [pinnedDistrict] is a district the
  /// person put the pin on by hand, inside their city, or null — never the
  /// district of the fix (spec, rule 2).
  Future<AreaSendResult> leaveNote(
    String text, {
    required Duration lifetime,
    String? pinnedDistrict,
  }) async {
    final place = state.place;
    final link = _link;
    if (place == null) return AreaSendResult.noPlace;
    if (link == null || !link.connected) return AreaSendResult.offline;
    if (pinnedDistrict != null &&
        (pinnedDistrict.length != 5 || !pinnedDistrict.startsWith(place.city))) {
      throw ArgumentError.value(pinnedDistrict, 'pinnedDistrict');
    }
    final clean = clipAreaText(cleanAreaText(text), kAreaMaxTextChars);
    if (clean.isEmpty) return AreaSendResult.sent;
    if (!canLeaveNote()) return AreaSendResult.tooFast;

    // A key for this note alone: two notes of one person are tied neither to
    // each other nor to their chat.
    final seed = _seed();
    final signer = await Secp256k1NostrSigner.deriveFromSeed(seed);
    final unsigned = areaNoteEvent(
      pubkey: signer.npubHex,
      g: place.city,
      cell: pinnedDistrict,
      text: clean,
      lifetime: lifetime,
      now: _clock(),
    );
    final signed = await _finish(unsigned, signer);
    final outcome = await link.publish(signed);
    if (outcome != AreaPublishOutcome.accepted) {
      return outcome == AreaPublishOutcome.refused
          ? AreaSendResult.tooFast
          : AreaSendResult.offline;
    }
    _ownNotes.add(
      _OwnNote(
        id: signed.id!,
        seed: base64.encode(seed),
        expiration: signed.createdAt + lifetime.inSeconds,
        madeAt: _clock().millisecondsSinceEpoch,
      ),
    );
    await _saveOwnNotes();
    final (echo, _) = await verifyAreaEvent(
      signed,
      nowSeconds: _nowSeconds(),
      signature: (_) async => true,
    );
    if (echo != null) {
      room(const AreaRoomId.own(AreaLevel.city)).addNote(echo, mine: true);
      _bump();
    }
    return AreaSendResult.sent;
  }

  /// Takes one of this phone's notes down before its time (NIP-09).
  Future<bool> deleteNote(String noteId) async {
    final own = _ownNotes.where((n) => n.id == noteId).firstOrNull;
    final link = _link;
    if (own == null || link == null || !link.connected) return false;
    final signer = await Secp256k1NostrSigner.deriveFromSeed(
      Uint8List.fromList(base64.decode(own.seed)),
    );
    final signed = await _finish(
      areaDeletionEvent(pubkey: signer.npubHex, noteId: noteId, now: _clock()),
      signer,
    );
    final outcome = await link.publish(signed);
    if (outcome != AreaPublishOutcome.accepted) return false;
    _ownNotes.remove(own);
    await _saveOwnNotes();
    for (final r in _rooms.values) {
      r.removeNote(noteId);
    }
    _bump();
    return true;
  }

  bool isOwnNote(String id) => _ownNotes.any((n) => n.id == id);

  /// Nonce for the kind's work, the three ceilings, then the signature.
  Future<NostrEvent> _finish(NostrEvent unsigned, NostrEventSigner signer) async {
    final bits = areaPowBits(unsigned.kind);
    final mined =
        bits == 0 ? unsigned : await ref.read(areaMinerProvider)(unsigned, bits);
    checkAreaCeilings(mined);
    return signer.sign(mined);
  }

  void _schedulePresence() {
    _presenceTimer?.cancel();
    _presenceTimer = null;
    final id = _presenceRoom;
    if (!_running ||
        id == null ||
        id.readOnly ||
        !id.level!.coarse ||
        !ref.read(areaSettingsProvider).showPresence) {
      return;
    }
    // The first one at once, so the count is there when the screen opens;
    // then a fresh 60 ± 20 s each time, so the beacons keep no rhythm.
    unawaited(_sendPresence(id));
    void next() {
      final delay = presenceBase +
          Duration(
            seconds: _random.nextInt(2 * presenceJitterSeconds + 1) -
                presenceJitterSeconds,
          );
      _presenceTimer = Timer(delay, () {
        if (_presenceRoom != id || !_running) return;
        unawaited(_sendPresence(id));
        next();
      });
    }

    next();
  }

  Future<void> _sendPresence(AreaRoomId id) async {
    final place = state.place;
    final link = _link;
    final level = id.level;
    if (place == null ||
        link == null ||
        !link.connected ||
        level == null ||
        !level.coarse ||
        _presenceRoom != id ||
        !ref.read(areaSettingsProvider).showPresence) {
      return;
    }
    try {
      final identity = await _keyring.identityFor(level, place.cellOf(level));
      _identities[level] = identity;
      final signed = await _finish(
        areaPresenceEvent(
          pubkey: identity.pubkey,
          g: place.cellOf(level),
          now: _clock(),
        ),
        identity.signer,
      );
      await link.publish(signed);
    } catch (e) {
      DebugLog.instance.log('AREA', 'presence not sent: $e');
    }
  }

  // ------------------------------------------------------------ moderation

  /// "Hide": this message, on this phone.
  void hidePost(String id) {
    _hiddenPosts.add(id);
    _bump();
  }

  /// "Block": everything by this key, until its name changes — at most six
  /// hours, and the screen says so.
  Future<void> blockAuthor(String pubkey) async {
    _hiddenAuthors[pubkey] = _clock().millisecondsSinceEpoch;
    for (final r in _rooms.values) {
      r.dropAuthor(pubkey);
    }
    _bump();
    await _saveHidden();
  }

  /// "Report": sent with a key of its own, then the author is blocked here
  /// at once, whatever the server says.
  Future<bool> report(
    AreaPost post,
    String g, {
    required ReportReason reason,
    String? note,
  }) async {
    final sent = await ref.read(areaReporterProvider).send(
          reason: reason,
          note: note,
          authorKey: post.pubkey,
          eventId: post.id,
          geohash: g,
          text: post.text,
          sentAtSeconds: post.createdAt,
        );
    await blockAuthor(post.pubkey);
    return sent;
  }

  /// The `g` a room's events carry — what a report names.
  String? geohashOf(AreaRoomId id) {
    if (id.readOnly) return id.foreignCell;
    final place = state.place;
    if (place == null) return null;
    return id.level == AreaLevel.district ? place.city : place.cellOf(id.level!);
  }

  Future<void> _refreshBans() async {
    final body = await ref.read(areaBanFetcherProvider)();
    if (body == null) return;
    final list = await verifyAreaBanList(body);
    if (list == null || list.updatedAt < _bans.updatedAt) return;
    _bans = list;
    for (final r in _rooms.values) {
      list.keys.forEach(r.dropAuthor);
      list.events.forEach(r.dropEvent);
    }
    _bump();
  }

  // ------------------------------------------------------------------ disk

  Future<void> _loadDisk() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final now = _clock().millisecondsSinceEpoch;
      final notes = await _kv.get(AreaKeys.notes);
      if (notes is List) {
        _ownNotes
          ..clear()
          ..addAll([
            for (final raw in notes)
              if (_OwnNote.fromJson(raw) case final n?)
                if (n.expiration * 1000 > now) n,
          ]);
      }
      final hidden = await _kv.get(AreaKeys.hidden);
      if (hidden is Map) {
        for (final e in hidden.entries) {
          if (e.key is String &&
              e.value is int &&
              now - (e.value as int) < hiddenFor.inMilliseconds) {
            _hiddenAuthors[e.key as String] = e.value as int;
          }
        }
      }
    } catch (e) {
      DebugLog.instance.log('AREA', 'could not read own notes: $e');
    }
  }

  Future<void> _saveOwnNotes() async {
    try {
      await _kv.put(
        AreaKeys.notes,
        [for (final n in _ownNotes) n.toJson()],
      );
    } catch (_) {}
  }

  Future<void> _saveHidden() async {
    try {
      await _kv.put(AreaKeys.hidden, Map<String, int>.of(_hiddenAuthors));
    } catch (_) {}
  }

  /// The emergency wipe: the socket shut, the rooms forgotten, the keys and
  /// the own notes erased, the switch off.
  Future<void> wipe() async {
    _stop();
    _holders = 0;
    _rooms.clear();
    _identities.clear();
    _hiddenPosts.clear();
    _hiddenAuthors.clear();
    _ownNotes.clear();
    _limits.clear();
    _tracker.reset();
    _bans = const AreaBanList();
    _loaded = false;
    state = const AreaState();
    await _keyring.wipe();
    for (final key in AreaKeys.all) {
      try {
        await _kv.delete(key);
      } catch (_) {}
    }
    await ref.read(areaSettingsProvider.notifier).wipe();
  }

  // ----------------------------------------------------------------- misc

  int _nowSeconds() => _clock().millisecondsSinceEpoch ~/ 1000;

  void _bump() => state = state.copyWith(bump: true);

  static Uint8List _seed() {
    final rand = Random.secure();
    return Uint8List.fromList(List.generate(32, (_) => rand.nextInt(256)));
  }
}

final areaControllerProvider =
    NotifierProvider<AreaController, AreaState>(AreaController.new);
