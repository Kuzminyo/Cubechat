import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/transport/ports/transport_settings.dart';
import '../features/airdrop/data/airdrop_receive_controller.dart';
import '../features/airdrop/presentation/airdrop_navigation.dart';
import '../features/profile/data/discovery_settings_controller.dart';

/// Whether this phone may be found by people not yet in its contacts: the
/// profile's "Discoverable nearby", or AirDrop's "Everyone" window — which
/// exist to be found by strangers — or the AirDrop page itself being on
/// screen: while the page is open this phone is meant to be found, so a bump
/// with someone not yet a contact can still start a session.
///
/// Three features answer it, so it is composed here, in the app layer, rather
/// than in any one of them. Moved from `MessagingService._discoverableNow`.
class AppDiscoverability implements Discoverability {
  AppDiscoverability(this._ref);

  final Ref _ref;

  @override
  bool get discoverableNow =>
      _ref.read(discoverySettingsProvider).discoverable ||
      _ref.read(airdropReceiveProvider).everyoneAt(DateTime.now()) ||
      _ref.read(airdropPageOnScreenProvider);
}
