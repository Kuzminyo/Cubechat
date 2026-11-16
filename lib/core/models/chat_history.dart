import 'package:flutter/foundation.dart';

import 'message.dart';

// Questions asked of a conversation's history by both the transport and the
// features: is this the notes-to-self chat, have we written here, what is
// still waiting for a road. Moved from `features/chats/data/saved_messages.dart`,
// `features/moderation/domain/profanity.dart` and
// `features/chat/data/send_queue.dart`, which re-export them.

/// The reserved chat id for notes to yourself.
///
/// `@` cannot collide with either of the other two kinds: a peer chat is keyed
/// by 64 hex characters, a channel starts with `#`. Reserved rather than
/// derived from your own pubkey so the notes survive an identity change —
/// losing everything you saved because a key rotated would be a surprising way
/// to lose it.
const String savedChatId = '@saved';

bool isSavedChat(String chatId) => chatId == savedChatId;

/// Who counts as a stranger for the filter.
///
/// The app keeps no contact list to ask. `knownPeers` holds everybody whose
/// key this phone has ever seen, which includes every sender, so the
/// handoff's "in knownPeers" test made the filter a no-op in direct chats;
/// and the Contacts tab is "anyone with history", which a stranger's first
/// message already is. So a conversation stops being a stranger's once you
/// have written in it yourself (review of 2026-09-25). Unknown history — a
/// chat whose messages are not loaded yet — counts as a stranger's, so the
/// fold errs toward hiding.
bool hasWrittenIn(Iterable<Message>? history) =>
    history?.any((m) => m.isMine) ?? false;

/// One of our messages that found no road and is held until one opens.
@immutable
class QueuedMessage {
  const QueuedMessage({required this.chatId, required this.message});

  /// The conversation it sits in, which is what the queue opens and names.
  final String chatId;
  final Message message;
}

/// Everything of ours still waiting for Bluetooth or the internet, oldest
/// first.
///
/// "Waiting" is exactly what the bubble shows as waiting: still sending, and
/// filed as `queued` because nothing carried it when it was sent. A message on
/// its way right now is not in here — it is not waiting for a connection, it
/// is using one.
///
/// Only the tail of each conversation is read. Anything held longer than a
/// day is in the conversation's last few hundred messages or nowhere — the
/// store gives up on a frame long before — and reading every message of every
/// chat on each change of the message store is the cost this avoids: that
/// store changes on every tick that turns grey to blue.
List<QueuedMessage> queuedMessages(
  Map<String, List<Message>> byChat, {
  int tail = 300,
}) {
  final seen = <String>{};
  final out = <QueuedMessage>[];
  for (final entry in byChat.entries) {
    if (isSavedChat(entry.key)) continue;
    final list = entry.value;
    for (var i = list.length - 1; i >= 0 && i >= list.length - tail; i--) {
      final m = list[i];
      if (!m.isMine ||
          m.status != MessageStatus.sending ||
          m.route != MessageRoute.queued) {
        continue;
      }
      // A message can sit under two keys while a legacy address bucket is
      // folded into the peer's own; it is one message waiting, not two.
      if (!seen.add(m.id)) continue;
      out.add(QueuedMessage(chatId: entry.key, message: m));
    }
  }
  out.sort((a, b) => a.message.sentAt.compareTo(b.message.sentAt));
  return out;
}
