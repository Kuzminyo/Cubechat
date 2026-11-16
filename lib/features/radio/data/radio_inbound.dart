import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/messaging_service.dart';
import '../../../core/transport/radio_tuning.dart';

// [RadioInbound], [radioGroupKeysProvider] and [radioPairPeersProvider] live
// in core now — the transport reads them on every radio frame and must not
// import a feature to. Re-exported so the radio's own code reads as before.
export '../../../core/transport/radio_tuning.dart';

/// Radio chunks as they arrive, for whoever is playing them.
///
/// The controller lives in [MessagingService] and this hands its stream on,
/// the way `callSignals`, `nearbyInbound` and `ownDeviceNotices` are handed on:
/// the service owns everything that comes off the wire, and a broadcast stream
/// with nobody listening simply drops what it is given - which for voice is
/// the right thing to do with it.
final radioInboundProvider = Provider<Stream<RadioInbound>>(
  (ref) => ref.watch(messagingServiceProvider).radioInbound,
);
