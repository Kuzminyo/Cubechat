import 'dart:convert';

import 'package:cryptography/dart.dart';

import '../../../core/crypto/signature_worker.dart';
import '../../../core/transport/nostr/nostr_event.dart';
import '../../../core/transport/nostr/nostr_pow.dart';
import 'geohash.dart';

/// The area chat's Nostr kinds — on `wss://relay.cubechat.tech/area` only,
/// never in the `NostrRelayClient` pool, whose `verifyInboundEvent` keeps
/// letting nothing but 1059 through.
///
/// Next to 1059/21059 so a reader of `relay/area-policy.mjs` sees they are
/// ours; none of the three is in the NIP list (checked 2026-11-02).
const int kAreaMessageKind = 1060;
const int kAreaNoteKind = 1062;
const int kAreaPresenceKind = 21060;

/// NIP-09: a note's own key asks for it to go before its time.
const int kAreaDeletionKind = 5;

/// Proof of work, NIP-13, by kind.
///
/// Starting numbers from the spec, scaled off the 2026-09-29 measurement of
/// 16 bits at ~770 ms on a PC (`cube_id_events.dart`). On 2026-11-02 the
/// Mac this was written on mined a message-sized event at 8 / 12 / 16 bits in
/// 1.6 / 10.8 / 163 ms on average (`mineNonce`, 20 runs each, one core, JIT
/// under `flutter test`). **Measure on a
/// phone before release** (spec, stage 0) and put the numbers here: a phone
/// is several times slower, and 16 bits for a note is meant to be felt.
const int kAreaMessagePowBits = 12;
const int kAreaNotePowBits = 16;
const int kAreaPresencePowBits = 8;

/// A report from the area chat costs as much as a note: it pages a person.
const int kAreaReportPowBits = 16;

const Duration kAreaMessageLifetime = Duration(hours: 24);
const Duration kAreaNoteMaxLifetime = Duration(days: 7);

/// The three lifetimes a note may be given.
const List<Duration> kAreaNoteLifetimes = [
  Duration(hours: 1),
  Duration(hours: 24),
  Duration(days: 7),
];

/// A note's `created_at` is rounded down to this, and its expiration counted
/// from the rounded time — otherwise `expiration - lifetime` would give the
/// second back.
const int kAreaNoteTimeBucketSeconds = 600;

const int kAreaMaxEventBytes = 4 * 1024;
const int kAreaMaxTextChars = 500;
const int kAreaMaxNameChars = 24;

/// How far in the future a clock may be before an event is not believed.
const int kAreaMaxFutureSeconds = 5 * 60;

const String kAreaGeohashTag = 'g';

/// The parsed `content` of a message or a note.
///
/// `{"v":1,"name":"…"?,"text":"…","cell":"<district>"?}`. The name is a field
/// of the content and never an `n` tag — bitchat's `["n", nickname]` on every
/// event tied a person together across channels (H8). Absent means "the name
/// the key gives", which the reader works out in its own language: a default
/// name written by the sender would say which language the sender uses.
class AreaContent {
  const AreaContent({required this.text, this.name, this.cell});

  final String text;
  final String? name;
  final String? cell;

  String encode() => jsonEncode(<String, Object>{
        'v': 1,
        if (name != null) 'name': name!,
        'text': text,
        if (cell != null) 'cell': cell!,
      });

  /// Exactly the schema or a [FormatException]: no extra keys, no other
  /// version, nothing empty, nothing long.
  static AreaContent decode(String content) {
    final Object? raw;
    try {
      raw = jsonDecode(content);
    } on FormatException {
      throw const FormatException('area content is not JSON');
    }
    if (raw is! Map<String, dynamic>) {
      throw const FormatException('area content is not an object');
    }
    for (final key in raw.keys) {
      if (!const {'v', 'name', 'text', 'cell'}.contains(key)) {
        throw FormatException('area content has "$key"');
      }
    }
    if (raw['v'] != 1) throw const FormatException('area content version');
    final text = raw['text'];
    if (text is! String ||
        text.trim().isEmpty ||
        text.length > kAreaMaxTextChars) {
      throw const FormatException('area text');
    }
    final name = raw['name'];
    if (name != null &&
        (name is! String ||
            name.trim().isEmpty ||
            name.length > kAreaMaxNameChars)) {
      throw const FormatException('area name');
    }
    final cell = raw['cell'];
    if (cell != null &&
        (cell is! String || !Geohash.isValid(cell, length: 5))) {
      throw const FormatException('area cell');
    }
    return AreaContent(
      text: cleanAreaText(text),
      name: name == null ? null : cleanAreaText(name as String),
      cell: cell as String?,
    );
  }
}

