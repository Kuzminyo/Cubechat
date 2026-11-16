import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/known_peer.dart';

/// The contacts the transport knows keys for, by canonical id (hex of the
/// X25519 identity key).
///
/// Read on every frame — whose signature to expect, whose origin id is whose,
/// who is blocked — and listened to, because a roster change is the moment a
/// held frame may become verifiable. Bound in `lib/app/bindings.dart` to the
/// peers feature's controller state.
final knownPeersProvider = Provider<Map<String, KnownPeer>>(
  (ref) => throw UnimplementedError(
    'knownPeersProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);

/// What the transport writes to the roster: who it heard announce, who is
/// present. Exactly the members it calls, no more; `KnownPeersController`
/// implements it.
abstract interface class PeerDirectory {
  /// Adds or refreshes a peer from what the transport learned: a handshake, an
  /// announcement, a card. See `KnownPeersController.upsert` for what each
  /// argument may and may not overwrite.
  void upsert({
    required String pubkeyHex,
    required String displayName,
    Uint8List? signPublicKey,
    Uint8List? signedPrekeyPub,
    Uint8List? nostrPubkey,
    Uint8List? avatarHash,
    bool avatarKnown = false,
    bool stranger = false,
  });

  /// Moves a peer's last-seen mark forward to [at] (never back).
  Future<void> markPresent(
    String pubkeyHex, {
    DateTime? at,
    bool? hidesLastSeen,
  });

  bool isBlocked(String pubkeyHex);
}

/// Bound in `lib/app/bindings.dart`; see [PeerDirectory].
final peerDirectoryProvider = Provider<PeerDirectory>(
  (ref) => throw UnimplementedError(
    'peerDirectoryProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
