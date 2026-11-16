import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/message.dart';
import '../../../core/transport/channel_poll.dart';
import '../../../core/transport/inbound/inbound.dart';
import '../../../core/transport/inbound/incoming_messages.dart';
import '../../../core/transport/inner_payload.dart';
import '../../chat/data/messages_controller.dart';

/// What a room does with what its members send, beyond the posts the chat
/// module files: for now, polls and their votes.
///
/// Moved out of `MessagingService`; see `features/chat/data/chat_inbound.dart`
/// for why. Administration, history, the room's picture and rules are still
/// the transport's — they are tied to the frames it holds until the roster
/// can vouch for an admin (docs/superpowers/specs/
/// 2026-11-16-messaging-service-split-design.md).
class ChannelsInbound implements InboundModule {
  ChannelsInbound(this._ref);

  final Ref _ref;

  @override
  void registerInto(InboundRegistry registry) {
    registry.on(
      InboundScope.room,
      const [InnerPayloadType.channelPoll],
      _poll,
      owner: 'channels',
    );
  }

  /// A new poll is filed like a post; a vote is counted against the voter's
  /// key fingerprint, which the room frame's signature vouched for — the body
  /// never names a voter.
  void _poll(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final channel = ctx.channel!;
    final poll = ChannelPollPayload.decode(body);
    if (poll.operation == ChannelPollOperation.create) {
      final message = Message(
        id: 'm${DateTime.now().microsecondsSinceEpoch}',
        chatId: channel.name,
        text: poll.question!,
        sentAt: DateTime.now(),
        isMine: false,
        kind: MessageKind.poll,
        wireId: ctx.wireId,
        authorName: ctx.authorName,
        authorId: ctx.authorId,
        pollOptions: poll.options,
        route: ctx.route,
        routeHops: ctx.routeHops,
      );
      _ref
          .read(incomingMessagesProvider)
          .fileInRoom(channel, authorName: ctx.authorName!, message: message);
    } else {
      _ref.read(messagesControllerProvider.notifier).applyPollVote(
            channel.name,
            pollWireId: poll.targetWireId!,
            voterId: ctx.authorId!,
            option: poll.option!,
          );
    }
  }
}