/// [input] without control characters (newline and tab survive), without a
/// lone surrogate, trimmed.
///
/// Not only for looks: an event's id is the hash of its NIP-01 serialisation,
/// which writes such characters raw where Dart's `jsonEncode` escapes them —
/// left in, the relay and the phone would hash different bytes and every
/// such message would be refused.
String cleanAreaText(String input) {
  final out = StringBuffer();
  final units = input.codeUnits;
  for (var i = 0; i < units.length; i++) {
    final c = units[i];
    if (c >= 0xD800 && c <= 0xDBFF) {
      if (i + 1 < units.length &&
          units[i + 1] >= 0xDC00 &&
          units[i + 1] <= 0xDFFF) {
        out
          ..writeCharCode(c)
          ..writeCharCode(units[i + 1]);
        i++;
      }
      continue;
    }
    if (c >= 0xDC00 && c <= 0xDFFF) continue;
    if (c < 0x20 && c != 0x0A && c != 0x09) continue;
    if (c == 0x7F) continue;
    out.writeCharCode(c);
  }
  return out.toString().trim();
}

/// [text] cut to [max] UTF-16 units without splitting a surrogate pair.
String clipAreaText(String text, int max) {
  if (text.length <= max) return text;
  var end = max;
  final last = text.codeUnitAt(end - 1);
  if (last >= 0xD800 && last <= 0xDBFF) end--;
  return text.substring(0, end);
}

// ------------------------------------------------------------- outbound

/// An unsigned chat message, before its nonce.
///
/// [g] is the city (4) or region (3); [cell] the district (5), only for a
/// message typed into the district chat.
NostrEvent areaMessageEvent({
  required String pubkey,
  required String g,
  required String text,
  required DateTime now,
  String? name,
  String? cell,
  String? replyTo,
}) {
  final createdAt = now.millisecondsSinceEpoch ~/ 1000;
  return NostrEvent(
    pubkey: pubkey,
    createdAt: createdAt,
    kind: kAreaMessageKind,
    tags: [
      [kAreaGeohashTag, g],
      ['expiration', '${createdAt + kAreaMessageLifetime.inSeconds}'],
      if (replyTo != null) ['e', replyTo, '', 'reply'],
    ],
    content: AreaContent(text: text, name: name, cell: cell).encode(),
  );
}

/// An unsigned note, before its nonce.
///
/// [cell] is whatever district its author pinned by hand on the map, or
/// nothing — never one taken from a fix (spec, rule 2).
NostrEvent areaNoteEvent({
  required String pubkey,
  required String g,
  required String text,
  required DateTime now,
  required Duration lifetime,
  String? cell,
}) {
  if (!kAreaNoteLifetimes.contains(lifetime)) {
    throw ArgumentError.value(lifetime, 'lifetime');
  }
  final seconds = now.millisecondsSinceEpoch ~/ 1000;
  final createdAt = seconds - seconds % kAreaNoteTimeBucketSeconds;
  return NostrEvent(
    pubkey: pubkey,
    createdAt: createdAt,
    kind: kAreaNoteKind,
    tags: [
      [kAreaGeohashTag, g],
      ['expiration', '${createdAt + lifetime.inSeconds}'],
    ],
    content: AreaContent(text: text, cell: cell).encode(),
  );
}

/// An unsigned presence beacon: `g`, then the nonce, and nothing else.
NostrEvent areaPresenceEvent({
  required String pubkey,
  required String g,
  required DateTime now,
}) =>
    NostrEvent(
      pubkey: pubkey,
      createdAt: now.millisecondsSinceEpoch ~/ 1000,
      kind: kAreaPresenceKind,
      tags: [
        [kAreaGeohashTag, g],
      ],
      content: '',
    );

/// NIP-09: "delete my note [noteId]", signed by the note's own key.
NostrEvent areaDeletionEvent({
  required String pubkey,
  required String noteId,
  required DateTime now,
}) =>
    NostrEvent(
      pubkey: pubkey,
      createdAt: now.millisecondsSinceEpoch ~/ 1000,
      kind: kAreaDeletionKind,
      tags: [
        ['e', noteId],
        ['k', '$kAreaNoteKind'],
      ],
      content: '',
    );

/// The proof of work [kind] asks for; 0 for a deletion.
int areaPowBits(int kind) => switch (kind) {
      kAreaMessageKind => kAreaMessagePowBits,
      kAreaNoteKind => kAreaNotePowBits,
      kAreaPresenceKind => kAreaPresencePowBits,
      _ => 0,
    };

/// Thrown when something about to leave the phone is finer than the spec
/// allows. A bug, not a user error: it is never caught to send anyway.
class AreaCeilingError extends Error {
  AreaCeilingError(this.message);
  final String message;

  @override
  String toString() => 'AreaCeilingError: $message';
}

