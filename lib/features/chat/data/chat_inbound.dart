import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/identity/nickname_controller.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/models/channel.dart';
import '../../../core/models/message.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/radio_spike.dart';
import '../../../core/transport/chat_session_manager.dart';
import '../../../core/transport/envelope.dart';
import '../../../core/transport/inbound/inbound.dart';
import '../../../core/transport/inbound/incoming_messages.dart';
import '../../../core/transport/inner_payload.dart';
import '../../../core/transport/shared_location.dart';
import '../../../core/util/app_lifecycle.dart';
import '../../../core/util/debug_log.dart';
import '../../../core/util/platform_info.dart';
import '../../../l10n/app_localizations.dart';
import '../../map/data/shared_map_locations_provider.dart';
import '../../moderation/data/filter_settings.dart';
import '../../moderation/domain/profanity.dart';
import '../../peers/data/known_peers_controller.dart';
import '../domain/message_preview.dart';
import 'conversation_settings_controller.dart';
import 'message_farewell.dart';
import 'messages_controller.dart';
import 'pinned_controller.dart';

// What a conversation does with what arrives: texts and replies, edits,
// deletions, pins, reactions, read receipts, the forwarded-from header, the
// conversation clear and the copy restriction — one to one, and in rooms for
// the five that rooms have.
//
// Moved out of `MessagingService`, where these were cases of two `switch`
// statements and two dozen private helpers. The transport now decides whether
// a payload is to be believed and who sent it, and hands the rest here through
// the inbound registry (`core/transport/inbound/inbound.dart`). The code is the
// code that was there; the comments that explained it came with it.

/// Files one person's messages and raises their notifications.
///
/// The one [IncomingMessages] there is: the transport files texts, photos,
/// voice notes and files through it. Also holds forwarded-from attributions
/// that arrived before the message they belong to, because filing that message
/// is what claims them.
class ChatIncomingMessages implements IncomingMessages {
  ChatIncomingMessages(this._ref);

  final Ref _ref;

  /// Attributions that arrived before the message they belong to.
  final Map<String, _HeldAttribution> _pendingForwardedFrom = {};

  /// The same cap the transport keeps on voice levels waiting for their audio
  /// (`_maxPendingVoiceLevels`): an attribution whose message never arrives is
  /// worth even less than levels whose audio never does.
  static const int _maxPendingForwardedFrom = 64;

  /// Appends [message] into the canonical pubkey-keyed message bucket, plus
  /// any legacy peerId-keyed buckets that already exist (so a chat opened
  /// before the handshake completed still sees the messages). The chats list
  /// reads from KnownPeersController + the pubkey bucket — the peerId
  /// fan-out is purely for the open-screen case.
  @override
  void file(
    Uint8List? senderPub, {
    required String fallbackPeerId,
    required Message message,
  }) {
    final messages = _ref.read(messagesControllerProvider.notifier);
    if (senderPub == null) {
      messages.append(fallbackPeerId, message);
      return;
    }
    final pubkeyHex = inboundHex(senderPub);
    // Somebody who writes is NOT a contact again, and used to be.
    //
    // The old reasoning was that mail is never worth losing to a preference,
    // and it was sound while removing a contact deleted the conversation with
    // them: a message from a removed person had nowhere to land, so the
    // removal had to be undone first. That is no longer true. Removing a
    // contact keeps the roster entry and the whole conversation now — see
    // `removeFromContacts` — so their message arrives, is stored, and shows in
    // the chat list exactly as it always did. Nothing is lost by leaving them
    // off the Contacts screen.
    //
    // What was lost was the decision. Somebody tidied their list, the other
    // person wrote a week later, and the row came back with no explanation —
    // which is the same complaint that started this, seen from the other end.
    //
    // The way back is a button on their profile, which is where somebody who
    // wants them back is already looking.
    // Canonical key (lives forever, used by chats list). A false return means
    // this exact wireId is already in the chat — a relay backlog replay or a
    // second delivery path — so there is nothing to fan out and nothing to
    // notify about either.
    // An attribution that beat its own message here. Taken rather than read:
    // this bubble now holds it, and a re-delivery has nothing left to stamp.
    final held = message.wireId == null
        ? null
        : _pendingForwardedFrom.remove(message.wireId);
    if (held != null) {
      message = message.copyWith(
        forwardedFrom: held.name,
        forwardedFromId: held.authorId,
      );
    }
    if (!messages.append(pubkeyHex, message)) {
      // Unless it is the file we asked to have again: same id, same bubble, and
      // the whole point is the new path underneath it.
      final path = message.filePath;
      final wireId = message.wireId;
      if (path != null && wireId != null) {
        if (messages.restoreFilePath(pubkeyHex, wireId, path)) {
          DebugLog.instance
              .log('FILE', 're-sent file $wireId adopted by its bubble');
          return;
        }
      }
      DebugLog.instance.log(
        'NOISE',
        'skip already-stored message ${message.wireId} in $pubkeyHex',
      );
      return;
    }

    // Stored under the pubkey and nowhere else.
    //
    // This used to fan the message out to every open session keyed by BLE
    // address as well, so a chat opened from Nearby — which navigates by
    // address — would see it. The guard was sound at the moment of writing:
    // only sessions whose remote static key matched the sender got a copy.
    //
    // What it could not guard is *later*. Android rotates its BLE address,
    // and the same log that shows this fan-out shows one peer arriving under
    // three different addresses in as many minutes. The bucket keyed by the
    // old address keeps the old name and is still on disk when that address
    // belongs to somebody else — which is how a message from one phone landed
    // in another phone's conversation, and it is precisely the mistake the
    // wire notes warn about: a peer id is never a stable key.
    //
    // Nothing is lost by stopping. The chat screen already prefers the
    // canonical bucket and only falls back to the transport id while no
    // session has resolved a pubkey yet — and a message that decrypted has a
    // session by definition, so by the time one exists the screen is reading
    // the pubkey.
    DebugLog.instance.log('NOISE', 'appended to canonical=$pubkeyHex');

    _notifyIncoming(canonicalId: pubkeyHex, message: message);
  }

