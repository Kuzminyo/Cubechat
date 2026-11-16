import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/channel.dart';
import '../../models/message.dart';
import '../../util/debug_log.dart';
import '../envelope.dart';
import '../inner_payload.dart';

/// Which road a payload came in on: a frame sealed to us, or a room frame
/// opened with a room's key. The same [InnerPayloadType] can mean different
/// things on the two — an edit is checked against a signature in a room and
/// against a session one to one — so a handler is registered per scope.
enum InboundScope { direct, room }

/// Who sent a payload, how it got here and when — worked out once by the
/// transport, after everything that decides whether to believe it.
///
/// By the time a handler sees one of these the frame has been decrypted, its
/// signature checked, deduplicated, checked against the block and ban lists
/// and the replay window, and — in a room — held until the roster could vouch
/// for the author. A handler never decides whether to trust a payload; it
/// decides what the payload means.
@immutable
final class InboundContext {
  const InboundContext.direct({
    required this.linkPeerId,
    required this.env,
    required this.senderPub,
    required this.senderEdPub,
    required this.route,
    required this.routeHops,
    required this.sentAt,
    required this.stamp,
    required this.forwardSecret,
    required String? Function() authorProof,
  })  : scope = InboundScope.direct,
        channel = null,
        authorName = null,
        authorId = null,
        _authorProof = authorProof;

  const InboundContext.room({
    required this.linkPeerId,
    required this.env,
    required Channel this.channel,
    required String this.authorName,
    required String this.authorId,
    required this.senderEdPub,
    required this.route,
    required this.routeHops,
    required this.stamp,
  })  : scope = InboundScope.room,
        senderPub = null,
        sentAt = null,
        forwardSecret = false,
        _authorProof = _noProof;

  final InboundScope scope;

  /// The link the frame arrived on: a BLE address, or the relay placeholder.
  /// Not an identity — see [canonicalId].
  final String linkPeerId;

  final TransportEnvelope env;

  /// The sender's X25519 identity key, when the transport could establish it.
  /// Always null in a room, where authorship is [authorId].
  final Uint8List? senderPub;

  /// The Ed25519 key the payload was verified against, if it was signed.
  final Uint8List? senderEdPub;

  final MessageRoute route;

  /// Hops the envelope travelled, or null over the internet.
  final int? routeHops;

  /// When the link says the frame was sent, if it says.
  final DateTime? sentAt;

  /// When the sender says they sent it (the signed clock), or [sentAt].
  final DateTime stamp;

  /// One to one: the body was opened with an X3DH forward-secret key.
  final bool forwardSecret;

  /// Room only.
  final Channel? channel;
  final String? authorName;

  /// Room only: the 16-hex fingerprint of the author's Ed25519 key.
  final String? authorId;

  final String? Function() _authorProof;

  /// A detached proof that [senderEdPub] wrote this, small enough to keep on
  /// the message; null when unsigned or too large.
  String? authorProof() => _authorProof();

  /// The wire id other payloads name this one by.
  String get wireId => TransportEnvelope.hashHex(env.msgId);

  /// The conversation a one-to-one payload belongs to: the sender's key, or
  /// the link when the sender could not be named.
  String get canonicalId =>
      senderPub == null ? linkPeerId : inboundHex(senderPub!);

  /// Every bucket a one-to-one effect is applied to: the canonical one, and
  /// the link's while it is a different string (a chat opened by address
  /// before its key resolved).
  List<String> get buckets {
    final canonical = canonicalId;
    return canonical != linkPeerId ? [canonical, linkPeerId] : [canonical];
  }

  static String? _noProof() => null;
}

/// [type] is passed because one handler often answers several types.
typedef InboundHandler = FutureOr<void> Function(
  InboundContext ctx,
  InnerPayloadType type,
  Uint8List body,
);

/// Something that answers some payload types: a feature, or the transport
/// itself for what is still its own.
abstract interface class InboundModule {
  void registerInto(InboundRegistry registry);
}

/// Payload type, per scope, to the one handler that answers it.
///
/// Replaces the exhaustive `switch` statements the transport used to dispatch
/// with. Those made a forgotten type a compile error; a registry cannot, so
/// [unaccounted] exists for `test/inbound_registry_complete_test.dart` to
/// insist that every type is either handled or deliberately ignored.
class InboundRegistry {
  final _handlers = <(InboundScope, InnerPayloadType), InboundHandler>{};
  final _ignored = <(InboundScope, InnerPayloadType), String>{};
  final _owners = <(InboundScope, InnerPayloadType), String>{};

  /// [owner] names who registered, for the error when two claim one type.
  void on(
    InboundScope scope,
    Iterable<InnerPayloadType> types,
    InboundHandler handler, {
    required String owner,
  }) {
    for (final type in types) {
      _claim(scope, type, owner);
      _handlers[(scope, type)] = handler;
    }
  }

  /// [types] arrive in [scope] and are dropped on purpose, for [why].
  void ignore(
    InboundScope scope,
    Iterable<InnerPayloadType> types, {
    required String owner,
    required String why,
  }) {
    for (final type in types) {
      _claim(scope, type, owner);
      _ignored[(scope, type)] = why;
    }
  }

  void _claim(InboundScope scope, InnerPayloadType type, String owner) {
    final previous = _owners[(scope, type)];
    if (previous != null) {
      throw StateError(
        '${type.name} in ${scope.name} is claimed by both $previous and '
        '$owner',
      );
    }
    _owners[(scope, type)] = owner;
  }

  /// Runs the handler for [type], if there is one. A type nobody registered
  /// is dropped with a log line — what an older build does with a type it
  /// does not know, and a gap [unaccounted] exists to catch before release.
  Future<void> dispatch(
    InboundContext ctx,
    InnerPayloadType type,
    Uint8List body,
  ) async {
    final handler = _handlers[(ctx.scope, type)];
    if (handler != null) {
      await handler(ctx, type, body);
      return;
    }
    if (_ignored.containsKey((ctx.scope, type))) return;
    DebugLog.instance.log(
      'MESH',
      'drop ${type.name} in ${ctx.scope.name}: no handler registered',
    );
  }

  /// Who answers [type] in [scope], or null.
  String? ownerOf(InboundScope scope, InnerPayloadType type) =>
      _owners[(scope, type)];

  /// Every (scope, type) neither handled nor ignored.
  List<(InboundScope, InnerPayloadType)> get unaccounted => [
        for (final scope in InboundScope.values)
          for (final type in InnerPayloadType.values)
            if (!_owners.containsKey((scope, type))) (scope, type),
      ];
}

/// The feature modules that answer inbound payloads.
///
/// Declared here so the transport can reach them without importing a single
/// feature; bound in `lib/app/bindings.dart`, which `main.dart` hands to the
/// one [ProviderContainer] the UI and the iOS background refresh share. Left
/// unbound it throws, on purpose: a quiet default would drop every message.
final inboundModulesProvider = Provider<List<InboundModule>>(
  (ref) => throw UnimplementedError(
    'inboundModulesProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);

/// Lowercase hex, the form every canonical id in the app takes.
String inboundHex(Uint8List bytes) {
  final sb = StringBuffer();
  for (final b in bytes) {
    sb.write(b.toRadixString(16).padLeft(2, '0'));
  }
  return sb.toString();
}
