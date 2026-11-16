import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/conversation_settings.dart';

/// Per-conversation settings the transport has to honour when it sends: what
/// not to share with one person, the copy restriction, the wallpaper it
/// shares, whether the internet goes first. Exactly the members it calls;
/// `ConversationSettingsController` implements it.
abstract interface class ConversationPrefs {
  /// Resolves once the settings have been read from disk.
  Future<void> get loaded;

  ConversationSettings forChat(String chatId);

  bool sharesLastSeenWith(String chatId);

  bool sharesReadReceiptsWith(String chatId);

  bool sharesAvatarWith(String chatId);

  bool prefersRelay(String chatId);

  bool isMuted(String chatId);

  Future<void> setWallpaper(String chatId, ChatWallpaper wallpaper);

  Future<void> setRestrictCopying(String chatId, bool restricted);

  Future<void> setPeerRestrictsCopying(String chatId, bool restricted);
}

/// Bound in `lib/app/bindings.dart`; see [ConversationPrefs].
final conversationPrefsProvider = Provider<ConversationPrefs>(
  (ref) => throw UnimplementedError(
    'conversationPrefsProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