  /// Raise a system notification for an inbound message — but only when the
  /// app isn't in the foreground (otherwise the user is already looking at
  /// it). Sender name comes from the KnownPeers roster; the preview is a
  /// short, content-type-aware snippet.
  void _notifyIncoming({
    required String canonicalId,
    required Message message,
  }) {
    if (message.isMine) return;
    // Suppress only when the user is actively reading THIS chat. A message
    // from someone else (or while on the chats list / nearby / backgrounded)
    // still pops a notification.
    if (AppLifecycle.instance.isViewingChat(canonicalId)) return;
    final known = _ref.read(knownPeersControllerProvider)[canonicalId];
    // Muted peer: message is stored, but stays silent.
    if (known?.isMuted ?? false) return;
    // And a muted room. A channel has no [KnownPeer] to hang a mute on — the
    // line above can only ever answer for a person — so rooms keep theirs with
    // the conversation. See [ConversationSettings.muted].
    if (_ref
        .read(conversationSettingsControllerProvider.notifier)
        .isMuted(canonicalId)) {
      return;
    }
    final localizations =
        lookupAppLocalizations(_ref.read(localeControllerProvider));
    // The English constant this was is the one word on the banner that is not
    // the sender's own name, so it was also the only word the app got to
    // choose — and it chose English, on a phone whose every other line was
    // Ukrainian. The preview below has been localised since it was written;
    // the title beside it was not.
    final name = (known?.displayName.isNotEmpty ?? false)
        ? known!.displayName
        : localizations.notificationUnknownSender;
    // The same line the chat list shows, in the language the app is set to: a
    // notification used to announce '📷 Photo' for a sticker and, in English,
    // to somebody using the app in Ukrainian.
    final preview = messagePreview(
      message,
      localizations,
      hideOffensive: shouldFilter(
        message: message,
        isChannel: false,
        // The bubble's and the chat list's stranger rule — see [hasWrittenIn].
        fromContact: hasWrittenIn(
          _ref.read(messagesControllerProvider)[canonicalId],
        ),
        enabled: _ref.read(filterEnabledProvider),
      ),
    );
    unawaited(
      NotificationService.instance.showMessage(
        threadKey: canonicalId,
        title: name,
        body: preview,
        senderId: canonicalId,
      ),
    );
  }

  @override
  void fileInRoom(
    Channel channel, {
    required String authorName,
    required Message message,
  }) {
    // append() is idempotent on wireId; only a genuinely new message
    // warrants a notification.
    if (_ref
        .read(messagesControllerProvider.notifier)
        .append(channel.name, message)) {
      _notifyRoom(channel: channel, authorName: authorName, message: message);
    }
  }

