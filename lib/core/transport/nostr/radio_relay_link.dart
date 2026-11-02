import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../util/cost_meter.dart';
import '../../util/debug_log.dart';
import 'nostr_event.dart';
import 'nostr_relay_protocol.dart';
import 'nostr_signer.dart';
import 'nostr_transport.dart';

/// The walkie-talkie's event kind on our relay (2026-11-02).
///
/// Ephemeral (NIP-01 20000–29999): strfry hands it to whoever is subscribed at
/// that moment and stores nothing — `rejectEphemeralEventsOlderThanSeconds =
/// 60` in `relay/deploy/strfry.conf` — which is the radio's "never kept"
/// promise said by the relay itself.
///
/// Not 21059 any more: the NIP list registered that as "Ephemeral Gift Wrap"
/// (NIP-59), whose content is a sealed rumor, not our `cr1:` batch, so a
/// foreign client on a relay carrying both could take a voice batch for a
/// gift wrap. 23517 is in no NIP text (checked against nostr-protocol/nips at
/// 400d157, 2026-10-27), and is no round number or `…059` a neighbour would
/// reach for next.
const int kRadioEventKind = 23517;

/// The radio's kind in build 1182, the only build that put voice on the relay
/// before [kRadioEventKind]; it listens on nothing else.
///
/// **Sent and heard alongside the new kind until the first build cut on or
/// after 2027-01-01**, which drops it from both [kRadioSendKinds] and
/// [kRadioListenKinds]. Sending it keeps a 1182 phone hearing a newer one;
/// hearing it keeps a newer phone hearing a 1182 one. Two months, because 1182
/// is a tester build of 2026-10-31 and the radio's relay lane two days old
/// when this changed; the cost meanwhile is a second signature per batch (~1
/// a second per talker, `nostr-sign` in [CostMeter]) and a second event,
/// ~130 a minute against the relay's 3000 per address. After that build ships,
/// `relay/write-policy.mjs` may refuse it — a refused copy nobody listens to
/// costs nothing but a log line.
const int kLegacyRadioEventKind = 21059;

/// Kinds each batch is published under, the new one first: the same content
/// signed once per kind, since the kind is part of the event id.
const List<int> kRadioSendKinds = [kRadioEventKind, kLegacyRadioEventKind];

/// Kinds the subscription asks for. A newer sender's batch arrives once per
/// kind; [RadioRelayLink] drops the second copy.
const List<int> kRadioListenKinds = [kRadioEventKind, kLegacyRadioEventKind];

/// Tag carrying the radio tag in hex: a group's fixed one, or a pair's that
/// turns over with the hourly peer-id epoch (`RadioCrypto.derivePairTag`).
///
/// In place of [kRecipientTag] on purpose: there is no `p`, so the relay is
/// never told whose voice goes to whom — only that a label it cannot read
/// back to anybody is talking. A letter no NIP gives a meaning to, and none
/// this app uses elsewhere.
const String kRadioTagName = 'y';

/// Several radio frames in one event's content: `cr1:` + base64url of
/// `[count:1]([len:2 BE][frame])*`.
///
/// Several, because each event is one BIP-340 signature on the UI isolate
/// (`nostr-sign` in [CostMeter]) and a 300 ms chunk a signature would be three
/// a second per talker; the spec asked for internet pieces "крупнее (ориентир
/// 1 с)". [RadioRelayLink.maxBatch] chunks make ~0.9 s.
class RadioRelayCodec {
  RadioRelayCodec._();

  static const String scheme = 'cr1:';

  /// Bounds on what is ever read back. Generous next to what is sent (three
  /// frames of well under 1 KiB) and small next to what a hostile relay could
  /// hand us.
  static const int maxFrames = 8;
  static const int maxBytes = 16 * 1024;

  static String encode(List<Uint8List> frames) {
    if (frames.isEmpty || frames.length > maxFrames) {
      throw ArgumentError.value(frames.length, 'frames', 'must be 1..$maxFrames');
    }
    final out = BytesBuilder(copy: false)..addByte(frames.length);
    for (final f in frames) {
      if (f.isEmpty || f.length > 0xFFFF) {
        throw ArgumentError.value(f.length, 'frame length');
      }
      out
        ..addByte(f.length >> 8)
        ..addByte(f.length & 0xFF)
        ..add(f);
    }
    final bytes = out.takeBytes();
    if (bytes.length > maxBytes) {
      throw ArgumentError.value(bytes.length, 'batch', 'over $maxBytes bytes');
    }
    return '$scheme${base64Url.encode(bytes).replaceAll('=', '')}';
  }

