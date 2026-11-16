import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/channel_member.dart';

/// Every joined room's members, by room name then member id (the 16-hex
/// fingerprint of their Ed25519 key). Listened to by the transport: a roster
/// change is the moment a room frame held for an unknown admin may now be
/// let through. Bound in `lib/app/bindings.dart` to the channels feature.
final channelRostersProvider =
    Provider<Map<String, Map<String, ChannelMember>>>(
  (ref) => throw UnimplementedError(
    'channelRostersProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);

/// What the transport asks and tells a room's roster: who may post, who is
/// an admin or the owner, our own seat, and what signed traffic said about
/// members. Exactly the members it calls; `ChannelRosterController`
/// implements it, and its doc comments say what each rule means.
abstract interface class ChannelRoster {
  bool isAdmin(String channel, String memberId);

  bool isOwner(String channel, String memberId);

  String? ownerOf(String channel);

  bool canPost(String channel, String memberId);

  bool hasConfirmedAdmin(String channel);

  bool holdsProvisionalSeat(String channel, String memberId);

  /// Our own fingerprint as a member.
  Future<String> selfMemberId();

  /// Our own row in [channel], created if missing — as the admin when
  /// [adminWhenFirst] and the room has nobody in the seat.
  Future<ChannelMember> ensureSelf(String channel, {bool adminWhenFirst});

  Future<void> record(String channel, ChannelMember member);

  Future<void> setAdmin(String channel, String memberId, bool admin);

  Future<void> moderate(
    String channel, {
    required String memberId,
    required bool removed,
    DateTime? mutedUntil,
    bool clear,
  });

  Future<void> forget(String channel);
}

/// Bound in `lib/app/bindings.dart`; see [ChannelRoster].
final channelRosterProvider = Provider<ChannelRoster>(
  (ref) => throw UnimplementedError(
    'channelRosterProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