  /// The room's banner: its name for a title — with an `@` when the post
  /// mentions our nickname — and the author before the preview.
  void _notifyRoom({
    required Channel channel,
    required String authorName,
    required Message message,
  }) {
    if (AppLifecycle.instance.isViewingChat(channel.name)) return;
    final nickname =
        _ref.read(nicknameControllerProvider).replaceAll(RegExp(r'\s+'), '_');
    final mentioned = RegExp(
      r'(^|\s)@' + RegExp.escape(nickname) + r'(\s|$)',
      caseSensitive: false,
    ).hasMatch(message.text);
    final localizations =
        lookupAppLocalizations(_ref.read(localeControllerProvider));
    final preview = messagePreview(
      message,
      localizations,
      hideOffensive: shouldFilter(
        message: message,
        isChannel: true,
        fromContact: false,
        enabled: _ref.read(filterEnabledProvider),
      ),
    );
    unawaited(
      NotificationService.instance.showMessage(
        threadKey: channel.name,
        title: mentioned ? '@ ${channel.name}' : channel.name,
        body: '$authorName: $preview',
        senderId: channel.name,
        isGroup: true,
      ),
    );
  }

  /// The attribution from the other side: stamp it on the message if that has
  /// arrived, and hold it if it has not.
  void ingestForwardedFrom({
    required String peerId,
    required Uint8List? senderPub,
    required Uint8List body,
  }) {
    final ForwardedFrom hint;
    try {
      hint = ForwardedFrom.decode(body);
    } catch (e) {
      DebugLog.instance
          .log('CHAT', 'drop malformed forwarded-from from $peerId: $e');
      return;
    }
    final wireId = TransportEnvelope.hashHex(hint.targetMsgId);

    // Scoped to this peer's buckets, as the voice levels and the album hint
    // are: nobody gets to write a header onto a message somebody else sent.
    final messages = _ref.read(messagesControllerProvider.notifier);
    final targets = <String>{peerId};
    if (senderPub != null) {
      targets.add(inboundHex(senderPub));
      final sessions = _ref.read(chatSessionManagerProvider);
      for (final entry in sessions.entries) {
        final other = entry.value.remoteStaticPublicKey;
        if (other != null && _pubkeyEquals(other, senderPub)) {
          targets.add(entry.key);
        }
      }
    }
    final authorId =
        hint.authorPub == null ? null : inboundHex(hint.authorPub!);
    var stamped = false;
    for (final bucket in targets) {
      stamped |= messages.applyForwardedFrom(
        bucket,
        wireId,
        hint.name,
        authorId: authorId,
      );
    }
    if (stamped) return;

    _pendingForwardedFrom[wireId] = _HeldAttribution(hint.name, authorId);
    while (_pendingForwardedFrom.length > _maxPendingForwardedFrom) {
      _pendingForwardedFrom.remove(_pendingForwardedFrom.keys.first);
    }
  }

  static bool _pubkeyEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

final chatIncomingMessagesProvider =
    Provider<ChatIncomingMessages>(ChatIncomingMessages.new);

class _HeldAttribution {
  const _HeldAttribution(this.name, this.authorId);

  final String name;
  final String? authorId;
}

/// The chat's share of inbound payloads. See the note at the top of the file.
class ChatInbound implements InboundModule {
  ChatInbound(this._ref);

  final Ref _ref;

  @override
  void registerInto(InboundRegistry registry) {
    void direct(InnerPayloadType type, InboundHandler handler) =>
        registry.on(InboundScope.direct, [type], handler, owner: 'chat');
    void room(InnerPayloadType type, InboundHandler handler) =>
        registry.on(InboundScope.room, [type], handler, owner: 'chat');

    direct(InnerPayloadType.text, _text);
    direct(InnerPayloadType.textReply, _textReply);
    direct(InnerPayloadType.receipt, _receipt);
    direct(InnerPayloadType.reaction, _reaction);
    direct(InnerPayloadType.edit, _edit);
    direct(InnerPayloadType.delete, _delete);
    direct(InnerPayloadType.pin, _pin);
    direct(
      InnerPayloadType.forwardedFrom,
      (ctx, type, body) =>
          _ref.read(chatIncomingMessagesProvider).ingestForwardedFrom(
                peerId: ctx.linkPeerId,
                senderPub: ctx.senderPub,
                body: body,
              ),
    );
    direct(InnerPayloadType.conversationClear, _conversationClear);
    direct(InnerPayloadType.copyRestriction, _copyRestriction);

    room(InnerPayloadType.text, _roomText);
    room(InnerPayloadType.textReply, _roomTextReply);
    room(InnerPayloadType.reaction, _roomReaction);
    room(InnerPayloadType.edit, _roomEdit);
    room(InnerPayloadType.delete, _roomDelete);
    room(InnerPayloadType.pin, _roomPin);
    room(InnerPayloadType.receipt, _roomReceipt);
  }

