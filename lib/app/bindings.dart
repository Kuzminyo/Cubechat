import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/transport/inbound/inbound.dart';
import '../core/transport/inbound/incoming_messages.dart';
import '../core/transport/nostr/relay_settings.dart';
import '../core/transport/ports/channel_directory.dart';
import '../core/transport/ports/channel_roster.dart';
import '../core/transport/ports/conversation_prefs.dart';
import '../core/transport/ports/conversations.dart';
import '../core/transport/ports/file_transfers.dart';
import '../core/transport/ports/moderation.dart';
import '../core/transport/ports/peer_directory.dart';
import '../core/transport/ports/peer_extras.dart';
import '../core/transport/ports/privacy_prefs.dart';
import '../core/transport/ports/room_extras.dart';
import '../core/transport/ports/stranger_pruning.dart';
import '../core/transport/ports/transport_settings.dart';
import '../features/channels/data/channel_avatars_controller.dart';
import '../features/channels/data/channel_controller.dart';
import '../features/channels/data/channel_descriptions_controller.dart';
import '../features/channels/data/channel_roster_controller.dart';
import '../features/channels/data/channels_inbound.dart';
import '../features/chat/data/chat_inbound.dart';
import '../features/chat/data/conversation_settings_controller.dart';
import '../features/chat/data/messages_controller.dart';
import '../features/chat/data/pinned_controller.dart';
import '../features/chats/data/message_requests_controller.dart';
import '../features/chats/data/read_markers_controller.dart';
import '../features/files/data/file_transfer_controller.dart';
import '../features/moderation/data/ban_list_controller.dart';
import '../features/moderation/data/hidden_authors.dart';
import '../features/peers/data/known_peers_controller.dart';
import '../features/peers/data/peer_avatars_controller.dart';
import '../features/peers/data/peer_discovery_controller.dart';
import '../features/peers/data/peers_inbound.dart';
import '../features/peers/data/peripheral_controller.dart';
import '../features/peers/data/presence_controller.dart';
import '../features/peers/data/removed_contacts_controller.dart';
import '../features/peers/data/stranger_pruning.dart';
import '../features/profile/data/media_download_settings_controller.dart';
import '../features/profile/data/privacy_settings_controller.dart';
import '../features/profile/data/relay_settings_controller.dart';
import 'discoverability.dart';

/// Where the core meets the features.
///
/// The transport declares what it needs from the app — who answers which
/// inbound payload, where a message from a person is filed, every controller
/// it reads or writes — as providers in `core/` that throw until bound. They
/// are bound here, and nowhere else, so `core/` never imports a feature;
/// `test/architecture_test.dart` holds it to that.
///
/// Each port is implemented by the feature's own controller, so a binding is
/// `ref.watch(controller.notifier)`; state the transport reads or listens to
/// is `ref.watch(controller)`.
///
/// `main.dart` builds its one [ProviderContainer] with these, and that is the
/// container the iOS background refresh uses too: a binding missing there
/// would throw on a phone woken in the background, where nobody sees it, and
/// the message would be lost. Tests that drive the transport build theirs with
/// `[...appBindings, ...]` — see `test/support/inbound_harness.dart`.
final List<Override> appBindings = [
  // ---- inbound: who answers what arrives ----
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

  // ---- contacts ----
  knownPeersProvider.overrideWith(
    (ref) => ref.watch(knownPeersControllerProvider),
  ),
  peerDirectoryProvider.overrideWith(
    (ref) => ref.watch(knownPeersControllerProvider.notifier),
  ),
  strangerPruningProvider.overrideWith(RosterStrangerPruning.new),
  removedContactsProvider.overrideWith(
    (ref) => ref.watch(removedContactsControllerProvider.notifier),
  ),
  peerAvatarStoreProvider.overrideWith(
    (ref) => ref.watch(peerAvatarsControllerProvider.notifier),
  ),
  presenceBookProvider.overrideWith(
    (ref) => ref.watch(presenceControllerProvider.notifier),
  ),
  connectedCentralsProvider.overrideWith(
    (ref) => ref.watch(peripheralControllerProvider).connectedCentralIds,
  ),
  centralLinksProvider.overrideWith(
    (ref) => ref.watch(peripheralControllerProvider.notifier),
  ),
  nearbyPeersProvider.overrideWith(
    (ref) => ref.watch(peerDiscoveryControllerProvider).peers,
  ),

  // ---- conversations ----
  messagesProvider.overrideWith(
    (ref) => ref.watch(messagesControllerProvider),
  ),
  conversationsProvider.overrideWith(
    (ref) => ref.watch(messagesControllerProvider.notifier),
  ),
  conversationPrefsProvider.overrideWith(
    (ref) => ref.watch(conversationSettingsControllerProvider.notifier),
  ),
  pinsProvider.overrideWith(
    (ref) => ref.watch(pinnedControllerProvider.notifier),
  ),
  readMarkersProvider.overrideWith(
    (ref) => ref.watch(readMarkersControllerProvider.notifier),
  ),
  ackMarkersProvider.overrideWith(
    (ref) => ref.watch(ackMarkersControllerProvider.notifier),
  ),
  fileTransferTasksProvider.overrideWith(
    (ref) => ref.watch(fileTransferControllerProvider),
  ),
  fileTransfersProvider.overrideWith(
    (ref) => ref.watch(fileTransferControllerProvider.notifier),
  ),

  // ---- rooms ----
  channelDirectoryProvider.overrideWith(
    (ref) => ref.watch(channelControllerProvider.notifier),
  ),
  channelRostersProvider.overrideWith(
    (ref) => ref.watch(channelRosterControllerProvider),
  ),
  channelRosterProvider.overrideWith(
    (ref) => ref.watch(channelRosterControllerProvider.notifier),
  ),
  channelAvatarsProvider.overrideWith(
    (ref) => ref.watch(channelAvatarsControllerProvider.notifier),
  ),
  channelDescriptionsProvider.overrideWith(
    (ref) => ref.watch(channelDescriptionsControllerProvider.notifier),
  ),

  // ---- moderation and strangers ----
  banCheckProvider.overrideWith(
    (ref) => ref.watch(banListProvider.notifier),
  ),
  hiddenAuthorCheckProvider.overrideWith(
    (ref) => ref.watch(hiddenAuthorsProvider.notifier),
  ),
  messageRequestBookProvider.overrideWith(
    (ref) => ref.watch(messageRequestsProvider.notifier),
  ),

  // ---- settings ----
  privacyPrefsProvider.overrideWith(
    (ref) => ref.watch(privacySettingsProvider.notifier),
  ),
  relaySettingsStateProvider.overrideWith(
    (ref) => ref.watch(relaySettingsProvider),
  ),
  relaySettingsLoadedProvider.overrideWith(
    (ref) => ref.watch(relaySettingsProvider.notifier).loaded,
  ),
  mediaWaitsForWifiProvider.overrideWith(
    (ref) => ref.watch(mediaDownloadSettingsProvider),
  ),
  mediaDownloadLoadedProvider.overrideWith(
    (ref) => ref.watch(mediaDownloadSettingsProvider.notifier).loaded,
  ),
  discoverabilityProvider.overrideWith(AppDiscoverability.new),
];
