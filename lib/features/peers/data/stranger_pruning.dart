import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/chat_session_manager.dart';
import '../../../core/transport/ports/stranger_pruning.dart';
import '../../chat/data/messages_controller.dart';
import '../../chats/data/favorites_controller.dart';
import '../../chats/data/message_requests_controller.dart';
import '../../chats/data/pinned_chats_controller.dart';
import 'contact_aliases_controller.dart';
import 'known_peers_controller.dart';

/// Which strangers the roster keeps when it trims — see [StrangerPruning].
///
/// Moved out of `MessagingService._pruneStrangers`, where it reached into the
/// chat list's favourites, pins and aliases to decide.
class RosterStrangerPruning implements StrangerPruning {
  RosterStrangerPruning(this._ref);

  final Ref _ref;

  @override
  Future<List<String>> prune({required bool Function() stillWanted}) async {
    final roster = _ref.read(knownPeersControllerProvider.notifier);
    final messages = _ref.read(messagesControllerProvider.notifier);
    // Before the roster and the chat summaries land, somebody with a whole
    // conversation behind them would look like a stranger with none.
    await roster.loaded;
    await messages.summariesLoaded;
    if (!stillWanted()) return const [];
    final history = _ref.read(messagesControllerProvider);
    final summaries = messages.summaries;
    final favorites = _ref.read(favoritesControllerProvider).toSet();
    final pinned = _ref.read(pinnedChatsControllerProvider).toSet();
    final aliases = _ref.read(contactAliasesControllerProvider);
    final requests = _ref.read(messageRequestsProvider.notifier);
    final live = {
      for (final s in _ref.read(chatSessionManagerProvider).values)
        s.remotePubkeyHex,
    };
    return roster.pruneStrangers(
      isKept: (p) {
        final id = p.pubkeyHex;
        return (history[id]?.isNotEmpty ?? false) ||
            summaries.containsKey(id) ||
            favorites.contains(id) ||
            pinned.contains(id) ||
            aliases.containsKey(id) ||
            requests.isPending(id) ||
            live.contains(id);
      },
    );
  }
}
