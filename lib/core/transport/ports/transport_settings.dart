import 'package:flutter_riverpod/flutter_riverpod.dart';

// The last of the settings the transport reads: whether relay media waits for
// Wi-Fi, when the relay and media settings have loaded, and whether this phone
// may be found by strangers right now. Bound in `lib/app/bindings.dart`.

Never _unbound(String name) => throw UnimplementedError(
      '$name is bound in lib/app/bindings.dart; build the ProviderContainer '
      'with appBindings',
    );

/// Relay media waits while the phone only has cellular data. Listened to by
/// the transport, which pauses or resumes the media inbox on a change.
final mediaWaitsForWifiProvider =
    Provider<bool>((ref) => _unbound('mediaWaitsForWifiProvider'));

/// Resolves once the media-download setting has been read from disk.
final mediaDownloadLoadedProvider =
    Provider<Future<void>>((ref) => _unbound('mediaDownloadLoadedProvider'));

/// Resolves once the relay settings have been read from disk.
final relaySettingsLoadedProvider =
    Provider<Future<void>>((ref) => _unbound('relaySettingsLoadedProvider'));

/// Whether a stranger's XX handshake is answered and the announcement is
/// public right now. Asked, not watched: one of its answers is a time window
/// that closes on its own. Implemented in `lib/app/discoverability.dart`.
abstract interface class Discoverability {
  bool get discoverableNow;
}

final discoverabilityProvider =
    Provider<Discoverability>((ref) => _unbound('discoverabilityProvider'));
