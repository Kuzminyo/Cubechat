import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/channel.dart';
import '../../models/message.dart';

/// Where a message from one person ends up: their conversation, with a
/// notification unless they are muted or on screen.
///
/// The transport files texts, photos, voice notes and files through this and
/// knows nothing of how a conversation is stored or what a banner says. The
/// one implementation is `features/chat/data/chat_inbound.dart`.
abstract interface class IncomingMessages {
  /// Files [message] under the conversation of [senderPub], or under
  /// [fallbackPeerId] when the sender could not be named. A message already
  /// there (same wire id — a relay replay, a second road) is not filed twice
  /// and not announced again.
  void file(
    Uint8List? senderPub, {
    required String fallbackPeerId,
    required Message message,
  });

  /// Files [message] in [channel] — the room name is the bucket, with no
  /// session to fan out to and no key to canonicalise under — and raises the
  /// room's banner, naming [authorName]. Not filed or announced twice.
  void fileInRoom(
    Channel channel, {
    required String authorName,
    required Message message,
  });
}

/// Bound in `lib/app/bindings.dart`; see [IncomingMessages].
final incomingMessagesProvider = Provider<IncomingMessages>(
  (ref) => throw UnimplementedError(
    'incomingMessagesProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
