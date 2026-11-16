import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/chat_history.dart';
import 'messages_controller.dart';

// [QueuedMessage] and [queuedMessages] live in core — the transport's outbox
// asks the same question — and are re-exported for the send queue's readers.
export '../../../core/models/chat_history.dart'
    show QueuedMessage, queuedMessages;

final sendQueueProvider = Provider<List<QueuedMessage>>(
  (ref) => queuedMessages(ref.watch(messagesControllerProvider)),
);
