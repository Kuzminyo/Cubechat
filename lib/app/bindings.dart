import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/transport/inbound/inbound.dart';
import '../core/transport/inbound/incoming_messages.dart';
import '../core/transport/ports/channel_directory.dart';
import '../core/transport/ports/channel_roster.dart';
import '../core/transport/ports/conversations.dart';
import '../core/transport/ports/peer_directory.dart';
import '../core/transport/ports/stranger_pruning.dart';
import '../features/channels/data/channel_controller.dart';
import '../features/channels/data/channel_roster_controller.dart';
import '../features/channels/data/channels_inbound.dart';
import '../features/chat/data/chat_inbound.dart';
import '../features/chat/data/messages_controller.dart';
import '../features/peers/data/known_peers_controller.dart';
import '../features/peers/data/peers_inbound.dart';
import '../features/peers/data/stranger_pruning.dart';

/// Where the core meets the features.
///
/// The transport declares what it needs from the app — who answers which
/// inbound payload, where a message from a person is filed — as providers in
/// `core/` that throw until bound. They are bound here, and nowhere else, so
/// `core/` never imports a feature; `test/architecture_test.dart` holds it to
/// that.
///
/// `main.dart` builds its one [ProviderContainer] with these, and that is the
/// container the iOS background refresh uses too: a binding missing there
/// would throw on a phone woken in the background, where nobody sees it, and
/// the message would be lost. Tests that drive the transport build theirs with
/// `[...appBindings, ...]` — see `test/support/inbound_harness.dart`.
final List<Override> appBindings = [
  inboundModulesProvider.overrideWith(
    (ref) => [
      ChatInbound(ref),
      ChannelsInbound(ref),
      PeersInbound(ref),
    ],
  ),
  incomingMessagesProvider.overrideWith(
    (ref) => ref.watch(chatIncomingMessagesProvider),
  ),
  strangerPruningProvider.overrideWith(RosterStrangerPruning.new),
  knownPeersProvider.overrideWith(
    (ref) => ref.watch(knownPeersControllerProvider),
  ),
  peerDirectoryProvider.overrideWith(
    (ref) => ref.watch(knownPeersControllerProvider.notifier),
  ),
  messagesProvider.overrideWith(
    (ref) => ref.watch(messagesControllerProvider),
  ),
  conversationsProvider.overrideWith(
    (ref) => ref.watch(messagesControllerProvider.notifier),
  ),
  channelDirectoryProvider.overrideWith(
    (ref) => ref.watch(channelControllerProvider.notifier),
  ),
  channelRostersProvider.overrideWith(
    (ref) => ref.watch(channelRosterControllerProvider),
  ),
  channelRosterProvider.overrideWith(
    (ref) => ref.watch(channelRosterControllerProvider.notifier),
  ),
];
