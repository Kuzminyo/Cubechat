import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/discovered_peer.dart';
import '../../models/peer_presence.dart';

// What the transport keeps in step about people beyond their keys: whom the
// user removed, the pictures it fetched, who is in the app, which centrals are
// linked to our peripheral, who the scanner can see. Each port lists exactly
// what the transport calls, the owning feature's controller implements it,
// and `lib/app/bindings.dart` binds it.

Never _unbound(String name) => throw UnimplementedError(
      '$name is bound in lib/app/bindings.dart; build the ProviderContainer '
      'with appBindings',
    );

/// People taken off the Contacts screen. `RemovedContactsController`
/// implements it.
abstract interface class RemovedContacts {
  bool isRemoved(String pubkeyHex);

  /// Puts them back — a card or a handshake is somebody choosing to.
  Future<void> restore(String pubkeyHex);
}

final removedContactsProvider =
    Provider<RemovedContacts>((ref) => _unbound('removedContactsProvider'));

/// Contacts' pictures the transport fetched. `PeerAvatarsController`
/// implements it.
abstract interface class PeerAvatarStore {
  Future<void> get loaded;

  /// Whether the stored picture for [pubkeyHex] hashes to [hash].
  Future<bool> holds(String pubkeyHex, Uint8List hash);

  /// False when [jpeg] does not hash to [expectedHash].
  Future<bool> store(String pubkeyHex, Uint8List jpeg, Uint8List expectedHash);

  Future<void> forget(String pubkeyHex);
}

final peerAvatarStoreProvider =
    Provider<PeerAvatarStore>((ref) => _unbound('peerAvatarStoreProvider'));

/// Who is in the app right now, from their beacons. `PresenceController`
/// implements it.
abstract interface class PresenceBook {
  /// Their last beacon, if it is still fresh.
  PeerPresence? freshFor(String canonicalId);

  void record(
    String canonicalId, {
    required bool online,
    bool hidesLastSeen = false,
    DateTime? at,
  });
}

final presenceBookProvider =
    Provider<PresenceBook>((ref) => _unbound('presenceBookProvider'));

/// Centrals linked to our peripheral, by id. Bound to the peers feature's
/// peripheral state.
final connectedCentralsProvider =
    Provider<Set<String>>((ref) => _unbound('connectedCentralsProvider'));

/// What the transport tells the peripheral's state as centrals come and go.
/// `PeripheralController` implements it.
abstract interface class CentralLinks {
  void onCentralConnected(String centralId);

  void onCentralDisconnected(String centralId);
}

final centralLinksProvider =
    Provider<CentralLinks>((ref) => _unbound('centralLinksProvider'));

/// Whoever the scanner can see right now. Bound to the peers feature's
/// discovery state.
final nearbyPeersProvider =
    Provider<List<DiscoveredPeer>>((ref) => _unbound('nearbyPeersProvider'));