/// The three rules every outgoing event is held to (spec, «Уровни»):
///
/// 1. the `g` tag is never finer than a city — four characters;
/// 2. a district (five) only inside the content of a message or a note;
/// 3. nothing finer than a district at all.
///
/// Checked on the finished event, after the nonce, right before it is
/// signed — so no path that builds an event can get around it.
void checkAreaCeilings(NostrEvent event) {
  switch (event.kind) {
    case kAreaMessageKind || kAreaNoteKind || kAreaPresenceKind:
      final gs = [
        for (final t in event.tags)
          if (t.isNotEmpty && t[0] == kAreaGeohashTag) t,
      ];
      if (gs.length != 1 || gs.first.length != 2) {
        throw AreaCeilingError('exactly one g tag');
      }
      final g = gs.first[1];
      if (!Geohash.isValid(g) || g.length < 3 || g.length > 4) {
        throw AreaCeilingError('g "$g" is not a city or a region');
      }
      for (final t in event.tags) {
        if (t.isEmpty) throw AreaCeilingError('empty tag');
        if (!const {'g', 'expiration', 'nonce', 'e'}.contains(t[0])) {
          throw AreaCeilingError('tag "${t[0]}" never leaves the phone');
        }
      }
      if (event.kind == kAreaPresenceKind) {
        if (event.content.isNotEmpty) {
          throw AreaCeilingError('presence carries nothing');
        }
        return;
      }
      final AreaContent content;
      try {
        content = AreaContent.decode(event.content);
      } on FormatException catch (e) {
        throw AreaCeilingError('content off the schema: ${e.message}');
      }
      final cell = content.cell;
      if (cell != null && (cell.length != 5 || !cell.startsWith(g))) {
        throw AreaCeilingError('cell "$cell" is not a district of "$g"');
      }
    case kAreaDeletionKind:
      if (event.tags.any((t) => t.isNotEmpty && t[0] == kAreaGeohashTag) ||
          event.content.isNotEmpty) {
        throw AreaCeilingError('a deletion names no place');
      }
    default:
      throw AreaCeilingError('kind ${event.kind} is not the area chat');
  }
}

/// How many of each the subscription asks the relay for.
const int kAreaReqLimit = 200;
const int kAreaNoteReqLimit = 100;

/// The REQ filters for [cells]: messages and presence of the last day, notes
/// of the last week. Every cell is a city or a region — the subscription is
/// seen by the relay even when nobody writes, so rule 1 holds here as it does
/// for `g` (spec, «Уровни»).
List<Map<String, Object>> areaSubscriptionFilters(
  Set<String> cells, {
  required int nowSeconds,
}) {
  if (cells.isEmpty) return const [];
  for (final c in cells) {
    if (!Geohash.isValid(c) || c.length < 3 || c.length > 4) {
      throw AreaCeilingError('subscription to "$c"');
    }
  }
  final g = cells.toList()..sort();
  return [
    {
      'kinds': [kAreaMessageKind, kAreaPresenceKind],
      '#$kAreaGeohashTag': g,
      'since': nowSeconds - kAreaMessageLifetime.inSeconds,
      'limit': kAreaReqLimit,
    },
    {
      'kinds': [kAreaNoteKind],
      '#$kAreaGeohashTag': g,
      'since': nowSeconds - kAreaNoteMaxLifetime.inSeconds,
      'limit': kAreaNoteReqLimit,
    },
  ];
}

// -------------------------------------------------------------- inbound

/// An event from the area relay that has passed every step of
/// [verifyAreaEvent].
class AreaInbound {
  const AreaInbound({
    required this.id,
    required this.pubkey,
    required this.kind,
    required this.g,
    required this.createdAt,
    this.expiration,
    this.content,
    this.replyTo,
  });

  final String id;
  final String pubkey;
  final int kind;
  final String g;

  /// Unix seconds.
  final int createdAt;
  final int? expiration;

  /// Null for presence.
  final AreaContent? content;
  final String? replyTo;
}

/// Why [verifyAreaEvent] refused, by the step that refused it — for tests and
/// the log, never shown.
enum AreaRefusal { kindOrSize, id, pow, schema, signature }

/// Checks an id and a BIP-340 signature; [SignatureWorker] in the app.
typedef AreaSignatureCheck = Future<bool> Function(NostrEvent event);

Future<bool> _workerCheck(NostrEvent event) =>
    SignatureWorker.instance.verifyEvent(
      serialized: event.serializeForId(),
      idHex: event.id!,
      pubkeyHex: event.pubkey,
      sigHex: event.sig!,
    );

final RegExp _hex64 = RegExp(r'^[0-9a-f]{64}$');
final RegExp _hex128 = RegExp(r'^[0-9a-f]{128}$');

