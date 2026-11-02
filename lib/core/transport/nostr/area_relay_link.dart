import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../util/debug_log.dart';
import 'nostr_event.dart';
import 'nostr_relay_protocol.dart';

/// The area chat's relay: a strfry of its own behind `/area`, with its own
/// database, limits and retention, so a flood of the public chat cannot take
/// the private lane down (spec, «Наш релей, и только он»).
///
/// Built into the app and not editable, unlike the relay list for private
/// messages: one relay for every place, so the choice of relay says nothing
/// about the place — and no catalogue to be swapped under us (bitchat's M9).
final Uri kAreaRelayUrl = Uri.parse('wss://relay.cubechat.tech/area');

/// What became of one publish.
enum AreaPublishOutcome { accepted, refused, offline }

/// One socket to [kAreaRelayUrl], open only while somebody has "Nearby" or an
/// area chat on screen.
///
/// Its own socket, like the walkie-talkie's [RadioRelayLink], not the
/// [NostrRelayClient] pool: the pool's one `#p` subscription carries
/// watermarks, AUTH and a queue for private mail, and the public chat must
/// not touch any of it.
///
/// A dumb pipe on purpose: it writes the filters it is given and hands every
/// event up raw. What may be asked for, and whether an event is believed, is
/// decided above it (`areaSubscriptionFilters`, `verifyAreaEvent`), in code
/// that has tests for both.
class AreaRelayLink {
  AreaRelayLink({
    required void Function(NostrEvent event) onEvent,
    Uri? url,
    WebSocketChannel Function(Uri)? connect,
    void Function(bool connected)? onConnection,
  })  : _url = url ?? kAreaRelayUrl,
        _onEvent = onEvent,
        _connect = connect ?? WebSocketChannel.connect,
        _onConnection = onConnection;

  final Uri _url;
  final void Function(NostrEvent event) _onEvent;
  final WebSocketChannel Function(Uri) _connect;
  final void Function(bool connected)? _onConnection;

  /// A frame larger than this ends the socket. Twenty times the largest event
  /// the policy lets in — anything near it is not our relay talking.
  static const int maxFrameChars = 64 * 1024;

  /// How long a publish waits for the relay's `OK`.
  static const Duration okTimeout = Duration(seconds: 10);

  static const Duration _initialBackoff = Duration(seconds: 2);
  static const Duration _maxBackoff = Duration(seconds: 60);
  static const String _subId = 'area';

  /// Event ids already handed up, so a reconnect's backlog is not handed up
  /// twice. Bounded: the subscription asks for a few hundred at most.
  static const int _rememberIds = 2000;

  List<Map<String, Object>> _filters = const [];
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _sub;
  bool _open = false;
  bool _disposed = false;
  Timer? _retry;
  Duration _backoff = _initialBackoff;
  final Set<String> _seenIds = <String>{};
  final Map<String, Completer<AreaPublishOutcome>> _waiting = {};

  bool get connected => _open;

  /// Ask for exactly [filters]. Empty closes the socket.
  void setFilters(List<Map<String, Object>> filters) {
    if (_disposed) return;
    final next = List<Map<String, Object>>.unmodifiable(filters);
    if (jsonEncode(next) == jsonEncode(_filters)) return;
    _filters = next;
    if (next.isEmpty) {
      _close('nothing to read');
      return;
    }
    if (_open) {
      _sendReq();
    } else if (_channel == null && _retry == null) {
      unawaited(_dial());
    }
  }

  /// Send one signed event and wait for the relay's answer.
  Future<AreaPublishOutcome> publish(NostrEvent signed) {
    final id = signed.id;
    if (_disposed || !_open || id == null) {
      return Future.value(AreaPublishOutcome.offline);
    }
    final done = Completer<AreaPublishOutcome>();
    _waiting[id] = done;
    if (!_write(NostrRelayProtocol.event(signed))) {
      _waiting.remove(id);
      return Future.value(AreaPublishOutcome.offline);
    }
    return done.future.timeout(
      okTimeout,
      onTimeout: () {
        _waiting.remove(id);
        return AreaPublishOutcome.offline;
      },
    );
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _close('disposed');
  }

  // ---------------------------------------------------------------- internals

  Future<void> _dial() async {
    if (_disposed || _filters.isEmpty || _channel != null) return;
    final WebSocketChannel channel;
    try {
      channel = _connect(_url);
      _channel = channel;
      await channel.ready;
    } catch (e) {
      _channel = null;
      _scheduleRetry('connect failed: $e');
      return;
    }
    if (_disposed || !identical(channel, _channel) || _filters.isEmpty) {
      unawaited(channel.sink.close());
      if (identical(channel, _channel)) _channel = null;
      return;
    }
    _sub = channel.stream.listen(
      (dynamic raw) {
        if (raw is! String || raw.length > maxFrameChars) {
          _onDown(channel, 'oversized or binary frame');
          return;
        }
        _onMessage(raw);
      },
      onError: (Object e) => _onDown(channel, 'socket error: $e'),
      onDone: () => _onDown(channel, 'closed by relay'),
    );
    _open = true;
    _backoff = _initialBackoff;
    _onConnection?.call(true);
    _sendReq();
    DebugLog.instance.log('AREA', 'connected to ${_url.host}${_url.path}');
  }

  void _sendReq() {
    _write(jsonEncode(['REQ', _subId, ..._filters]));
  }

  void _onMessage(String raw) {
    switch (NostrRelayProtocol.parse(raw)) {
      case RelayEvent(:final subscriptionId, :final event):
        if (subscriptionId != _subId) return;
        final id = event.id;
        if (id == null || !_seenIds.add(id)) return;
        if (_seenIds.length > _rememberIds) _seenIds.remove(_seenIds.first);
        _onEvent(event);
      case RelayOk(:final eventId, :final accepted, :final message):
        final waiting = _waiting.remove(eventId);
        if (waiting != null && !waiting.isCompleted) {
          waiting.complete(
            accepted ? AreaPublishOutcome.accepted : AreaPublishOutcome.refused,
          );
        }
        if (!accepted) DebugLog.instance.log('AREA', 'relay refused: $message');
      case RelayClosed(:final subscriptionId, :final message):
        if (subscriptionId == _subId) {
          DebugLog.instance.log('AREA', 'subscription closed: $message');
        }
      default:
        break;
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
    if (_disposed || _filters.isEmpty || _retry != null) return;
    DebugLog.instance.log('AREA', '$why; again in ${_backoff.inSeconds} s');
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
    _seenIds.clear();
    if (wasOpen) DebugLog.instance.log('AREA', 'closed ($why)');
  }

  void _teardown() {
    final wasOpen = _open;
    _open = false;
    for (final w in _waiting.values) {
      if (!w.isCompleted) w.complete(AreaPublishOutcome.offline);
    }
    _waiting.clear();
    unawaited(_sub?.cancel());
    _sub = null;
    final ch = _channel;
    _channel = null;
    if (ch != null) unawaited(ch.sink.close().catchError((Object _) {}));
    if (wasOpen) _onConnection?.call(false);
  }
}
