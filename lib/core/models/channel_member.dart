import 'package:flutter/foundation.dart';

/// A room member's id: the first eight bytes of their Ed25519 key, in hex.
/// The same id a post's signature resolves to, so anybody holding the key can
/// work it out outside a room.
String memberFingerprintOf(Uint8List signPublicKey) => signPublicKey
    .take(8)
    .map((value) => value.toRadixString(16).padLeft(2, '0'))
    .join();

// Moved from `features/channels/data/channel_roster_controller.dart`, which
// re-exports it: the transport checks every room post against a member's
// row and must not import a feature to do it.

@immutable
class ChannelMember {
  const ChannelMember({
    required this.id,
    required this.name,
    required this.isAdmin,
    required this.lastSeen,
    this.mutedUntil,
    this.removedAt,
    this.provisionalAdmin = false,
    this.isOwner = false,
  });

  final String id;
  final String name;
  final bool isAdmin;
  final DateTime lastSeen;

  /// Silenced by an administrator until this moment. Their posts are dropped
  /// on arrival; they stay in the room and keep reading.
  final DateTime? mutedUntil;

  /// Put out of the room by an administrator.
  ///
  /// The row stays rather than being deleted, and that is the point: a roster
  /// grows from traffic, so deleting somebody would last exactly until their
  /// next message re-created them. Kept and marked, the row is what every
  /// later frame of theirs is checked against.
  ///
  /// Not a ban. Nothing stops them deriving the key from the room's name
  /// again — a shared key is the only membership there is — so this is every
  /// other member declining to accept what they write, which is the strongest
  /// thing a room without a server can do.
  final DateTime? removedAt;

  /// A seat this phone handed itself because the room looked unowned.
  ///
  /// Joining is deriving a key from a name, so two people who each typed it
  /// start with an empty roster and each grant themselves the room — and then
  /// refuse each other's claim, because a claim is only accepted on a room
  /// with nobody in the seat. Both ended up administrators of the same
  /// channel, which is why nobody ever saw a reader's view of one.
  ///
  /// Marking the claim as unconfirmed is what makes it possible to give up:
  /// a seat granted by somebody who already held one is settled, and one
  /// granted by an empty roster is a guess. See the `channelAdmin` ingest,
  /// where two guesses are resolved the same way on both phones.
  final bool provisionalAdmin;

  /// The one member who may close the room for everybody.
  ///
  /// **This is a record, not a proof.** The protocol has no creation event to
  /// attach ownership to — joining is deriving a key from a name, and the
  /// first person to type it is indistinguishable from the tenth — so there is
  /// nothing to check a claim against. What this records is the first *settled*
  /// administrator each phone saw: the seat somebody took and everyone else
  /// accepted. In a room made by one person and joined by others that is the
  /// person who made it, on every phone, because the claim spreads from one
  /// place.
  ///
  /// Written once and never moved. Ownership does not follow the admin list,
  /// or an owner could appoint an administrator and be deleted by them.
  final bool isOwner;

  bool get isRemoved => removedAt != null;

  bool get isMutedNow =>
      mutedUntil != null && mutedUntil!.isAfter(DateTime.now());

  /// Whether what this member writes is accepted at all.
  bool get canPost => !isRemoved && !isMutedNow;

  ChannelMember copyWith({
    String? name,
    bool? isAdmin,
    DateTime? lastSeen,
    DateTime? mutedUntil,
    DateTime? removedAt,
    bool clearModeration = false,
    bool? provisionalAdmin,
    bool? isOwner,
  }) =>
      ChannelMember(
        id: id,
        name: name ?? this.name,
        isAdmin: isAdmin ?? this.isAdmin,
        lastSeen: lastSeen ?? this.lastSeen,
        mutedUntil: clearModeration ? null : (mutedUntil ?? this.mutedUntil),
        removedAt: clearModeration ? null : (removedAt ?? this.removedAt),
        provisionalAdmin: provisionalAdmin ?? this.provisionalAdmin,
        isOwner: isOwner ?? this.isOwner,
      );
}