  // ------------------------------ one to one ------------------------------

  void _text(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final peerId = ctx.linkPeerId;
    final senderPub = ctx.senderPub;
    final plaintext = utf8.decode(
      unpadTextPayload(body),
      allowMalformed: true,
    );
    // Stage-0 walkie-talkie spike (spike/ios-ptt): from a known,
    // non-blocked contact the marker drives PushToTalk and is never
    // filed as a message; from anyone else it is ordinary text.
    if (PlatformInfo.isIOS && plaintext.startsWith(RadioSpike.marker)) {
      final spikeSender = ctx.canonicalId;
      final spikePeer = _ref.read(knownPeersControllerProvider)[spikeSender];
      if (spikePeer != null && !spikePeer.isBlocked) {
        unawaited(RadioSpike.instance.incoming(spikePeer.displayName));
        return;
      }
    }
    // A map beacon is transport wearing a text message's clothes: it
    // arrives every 45 seconds while their map is open. Filing it in the
    // conversation would bury the conversation, and — because history is
    // what read receipts are owed on — would have this device acking a
    // beacon every 45 seconds, per friend, forever.
    //
    // Recognised by [SharedLocation.isBeaconText] rather than by the flag
    // alone: the flag is recent, and a friend still on an older build
    // emits the same heartbeat without it. Matching on the shape of the
    // thing — a position that expires within minutes of being sent —
    // catches both, and catches nothing a person chose to send, since the
    // share sheet's shortest window is fifteen minutes.
    final arrivedAt = DateTime.now();
    final beacon = SharedLocation.tryParse(plaintext);
    if (beacon != null && SharedLocation.isBeaconText(plaintext, arrivedAt)) {
      _ref.read(mapPresenceStoreProvider.notifier).record(
            ctx.canonicalId,
            beacon,
            sentAt: arrivedAt,
          );
      return;
    }
    DebugLog.instance
        .log('NOISE', 'RX text from $peerId (${plaintext.length} chars)');
    final message = Message(
      id: 'm${DateTime.now().microsecondsSinceEpoch}',
      chatId: peerId,
      text: plaintext,
      sentAt: ctx.stamp,
      isMine: false,
      forwardSecret: ctx.forwardSecret,
      wireId: ctx.wireId,
      route: ctx.route,
      routeHops: ctx.routeHops,
      signedProof: ctx.authorProof(),
    );
    _ref
        .read(incomingMessagesProvider)
        .file(senderPub, fallbackPeerId: peerId, message: message);
  }

  void _textReply(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final peerId = ctx.linkPeerId;
    final reply = unpackTextReply(body);
    final plaintext = utf8.decode(
      unpadTextPayload(reply.paddedText),
      allowMalformed: true,
    );
    final message = Message(
      id: 'm${DateTime.now().microsecondsSinceEpoch}',
      chatId: peerId,
      text: plaintext,
      sentAt: ctx.stamp,
      isMine: false,
      forwardSecret: ctx.forwardSecret,
      wireId: ctx.wireId,
      replyToWireId: TransportEnvelope.hashHex(reply.targetMsgId),
      route: ctx.route,
      routeHops: ctx.routeHops,
      signedProof: ctx.authorProof(),
    );
    _ref
        .read(incomingMessagesProvider)
        .file(ctx.senderPub, fallbackPeerId: peerId, message: message);
  }