  /// The frames in [content]. Throws [FormatException] on anything that is
  /// not exactly what [encode] writes — a relay is untrusted.
  static List<Uint8List> decode(String content) {
    if (!content.startsWith(scheme)) {
      throw const FormatException('not a radio batch');
    }
    final body = content.substring(scheme.length);
    if (body.length > (maxBytes * 4 + 2) ~/ 3) {
      throw const FormatException('radio batch too large');
    }
    final Uint8List bytes;
    try {
      bytes = base64Url.decode(base64Url.normalize(body));
    } on FormatException {
      throw const FormatException('radio batch is not base64url');
    }
    if (bytes.isEmpty) throw const FormatException('empty radio batch');
    final count = bytes[0];
    if (count == 0 || count > maxFrames) {
      throw FormatException('radio batch counts $count frames');
    }
    final frames = <Uint8List>[];
    var at = 1;
    for (var i = 0; i < count; i++) {
      if (at + 2 > bytes.length) throw const FormatException('cut length');
      final len = (bytes[at] << 8) | bytes[at + 1];
      at += 2;
      if (len == 0 || at + len > bytes.length) {
        throw const FormatException('cut frame');
      }
      frames.add(Uint8List.sublistView(bytes, at, at + len));
      at += len;
    }
    if (at != bytes.length) throw const FormatException('trailing bytes');
    return frames;
  }
}

/// One socket to our relay for the walkie-talkie, open only while the radio is
/// tuned to something — see `radioInternetProvider`.
///
/// Not the [NostrRelayClient] pool. That pool has one subscription, on `#p`,
/// with watermarks, AUTH, lanes and a backlog to replay; the radio needs none
/// of it — a chunk older than a second is silence, not mail — and putting a
/// second kind of subscription into it would touch every message to carry a
/// voice. Only our relay, not the public ones: they need not take an
/// ephemeral kind, and voice gains nothing from another stranger watching.
///
/// **Signed with a throwaway key**, made fresh on each connect. The frames
/// inside are already sealed and Ed25519-signed by the speaker
/// (`RadioCrypto`, `_radioSignedContext`); a Nostr signature under the
/// speaker's stable npub would only tell the relay operator who was talking.
/// For the same reason inbound Nostr signatures are not verified: proving that
/// an anonymous key signed an event proves nothing the inner signature does
/// not, and it would be a Schnorr verify per event per talker.
class RadioRelayLink {
  RadioRelayLink({
    required Uri url,
    required void Function(Uint8List frame) onFrame,
    WebSocketChannel Function(Uri)? connect,
    Future<NostrEventSigner> Function()? newSigner,
    DateTime Function()? clock,
  })  : _url = url,
        _onFrame = onFrame,
        _connect = connect ?? WebSocketChannel.connect,
        _newSigner = newSigner ?? _throwawaySigner,
        _clock = clock ?? DateTime.now;

  final Uri _url;
  final void Function(Uint8List frame) _onFrame;
  final WebSocketChannel Function(Uri) _connect;
  final Future<NostrEventSigner> Function() _newSigner;
  final DateTime Function() _clock;

  /// Chunks per event: 3 x 300 ms. More is a longer wait before the first
  /// word is heard; fewer is more signatures.
  static const int maxBatch = 3;

  /// Longest a chunk waits for company. A press's last chunk, or a press
  /// shorter than [maxBatch] chunks, goes after this — under one chunk's
  /// worth past the wait a full batch would have had anyway.
  static const Duration batchWait = Duration(milliseconds: 650);

  static const Duration _initialBackoff = Duration(seconds: 2);
  static const Duration _maxBackoff = Duration(seconds: 30);

  /// How long nothing is sent or heard before the counts go in the log: one
  /// line per transmission, not one per event.
  static const Duration _quietBeforeLog = Duration(seconds: 2);

  static const String _subId = 'radio';

  /// Event contents remembered to drop a twin. A batch sent under every kind
  /// in [kRadioSendKinds] reaches us as byte-identical content under two ids,
  /// a few milliseconds apart; eight events is several seconds of every
  /// talker on a channel. (origin, msgId) dedup further on would catch the
  /// frames too — this keeps the twin out of the decode and out of the counts.
  static const int _recentContents = 8;

