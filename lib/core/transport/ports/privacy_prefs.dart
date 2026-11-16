import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/stranger_reach.dart';

/// The Privacy switches the transport honours when it sends and receives:
/// whether to publish when we were here, whether to answer with read
/// receipts, whether a forward may link back to us, and who may reach us from
/// the internet. Answered from the settings as they stand at the call.
/// `PrivacySettingsController` implements it.
abstract interface class PrivacyPrefs {
  /// Resolves once the settings have been read from disk.
  Future<void> get loaded;

  bool get shareLastSeen;

  bool get shareReadReceipts;

  bool get allowForwardLink;

  StrangerReach get strangerReach;
}

/// Bound in `lib/app/bindings.dart`; see [PrivacyPrefs].
final privacyPrefsProvider = Provider<PrivacyPrefs>(
  (ref) => throw UnimplementedError(
    'privacyPrefsProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