  /// A read receipt from a peer flips our matching outgoing messages to read.
  ///
  /// The local privacy switch controls what this device sends. If the peer
  /// chooses to send a receipt, applying it only updates ticks on our own
  /// messages.
  void _receipt(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final peerId = ctx.linkPeerId;
    final ReadReceipt r;
    try {
      r = ReadReceipt.decode(body);
    } catch (e) {
      DebugLog.instance.log('RECEIPT', 'drop receipt from $peerId: $e');
      return;
    }
    if (r.status != ReceiptStatus.read) return;
    final ids = r.msgIds.map(TransportEnvelope.hashHex).toSet();
    final messages = _ref.read(messagesControllerProvider.notifier);
    final canonical = ctx.canonicalId;
    var outcome = messages.markRead(canonical, ids);
    if (canonical != peerId) outcome += messages.markRead(peerId, ids);
    // Said out loud, because "the tick never turns blue" has no other evidence
    // to work from: the frame arriving and the frame *meaning* something are
    // different failures, and only this line tells them apart.
    //
    // Split three ways, because two of them used to look identical and one of
    // those is not a fault at all. "2 id(s), 1 marked" cost an investigation
    // on the assumption that a handle had gone missing; the far likelier
    // reading is the same receipt arriving again from a second relay and
    // finding the message already read, which is the mechanism working. Only
    // `unknown` — an id matching nothing we ever sent — is worth chasing, and
    // it now says so in that word.
    DebugLog.instance.log(
      'RECEIPT',
      'read ack from ${_short(canonical)}: ${ids.length} id(s), '
          '${outcome.marked} marked'
          '${outcome.alreadyRead > 0 ? ', ${outcome.alreadyRead} already read' : ''}'
          '${outcome.unknown > 0 ? ', ${outcome.unknown} UNKNOWN' : ''}',
    );
  }

  /// A reaction from a peer, applied to both the canonical (pubkey-hex) and
  /// any open transport-id bucket for that peer.
  void _reaction(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final Reaction rx;
    try {
      rx = Reaction.decode(body);
    } catch (e) {
      DebugLog.instance
          .log('REACT', 'drop reaction from ${ctx.linkPeerId}: $e');
      return;
    }
    final senderEdPub = ctx.senderEdPub;
    final reactorId =
        senderEdPub != null ? inboundHex(senderEdPub).substring(0, 16) : 'them';
    _applyReaction(ctx.buckets, rx: rx, reactorId: reactorId);
  }

  /// An inbound edit from a peer, applied to their own message only.
  void _edit(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final MessageEdit edit;
    try {
      edit = MessageEdit.decode(body);
    } catch (e) {
      DebugLog.instance.log('EDIT', 'drop edit from ${ctx.linkPeerId}: $e');
      return;
    }
    final target = TransportEnvelope.hashHex(edit.targetMsgId);
    final messages = _ref.read(messagesControllerProvider.notifier);
    final signedProof = ctx.authorProof();
    for (final bucket in ctx.buckets) {
      messages.editFromPeer(
        bucket,
        target,
        edit.text,
        signedProof: signedProof,
      );
    }
  }

  /// An inbound "delete for everyone" from a peer, applied to their message.
  void _delete(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final peerId = ctx.linkPeerId;
    final MessageDelete del;
    try {
      del = MessageDelete.decode(body);
    } catch (e) {
      DebugLog.instance.log('EDIT', 'drop delete from $peerId: $e');
      return;
    }
    final target = TransportEnvelope.hashHex(del.targetMsgId);
    final messages = _ref.read(messagesControllerProvider.notifier);
    final canonical = ctx.canonicalId;

    // Play it out rather than snap it away. This is the deletion nobody asked
    // for and the one most likely to be watched happening, so a row that
    // simply ceases to exist between two frames reads as the app losing a
    // message rather than as the sender withdrawing it.
    //
    // The wire carries a hash, not a local id, so the row has to be found
    // before it can be marked; if it is not here, there is nothing to animate
    // and the delete still runs.
    void remove() {
      messages.deleteFromPeer(canonical, target);
      if (canonical != peerId) messages.deleteFromPeer(peerId, target);
    }

    final stored = _ref.read(messagesControllerProvider);
    final localId = [
      ...?stored[canonical],
      if (canonical != peerId) ...?stored[peerId],
    ].where((m) => m.wireId == target).map((m) => m.id).toSet();

    unawaited(
      _ref
          .read(messageFarewellProvider(canonical).notifier)
          .dismiss(localId, remove),
    );
  }

