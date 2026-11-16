import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/message.dart';

/// Every conversation's history, by chat id (a canonical id, or a room name).
/// Bound in `lib/app/bindings.dart` to the chat feature's controller state.
final messagesProvider = Provider<Map<String, List<Message>>>(
  (ref) => throw UnimplementedError(
    'messagesProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);

/// What the transport writes to the conversations it carries: delivery
/// status and route, our own sends and their edits and deletions, media it
/// finished assembling, the room and sync payloads it still answers itself.
/// Exactly the members it calls; `MessagesController` implements it, and its
/// doc comments say what each one may and may not change.
abstract interface class Conversations {
  /// Resolves once history has been read from disk.
  Future<void> get loaded;

  /// History could not be read; a stranger rule that needs it must not guess.
  bool get loadFailed;

  /// Files [msg] under [peerId]. False when that wire id is already there.
  bool append(String peerId, Message msg);

  void updateStatus(String peerId, String msgId, MessageStatus status);

  void updateRoute(
    String peerId,
    String msgId,
    MessageRoute route, {
    int? hops,
  });

  void markDeliveredBatch(
    Map<String, Set<String>> byChat,
    MessageRoute route,
  );

  void markForwardSecret(String peerId, String msgId);

  void deleteLocal(String peerId, String messageId);

  bool deleteMineByWireId(String peerId, String wireId);

  bool editMine(String peerId, String targetWireId, String text);

  Future<Message?> consumeViewOnce(String peerId, String wireId);

  int applyAlbum(String peerId, Set<String> wireIds, String albumId);

  bool applyVoiceLevels(String peerId, String wireId, List<int> levels);

  void applyReaction(
    String peerId, {
    required String targetWireId,
    required String emoji,
    required String reactorId,
    required bool add,
  });

  void applyPollVote(
    String chatId, {
    required String pollWireId,
    required String voterId,
    required int option,
  });

  Future<void> clearForChat(String chatId);
}

/// Bound in `lib/app/bindings.dart`; see [Conversations].
final conversationsProvider = Provider<Conversations>(
  (ref) => throw UnimplementedError(
    'conversationsProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