  Set<String> _tags = const {};
  final Set<String> _heardContents = <String>{};
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _sub;
  NostrEventSigner? _signer;
  bool _open = false;
  bool _disposed = false;
  Timer? _retry;
  Duration _backoff = _initialBackoff;

  final Map<String, List<Uint8List>> _pending = {};
  final Map<String, Timer> _flushAt = {};

  int _sentEvents = 0;
  int _sentChunks = 0;
  int _heardChunks = 0;
  int _refused = 0;
  Timer? _logTimer;

  /// The socket is up and our REQ has gone out on it. A chunk published while
  /// this is false is dropped: voice that waits for a reconnect is late.
  bool get connected => _open;

  /// The tags currently listened to, for tests and the log.
  Set<String> get tags => _tags;

  /// Listen to exactly [tagHexes]. Empty closes the socket; anything else
  /// opens it if it is not open and replaces the subscription if it is.
  void setTags(Set<String> tagHexes) {
    if (_disposed) return;
    final next = Set<String>.unmodifiable(tagHexes);
    if (next.length == _tags.length && next.containsAll(_tags)) return;
    _tags = next;
    if (next.isEmpty) {
      _close('nothing tuned');
      return;
    }
    if (_open) {
      _sendReq();
    } else if (_channel == null && _retry == null) {
      unawaited(_dial());
    }
  }

  /// Queue [frame] — a radio `transport` frame as it went out on Bluetooth —
  /// for [tagHex]. Returns whether it will go out: false while the socket is
  /// down, or for a tag this link is not tuned to.
  bool publish(String tagHex, Uint8List frame) {
    if (_disposed || !_open || !_tags.contains(tagHex)) return false;
    final batch = _pending.putIfAbsent(tagHex, () => <Uint8List>[])..add(frame);
    if (batch.length >= maxBatch) {
      unawaited(_flush(tagHex));
    } else {
      _flushAt[tagHex] ??= Timer(batchWait, () => unawaited(_flush(tagHex)));
    }
    return true;
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _close('disposed');
    _logTimer?.cancel();
  }

  // ---------------------------------------------------------------- internals

  static Future<NostrEventSigner> _throwawaySigner() {
    final rand = Random.secure();
    final seed = Uint8List.fromList(List.generate(32, (_) => rand.nextInt(256)));
    return Secp256k1NostrSigner.deriveFromSeed(seed);
  }

  Future<void> _dial() async {
    if (_disposed || _tags.isEmpty || _channel != null) return;
    final WebSocketChannel channel;
    try {
      channel = _connect(_url);
      _channel = channel;
      _signer = await _newSigner();
      await channel.ready;
    } catch (e) {
      _channel = null;
      _scheduleRetry('connect failed: $e');
      return;
    }
    if (_disposed || !identical(channel, _channel) || _tags.isEmpty) {
      unawaited(channel.sink.close());
      if (identical(channel, _channel)) _channel = null;
      return;
    }
    _sub = channel.stream.listen(
      (dynamic raw) {
        if (raw is String) _onMessage(raw);
      },
      onError: (Object e) => _onDown(channel, 'socket error: $e'),
      onDone: () => _onDown(channel, 'closed by relay'),
    );
    _open = true;
    _backoff = _initialBackoff;
    _sendReq();
    DebugLog.instance.log(
      'RADIO',
      'internet: listening on ${_tags.length} tag(s) at ${_url.host}',
    );
  }

  void _sendReq() {
    final ch = _channel;
    if (ch == null) return;
    // `since` now: a relay that kept an ephemeral event for a late subscriber
    // would be handing over voice somebody already stopped saying.
    final since = _clock().millisecondsSinceEpoch ~/ 1000;
    _write(
      jsonEncode([
        'REQ',
        _subId,
        {
          'kinds': kRadioListenKinds,
          '#$kRadioTagName': _tags.toList(),
          'since': since,
        },
      ]),
    );
  }