  /// A pin/unpin from the other side of a 1:1 chat, applied to the same buckets
  /// their messages land in.
  void _pin(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final MessagePin p;
    try {
      p = MessagePin.decode(body);
    } catch (e) {
      DebugLog.instance.log('PIN', 'drop pin from ${ctx.linkPeerId}: $e');
      return;
    }
    _applyPin(
      ctx.buckets,
      target: TransportEnvelope.hashHex(p.targetMsgId),
      pinned: p.op == PinOp.pin,
    );
  }

  /// The peer deleted this conversation and asked us to do the same.
  ///
  /// Only ever clears the one chat it arrived on, and only from a sender the
  /// signature already identified — there is no id in the body to point
  /// somewhere else with.
  Future<void> _conversationClear(
    InboundContext ctx,
    InnerPayloadType type,
    Uint8List body,
  ) async {
    final messages = _ref.read(messagesControllerProvider.notifier);
    final canonical = ctx.canonicalId;
    final sentAt = ctx.sentAt;
    // Bounded by the moment the clear was sent, which is what keeps a second
    // delivery of it from taking anything — see [clearForChatUpTo]. Clamped
    // to now for the same reason presence clamps: the stamp is the sender's
    // `created_at`, a claim rather than a fact, and one dated in the future
    // would erase messages that have not been written yet.
    //
    // Falling back to now with no stamp is the BLE path, which has no backlog
    // to replay and so behaves exactly as it did.
    final now = DateTime.now();
    final upTo = (sentAt == null || sentAt.isAfter(now)) ? now : sentAt;
    await messages.clearForChatUpTo(canonical, upTo);
    if (canonical != ctx.linkPeerId) {
      await messages.clearForChatUpTo(ctx.linkPeerId, upTo);
    }
    DebugLog.instance.log(
      'CHAT',
      '$canonical cleared the conversation here (up to $upTo)',
    );
  }

  /// The peer asked that this conversation not be copied or forwarded.
  ///
  /// Stored beside our own setting rather than into it, so neither side can
  /// switch off what the other asked for. Only ever applies to the chat it
  /// arrived on: like the conversation clear, there is no id in the body that
  /// could point somewhere else.
  Future<void> _copyRestriction(
    InboundContext ctx,
    InnerPayloadType type,
    Uint8List body,
  ) async {
    if (body.isEmpty) return;
    final canonical = ctx.canonicalId;
    final restricted = body[0] == 0x01;
    final settings = _ref.read(conversationSettingsControllerProvider.notifier);
    await settings.loaded;
    for (final bucket in ctx.buckets) {
      await settings.setPeerRestrictsCopying(bucket, restricted);
    }
    DebugLog.instance.log(
        'CHAT',
        '$canonical asks that this chat is '
            '${restricted ? "not copied or forwarded" : "copyable again"}');
  }

  // --------------------------------- rooms ---------------------------------

  void _roomText(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final channel = ctx.channel!;
    final plaintext = utf8.decode(
      unpadTextPayload(body),
      allowMalformed: true,
    );
    // A map beacon, as in a one-to-one chat: transport in a text message's
    // clothes, recorded on the map and never filed as a post.
    final arrivedAt = DateTime.now();
    final beacon = SharedLocation.tryParse(plaintext);
    if (beacon != null && SharedLocation.isBeaconText(plaintext, arrivedAt)) {
      _ref.read(mapPresenceStoreProvider.notifier).record(
            ctx.authorId!,
            beacon,
            sentAt: arrivedAt,
          );
      return;
    }
    final message = Message(
      id: 'm${DateTime.now().microsecondsSinceEpoch}',
      chatId: channel.name,
      text: plaintext,
      sentAt: DateTime.now(),
      isMine: false,
      wireId: ctx.wireId,
      authorName: ctx.authorName,
      // The fingerprint, not the name: an inbound edit is checked
      // against it, and display names are not identities.
      authorId: ctx.authorId,
      route: ctx.route,
      routeHops: ctx.routeHops,
    );
    _ref
        .read(incomingMessagesProvider)
        .fileInRoom(channel, authorName: ctx.authorName!, message: message);
  }