/// Every inbound area event, before it reaches anything in memory.
///
/// Cheapest first, so a relay — ours, which is still not trusted — cannot
/// make the phone do a Schnorr verify for rubbish:
///
/// 1. one of our three kinds, and at most [kAreaMaxEventBytes];
/// 2. the id really is the SHA-256 of the fields;
/// 3. the id carries the kind's proof of work;
/// 4. tags and content exactly to the schema, times within bounds;
/// 5. the BIP-340 signature, off the UI isolate.
///
/// Returns the event or the step that refused it. bitchat had a signature
/// check and never called it for these kinds (H5): a relay could put words in
/// anyone's mouth.
Future<(AreaInbound?, AreaRefusal?)> verifyAreaEvent(
  NostrEvent event, {
  required int nowSeconds,
  AreaSignatureCheck? signature,
}) async {
  // 1.
  if (event.kind != kAreaMessageKind &&
      event.kind != kAreaNoteKind &&
      event.kind != kAreaPresenceKind) {
    return (null, AreaRefusal.kindOrSize);
  }
  if (utf8.encode(jsonEncode(event.toJson())).length > kAreaMaxEventBytes) {
    return (null, AreaRefusal.kindOrSize);
  }
  // 2.
  final id = event.id;
  final sig = event.sig;
  if (id == null ||
      sig == null ||
      !_hex64.hasMatch(id) ||
      !_hex128.hasMatch(sig) ||
      !_hex64.hasMatch(event.pubkey)) {
    return (null, AreaRefusal.id);
  }
  const sha = DartSha256();
  final digest = sha.hashSync(utf8.encode(event.serializeForId())).bytes;
  if (_hexOf(digest) != id) return (null, AreaRefusal.id);
  // 3.
  if (leadingZeroBits(digest) < areaPowBits(event.kind)) {
    return (null, AreaRefusal.pow);
  }
  // 4.
  final parsed = _parseShape(event, nowSeconds);
  if (parsed == null) return (null, AreaRefusal.schema);
  // 5.
  final ok = await (signature ?? _workerCheck)(event);
  if (!ok) return (null, AreaRefusal.signature);
  return (parsed, null);
}

AreaInbound? _parseShape(NostrEvent event, int now) {
  String? g;
  int? expiration;
  String? replyTo;
  var nonces = 0;
  for (final t in event.tags) {
    if (t.isEmpty) return null;
    switch (t[0]) {
      case kAreaGeohashTag:
        if (g != null || t.length != 2) return null;
        g = t[1];
      case 'expiration':
        if (expiration != null || t.length != 2) return null;
        expiration = int.tryParse(t[1]);
        if (expiration == null) return null;
      case 'nonce':
        if (++nonces > 1) return null;
      case 'e':
        if (replyTo != null ||
            event.kind != kAreaMessageKind ||
            t.length < 2 ||
            !_hex64.hasMatch(t[1])) {
          return null;
        }
        replyTo = t[1];
      default:
        // An `n` tag, a `p` tag, anything else: not something we send, and
        // a tag that ties people together is the thing this chat avoids.
        return null;
    }
  }
  if (g == null || !Geohash.isValid(g) || g.length < 3 || g.length > 4) {
    return null;
  }

  final maxAge = event.kind == kAreaNoteKind
      ? kAreaNoteMaxLifetime.inSeconds
      : kAreaMessageLifetime.inSeconds;
  if (event.createdAt < now - maxAge ||
      event.createdAt > now + kAreaMaxFutureSeconds) {
    return null;
  }

  if (event.kind == kAreaPresenceKind) {
    if (event.content.isNotEmpty || expiration != null) return null;
    return AreaInbound(
      id: event.id!,
      pubkey: event.pubkey,
      kind: event.kind,
      g: g,
      createdAt: event.createdAt,
    );
  }

  if (expiration == null ||
      expiration <= now ||
      expiration > event.createdAt + maxAge) {
    return null;
  }
  final AreaContent content;
  try {
    content = AreaContent.decode(event.content);
  } on FormatException {
    return null;
  }
  final cell = content.cell;
  if (cell != null && !cell.startsWith(g)) return null;
  return AreaInbound(
    id: event.id!,
    pubkey: event.pubkey,
    kind: event.kind,
    g: g,
    createdAt: event.createdAt,
    expiration: expiration,
    content: content,
    replyTo: replyTo,
  );
}

String _hexOf(List<int> bytes) {
  final out = StringBuffer();
  for (final b in bytes) {
    out.write(b.toRadixString(16).padLeft(2, '0'));
  }
  return out.toString();
}

/// The name a key goes by when its author set none: four hex characters of
/// the key, so it changes with the key (spec, «Имя»). The word in front is
/// the reader's — see [AreaContent].
String areaKeyTag(String pubkeyHex) =>
    pubkeyHex.substring(0, 4).toUpperCase();
