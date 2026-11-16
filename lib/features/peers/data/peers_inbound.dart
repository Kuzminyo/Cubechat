import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/inbound/inbound.dart';
import '../../../core/transport/inner_payload.dart';
import '../../../core/util/debug_log.dart';
import '../../profile/data/privacy_settings_controller.dart';
import 'known_peers_controller.dart';
import 'peer_activity.dart';
import 'typing_controller.dart';

/// What a contact tells us about themselves rather than about a message:
/// whether a forward of theirs may link back to them, and whether they are
/// typing.
///
/// Moved out of `MessagingService` with the rest of the inbound handlers; see
/// `features/chat/data/chat_inbound.dart` for the note on why.
class PeersInbound implements InboundModule {
  PeersInbound(this._ref);

  final Ref _ref;

  @override
  void registerInto(InboundRegistry registry) {
    registry
      ..on(
        InboundScope.direct,
        const [InnerPayloadType.forwardPrivacy],
        _forwardPrivacy,
        owner: 'peers',
      )
      ..on(
        InboundScope.direct,
        const [InnerPayloadType.typing],
        _typing,
        owner: 'peers',
      );
  }

  Future<void> _forwardPrivacy(
    InboundContext ctx,
    InnerPayloadType type,
    Uint8List body,
  ) async {
    final peerId = ctx.linkPeerId;
    final senderPub = ctx.senderPub;
    if (body.length != 1 || body[0] > 1) {
      DebugLog.instance
          .log('CHAT', 'drop forward-privacy from $peerId: malformed');
      return;
    }
    // Filed under the person, not the road it came in on.
    //
    // `peerId` is the transport — a BLE address, or the literal string
    // `nostr:relay` — and the roster is keyed by pubkey. Written against
    // the transport, the setting landed on a peer nobody has, the real
    // one never changed, and the log said `nostr:relay refuses a link
    // back from a forward`, which is what gave it away. The same
    // confusion the forward attribution itself had.
    if (senderPub == null) {
      DebugLog.instance.log(
        'CHAT',
        'drop forward-privacy from $peerId: no sender to attribute it to',
      );
      return;
    }
    final saysForwardLink = body[0] == 0x01;
    final privacyOwner = inboundHex(senderPub);
    await _ref
        .read(knownPeersControllerProvider.notifier)
        .setAllowsForwardLink(privacyOwner, saysForwardLink);
    DebugLog.instance.log(
      'CHAT',
      '${privacyOwner.substring(0, 8)} '
          '${saysForwardLink ? 'allows' : 'refuses'} '
          'a link back from a forward',
    );
  }

  /// A peer is writing to us — or has stopped.
  void _typing(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    // Still gated, and no longer symmetric with presence: hiding your
    // last-seen time now costs you other people's times, not their
    // liveness. Typing is left where it was on purpose — it is the
    // loudest live signal there is, and quietly switching it back on is
    // not something to do to somebody who asked for less of this.
    if (!_ref.read(privacySettingsProvider).shareLastSeen) return;
    if (body.isEmpty) return;
    final canonicalId = ctx.canonicalId;
    final controller = _ref.read(typingControllerProvider.notifier);
    final kind = PeerActivity.fromWire(body[0]);
    if (kind == null) {
      // A stop is applied whatever its age. It can only take the indicator
      // down, and taking it down late is better than leaving it up. A byte a
      // later build sends and this one does not know lands here too, on
      // purpose — see [PeerActivity.fromWire].
      controller.clear(canonicalId);
      return;
    }

    // "I am writing" is a claim about this second, and it was being believed
    // whenever it happened to arrive.
    //
    // The notice was stamped with our own clock, so one held on a relay came
    // out of the backlog looking new. Reported as the indicator appearing
    // while nobody was typing, and a log of a relay reconnect shows the shape
    // of it: presence beacons in the same burst were stale by two, four, five,
    // six and seven minutes. Presence filters those; this did not, so a
    // seven-minute-old keystroke lit the line for its full eight seconds.
    final now = DateTime.now();
    final sentAt = ctx.sentAt;
    final stamp = (sentAt == null || sentAt.isAfter(now)) ? now : sentAt;
    if (now.difference(stamp) >= TypingController.ttl) return;
    controller.record(canonicalId, at: stamp, kind: kind);
  }
}