  void _onMessage(String raw) {
    final msg = NostrRelayProtocol.parse(raw);
    switch (msg) {
      case RelayEvent(:final subscriptionId, :final event):
        if (subscriptionId != _subId ||
            !kRadioListenKinds.contains(event.kind)) {
          return;
        }
        // Our own voice, sent back to us because we listen on the tag we talk
        // on. Dropped later by origin anyway; this saves the decrypt.
        if (event.pubkey == _signer?.npubHex) return;
        final tag = event.firstTagValue(kRadioTagName);
        if (tag == null || !_tags.contains(tag)) return;
        final List<Uint8List> frames;
        try {
          frames = RadioRelayCodec.decode(event.content);
        } on FormatException {
          return;
        }
        if (!_heardContents.add(event.content)) return;
        if (_heardContents.length > _recentContents) {
          _heardContents.remove(_heardContents.first);
        }
        _heardChunks += frames.length;
        _noteActivity();
        frames.forEach(_onFrame);
      case RelayOk(:final accepted, :final message):
        if (!accepted) {
          _refused++;
          _noteActivity();
          if (_refused == 1) {
            DebugLog.instance.log('RADIO', 'internet: relay refused: $message');
          }
        }
      case RelayClosed(:final subscriptionId, :final message):
        if (subscriptionId == _subId) {
          DebugLog.instance.log('RADIO', 'internet: subscription closed: $message');
        }
      default:
        break;
    }
  }

  Future<void> _flush(String tagHex) async {
    _flushAt.remove(tagHex)?.cancel();
    final frames = _pending.remove(tagHex);
    final signer = _signer;
    if (frames == null || frames.isEmpty || signer == null || !_open) return;
    try {
      final content = RadioRelayCodec.encode(frames);
      final createdAt = _clock().millisecondsSinceEpoch ~/ 1000;
      var sent = 0;
      for (final kind in kRadioSendKinds) {
        final event = NostrEvent(
          pubkey: signer.npubHex,
          createdAt: createdAt,
          kind: kind,
          tags: [
            [kRadioTagName, tagHex],
          ],
          content: content,
        );
        final signed = await CostMeter.instance.measure(
          'nostr-sign',
          () => signer.sign(event),
        );
        if (!_open) break;
        if (_write(NostrRelayProtocol.event(signed))) sent++;
      }
      if (sent > 0) {
        _sentEvents += sent;
        _sentChunks += frames.length;
        _noteActivity();
      }
    } catch (e) {
      DebugLog.instance.log('RADIO', 'internet: could not send: $e');
    }
  }

  bool _write(String payload) {
    final ch = _channel;
    if (ch == null) return false;
    try {
      ch.sink.add(payload);
      return true;
    } catch (e) {
      _onDown(ch, 'write failed: $e');
      return false;
    }
  }

  void _onDown(WebSocketChannel channel, String why) {
    if (!identical(channel, _channel)) return;
    _teardown();
    _scheduleRetry(why);
  }

  void _scheduleRetry(String why) {
    if (_disposed || _tags.isEmpty || _retry != null) return;
    DebugLog.instance.log(
      'RADIO',
      'internet: $why; again in ${_backoff.inSeconds} s',
    );
    _retry = Timer(_backoff, () {
      _retry = null;
      unawaited(_dial());
    });
    final doubled = _backoff * 2;
    _backoff = doubled > _maxBackoff ? _maxBackoff : doubled;
  }

  void _close(String why) {
    final wasOpen = _open || _channel != null;
    _retry?.cancel();
    _retry = null;
    _backoff = _initialBackoff;
    _teardown();
    if (wasOpen) DebugLog.instance.log('RADIO', 'internet: closed ($why)');
  }

  void _teardown() {
    _open = false;
    for (final t in _flushAt.values) {
      t.cancel();
    }
    _flushAt.clear();
    _pending.clear();
    unawaited(_sub?.cancel());
    _sub = null;
    final ch = _channel;
    _channel = null;
    _signer = null;
    if (ch != null) unawaited(ch.sink.close().catchError((Object _) {}));
  }

  void _noteActivity() {
    _logTimer?.cancel();
    _logTimer = Timer(_quietBeforeLog, _logCounts);
  }

  void _logCounts() {
    if (_sentChunks > 0) {
      DebugLog.instance.log(
        'RADIO',
        'internet: sent $_sentChunks chunk(s) in $_sentEvents event(s)'
            '${_refused > 0 ? ', $_refused refused' : ''}',
      );
    }
    if (_heardChunks > 0) {
      DebugLog.instance.log('RADIO', 'internet: heard $_heardChunks chunk(s)');
    }
    _sentEvents = 0;
    _sentChunks = 0;
    _heardChunks = 0;
    _refused = 0;
  }
}