  void _roomTextReply(
    InboundContext ctx,
    InnerPayloadType type,
    Uint8List body,
  ) {
    final channel = ctx.channel!;
    final reply = unpackTextReply(body);
    final plaintext = utf8.decode(
      unpadTextPayload(reply.paddedText),
      allowMalformed: true,
    );
    final message = Message(
      id: 'm${DateTime.now().microsecondsSinceEpoch}',
      chatId: channel.name,
      text: plaintext,
      sentAt: DateTime.now(),
      isMine: false,
      wireId: ctx.wireId,
      authorName: ctx.authorName,
      authorId: ctx.authorId,
      replyToWireId: TransportEnvelope.hashHex(reply.targetMsgId),
      route: ctx.route,
      routeHops: ctx.routeHops,
    );
    _ref
        .read(incomingMessagesProvider)
        .fileInRoom(channel, authorName: ctx.authorName!, message: message);
  }

  void _roomReaction(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final rx = Reaction.decode(body);
    _applyReaction([ctx.channel!.name], rx: rx, reactorId: ctx.authorId!);
  }

  void _roomEdit(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final edit = MessageEdit.decode(body);
    // The author id is the signer's key fingerprint, and only the author of
    // the target message may rewrite it.
    _ref.read(messagesControllerProvider.notifier).editFromPeer(
          ctx.channel!.name,
          TransportEnvelope.hashHex(edit.targetMsgId),
          edit.text,
          authorId: ctx.authorId,
        );
  }

  void _roomDelete(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final del = MessageDelete.decode(body);
    _ref.read(messagesControllerProvider.notifier).deleteFromPeer(
          ctx.channel!.name,
          TransportEnvelope.hashHex(del.targetMsgId),
          authorId: ctx.authorId,
        );
  }

  void _roomPin(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final pin = MessagePin.decode(body);
    // Any member may pin in a channel, so no author guard (see sendPin).
    _applyPin(
      [ctx.channel!.name],
      target: TransportEnvelope.hashHex(pin.targetMsgId),
      pinned: pin.op == PinOp.pin,
    );
  }

  /// The channel counterpart of [_receipt]: record *who* read, rather than
  /// flipping a status.
  ///
  /// A 1:1 receipt can move [MessageStatus.read] because there is only one
  /// person it could have come from. A channel has as many readers as hold the
  /// key and no roster to enumerate them, so the answer to "has this been read"
  /// is a list of the people who said so — accumulated per reader, exactly the
  /// way reactions accumulate per reactor.
  ///
  /// The reader's id and name are the ones the transport already derived from
  /// the frame's signature, so identity here is as strong as it is for
  /// authorship: a relay cannot invent a reader. The local privacy switch
  /// controls what this device sends; a member who chooses to send a receipt
  /// only moves ticks on our own messages.
  void _roomReceipt(InboundContext ctx, InnerPayloadType type, Uint8List body) {
    final channel = ctx.channel!;
    final ReadReceipt r;
    try {
      r = ReadReceipt.decode(body);
    } catch (e) {
      DebugLog.instance.log('RECEIPT', 'drop ${channel.name} receipt: $e');
      return;
    }
    if (r.status != ReceiptStatus.read) return;
    _ref.read(messagesControllerProvider.notifier).applyChannelRead(
          channel.name,
          readerId: ctx.authorId!,
          readerName: ctx.authorName!,
          wireIds: r.msgIds.map(TransportEnvelope.hashHex).toSet(),
          at: DateTime.now(),
        );
  }

  // -------------------------------- shared --------------------------------

  void _applyReaction(
    List<String> buckets, {
    required Reaction rx,
    required String reactorId,
  }) {
    final messages = _ref.read(messagesControllerProvider.notifier);
    final target = TransportEnvelope.hashHex(rx.targetMsgId);
    for (final b in buckets) {
      messages.applyReaction(
        b,
        targetWireId: target,
        emoji: rx.emoji,
        reactorId: reactorId,
        add: rx.op == ReactionOp.add,
      );
    }
  }

  void _applyPin(
    List<String> buckets, {
    required String target,
    required bool pinned,
  }) {
    final pins = _ref.read(pinnedControllerProvider.notifier);
    for (final b in buckets) {
      if (pinned) {
        unawaited(pins.pin(b, target));
      } else {
        unawaited(pins.unpin(b, wireId: target));
      }
    }
    DebugLog.instance
        .log('PIN', '${pinned ? 'pinned' : 'unpinned'} $target from peer');
  }

  static String _short(String id) => id.length > 8 ? id.substring(0, 8) : id;
}
