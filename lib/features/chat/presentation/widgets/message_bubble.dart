import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/routing/back_gesture.dart';
import '../../../../core/util/platform_capabilities.dart';
import '../../../../core/routing/page_transitions.dart';
import '../../../../core/identity/nickname_controller.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/transport/messaging_service.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/util/debug_log.dart';
import '../../../../core/util/motion.dart';
import '../../../../core/widgets/value_pop.dart';
import '../../../../core/util/frame_stats.dart';
import '../../../../core/util/transition_probe.dart';
import '../../../../core/transport/shared_contact.dart';
import '../../../../core/transport/shared_location.dart';
import '../../../../core/utils/time_format.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/glass_toast.dart';
import '../../../../core/widgets/undo_toast.dart';
import '../../../channels/data/channel_controller.dart';
import '../../../channels/models/channel.dart' show channelForCommunity;
import '../../../channels/presentation/post_comments_screen.dart';
import '../../../../core/crypto/identity_service.dart';
import '../../../../core/identity/avatar_controller.dart';
import '../../../../core/widgets/identity_avatar.dart';
import '../../../peers/data/known_peers_controller.dart';
import '../../../moderation/domain/report.dart';
import '../../../moderation/presentation/report_sheet.dart';
import '../../../moderation/domain/profanity.dart';
import '../../../moderation/data/filter_settings.dart';
import '../../../peers/presentation/widgets/peer_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../airdrop/data/airdrop_source.dart';
import '../../../airdrop/presentation/airdrop_send_flow.dart';
import '../../../chats/models/chat.dart';
import '../../../chats/presentation/widgets/chat_picker_screen.dart';
import '../../data/chat_navigation.dart';
import '../../data/media_send_progress.dart';
import '../../data/message_farewell.dart';
import '../../data/message_selection.dart';
import '../../data/conversation_settings_controller.dart';
import '../../data/message_edit_target.dart';
import '../../data/message_reply_target.dart';
import '../../data/messages_controller.dart';
import '../../domain/message_preview.dart';
import '../../domain/message_route_badge.dart';
import '../../../../core/util/haptics.dart';
import '../../../call/data/call_controller.dart';
import '../../../call/domain/call_record.dart';
import '../../../call/presentation/call_screen.dart' show callClock;
import '../../data/pinned_controller.dart';
import '../../data/reaction_emoji_controller.dart';
import '../../../map/data/map_friend_link.dart';
import '../../../channels/data/channel_roster_controller.dart';
import '../../../map/data/map_friends_controller.dart';
import '../../../map/data/map_presence_controller.dart';
import '../../../map/presentation/map_sharing_consent.dart';
import '../../../profile/data/privacy_settings_controller.dart';
import '../../data/translation_controller.dart';
import '../../data/voice_transcription_controller.dart';
import '../../../chats/data/saved_messages.dart';
import '../../../chats/data/saved_tags_controller.dart';
import '../../../stickers/data/sticker_library.dart';
import '../../../stickers/data/sticker_pack.dart';
import 'emoji_picker_sheet.dart';
import 'message_spotlight.dart';
import '../../models/message.dart';
import '../chat_media_gallery_screen.dart';
import '../view_once_media_screen.dart';
import '../../../../core/util/media_storage.dart';
import 'auto_delete_picker.dart';
import 'file_bubble.dart';
import 'video_bubble.dart';
import 'photo_flight.dart';
import 'poll_bubble.dart';
import 'mention_text.dart';
import 'everyone_dialog.dart';
import 'pin_scope.dart';
import 'voice_bubble.dart';
import 'transcription_button.dart';

/// How far a bubble follows a leftward drag before it stops moving, and how far
/// it has to travel for the release to mean "reply".
///
/// The gap between the two is deliberate: the bubble keeps moving a little
/// after the threshold so there is visible confirmation the gesture took, and
/// the hint icon has somewhere to finish arriving.
/// The words in a message, or null when it has none.
///
/// Not [Message.text], which is only words for a text message: a photo keeps
/// its mime type there and a sticker keeps its marker, so "copy" on a picture
/// put `image/jpeg` on the clipboard. A photo's words are its caption, and most
/// photos have none.
String? copyableText(Message message) {
  final words = switch (message.kind) {
    MessageKind.image => message.imageCaption,
    MessageKind.text => message.text,
    MessageKind.audio || MessageKind.file || MessageKind.poll => null,
  };
  final trimmed = words?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

bool messageCanBeCopied(
  Message message, {
  required bool copyingRestricted,
}) =>
    // A view-once photo is excluded even though its *caption* is text. The
    // bytes never leave either way, but offering Copy and Forward on something
    // the app has just promised to destroy reads as the promise not being
    // meant.
    !copyingRestricted && !message.viewOnce && copyableText(message) != null;

/// A picture can be passed on as well as a line of text.
///
/// It could not before, and the reason was an implementation detail wearing the
/// clothes of a rule: forwarding re-sends under our own identity, the text path
/// had a re-send and the media path did not, so "forward" quietly meant "if it
/// is words". Sending a photo on is the commonest forward there is — the bytes
/// are already on this phone, and [forwardMessageTo] reads them and sends them
/// the way the gallery does.
///
/// View-once is still excluded, for the reason above: the promise is that it
/// exists once.
bool messageCanBeForwarded(
  Message message, {
  required bool copyingRestricted,
}) {
  if (copyingRestricted || message.viewOnce) return false;
  return switch (message.kind) {
    MessageKind.image => MediaPaths.existsOrNull(message.imagePath),
    MessageKind.text => message.text.trim().isNotEmpty,
    // Asked for by name: voice notes, circles and files forward like photos
    // ("всё это можно было перекидывать"). A circle is a file with the circle
    // name, so it goes on as a circle.
    MessageKind.audio => MediaPaths.existsOrNull(message.audioPath),
    MessageKind.file => MediaPaths.existsOrNull(message.filePath),
    // A poll is a live object with votes, not content; forwarding one would
    // be a second poll nobody could tie to the first.
    MessageKind.poll => false,
  };
}

/// How far a bubble is pulled before the swipe means "reply".
///
/// Forty-six, down from fifty-six, and the pull it can travel comes down with
/// it. Every one of these gestures ends in the same place, so distance asked
/// for and not needed is paid on all of them — the same reason the page's own
/// back gesture stopped asking for a third of the screen.
const double _swipeTrigger = 46;
const double _swipeMax = 64;

/// How wide a photo is drawn in a bubble.
///
/// It used to be a flat 220 points, which on a modern phone is a third of the
/// screen — a picture sent to be looked at, shown as a stamp, with the bubble's
/// own width unused around it. A share of the screen instead, clamped so it
/// stays inside the 75% the bubble itself is allowed and so a small phone does
/// not end up with something smaller than the old fixed size.
double photoBubbleWidth(BuildContext context) =>
    (MediaQuery.sizeOf(context).width * 0.68).clamp(220.0, 300.0);

/// A sticker is a gesture, not content: it keeps a size of its own, and a
/// larger one stops being an aside and starts being an announcement.
const double kStickerWidth = 158;

/// Ask which chats to forward into. Empty when the picker was dismissed.
///

/// Ask which chats to forward into. Empty when the picker was dismissed.
///
/// Used by the single-message menu and by the multi-select bar, so the two
/// cannot drift into offering different target lists.
///
/// It was a dialog that could only be answered once: sending the same message
/// to three people meant opening it three times, and its list stood four rows
/// tall on a phone with room for twelve. See [showChatPicker].
Future<List<Chat>> pickForwardTargets(
  BuildContext context,
  WidgetRef ref,
  String fromChatId, {
  // Off for a file or a circle: a room carries no files.
  bool includeChannels = true,
}) =>
    showChatPicker(
      context,
      title: AppLocalizations.of(context).chatForwardTitle,
      exceptChatId: fromChatId,
      includeChannels: includeChannels,
      // Saved as a destination too, asked for as "forward into other chats
      // and into Saved with the forward button". It is a copy on this phone,
      // not a send — see [forwardMessageTo].
      includeSaved: true,
    );

/// Re-send [text] into [target] under our own identity.
///
/// Forwarding is a fresh send, not a relay of the original frame: the original
/// is encrypted to a session the new chat has no key for, so it could not be
/// passed along even if we wanted to.
Future<Message?> forwardTextTo(WidgetRef ref, Chat target, String text) async {
  final messaging = ref.read(messagingServiceProvider);
  if (target.isChannel) {
    await messaging.sendChannelText(target.id, text);
    return null;
  }
  return messaging.sendText(target.id, text);
}

/// Pass [message] on to [target], whatever it is made of.
///
/// A fresh send under our own identity, not a relay of the original frame:
/// the original is encrypted to a session the new chat has no key for, so it
/// could not be passed along even if we wanted it to be. For a picture that
/// means reading the bytes back off this phone and sending them the way the
/// gallery does — caption and sticker marker included, so a forwarded sticker
/// arrives as a sticker rather than as a photo of one.
/// [fromChatId] is the bucket [message] was read out of, and it is not the same
/// thing as `message.chatId`.
///
/// An inbound message records the *transport* peer it arrived over — a BLE
/// address, or the relay's own id — while the conversation it is filed under is
/// the sender's pubkey. Asking the message where it came from therefore
/// answered with something the contacts roster has never heard of, which is why
/// the line above a forward was empty: the name lookup found nobody, and the
/// whole attribution returned before it began. The bucket is the answer, and
/// only the caller has it.
Future<void> forwardMessageTo(
  WidgetRef ref,
  Chat target,
  Message message, {
  required String fromChatId,
}) async {
  // Saved is a notebook on this phone: a copy, not a send.
  if (isSavedChat(target.id)) {
    await ref.read(savedMessagesControllerProvider).saveCopyOf(message);
    return;
  }
  if (message.kind == MessageKind.audio) {
    final path = MediaPaths.repairOrNull(message.audioPath);
    if (path == null || !MediaPaths.exists(path)) return;
    if (target.isChannel) {
      // A room carries voice through its own path.
      await ref.read(messagingServiceProvider).sendChannelAudio(
            target.id,
            bytes: await File(path).readAsBytes(),
            mime: message.audioMime ?? 'audio/ogg',
            durationMs: message.audioDurationMs ?? 0,
          );
      return;
    }
    final sent = await ref.read(messagingServiceProvider).sendAudio(
          target.id,
          bytes: await File(path).readAsBytes(),
          mime: message.audioMime ?? 'audio/ogg',
          durationMs: message.audioDurationMs ?? 0,
          // Stored as the 0..255 bars that travelled; the send wants 0..1.
          levels: message.audioLevels?.map((b) => b / 255).toList(),
        );
    await _attributeForward(ref, target, message, sent, fromChatId);
    return;
  }
  if (message.kind == MessageKind.file) {
    final path = MediaPaths.repairOrNull(message.filePath);
    if (path == null || !MediaPaths.exists(path) || target.isChannel) return;
    final sent = await ref.read(messagingServiceProvider).sendFile(
          target.id,
          file: File(path),
          fileName: message.fileName ?? 'file',
          mime:
              message.text.isEmpty ? 'application/octet-stream' : message.text,
        );
    await _attributeForward(ref, target, message, sent, fromChatId);
    return;
  }
  if (message.kind == MessageKind.image) {
    final path = MediaPaths.repairOrNull(message.imagePath);
    if (path == null || !MediaPaths.exists(path)) return;
    final bytes = await File(path).readAsBytes();
    // Attributed like anything else. A photo used to return here, so a
    // forwarded picture arrived with no line above it at all — the one kind of
    // forward where "who sent me this" is asked most often.
    final sent = await ref.read(messagingServiceProvider).sendImage(
          target.id,
          bytes: bytes,
          mime: message.imageMime ?? 'image/jpeg',
          cachedPath: path,
          caption: message.isSticker
              ? Message.stickerMarkerFor(message.stickerEmoji)
              : message.imageCaption,
        );
    await _attributeForward(ref, target, message, sent, fromChatId);
    return;
  }
  final sent = await forwardTextTo(ref, target, message.text);
  await _attributeForward(ref, target, message, sent, fromChatId);
}

/// Tell the far side who wrote this originally.
///
/// Sent after the message and never allowed to take it down with it: an
/// attribution that fails costs a line above a bubble, and the bubble is the
/// part that matters. 1:1 only — a room would need the name to survive the
/// relay fan-out, and nobody has asked for that.
///
/// Only when there is a name to give: a message of our own being passed on is
/// not "forwarded from" anybody, and forwarding what a peer sent carries the
/// name we know them by.
Future<void> _attributeForward(
  WidgetRef ref,
  Chat target,
  Message original,
  Message? sent,
  String fromChatId,
) async {
  if (target.isChannel) return;
  final wireId = sent?.wireId;
  if (wireId == null) return;
  final name = _forwardAuthorName(ref, original, fromChatId);
  if (name == null || name.isEmpty) return;
  // Two answers to the same question, because the two ends mean different
  // things by "us". Our own key names a contact on their phone and names
  // nobody on this one — see [Message.selfAuthorId].
  final wireAuthorId = await _forwardWireAuthorId(ref, original, fromChatId);
  final localAuthorId = _forwardLocalAuthorId(ref, original, fromChatId);
  // Stamped here, on our own copy, before anything goes out.
  //
  // The attribution used to exist only as a frame sent to the other side, so
  // the person doing the forwarding saw their own message with no line above
  // it — no name, no space where one might be — and had no way to tell whether
  // the header had been sent at all. It is the same fact on both phones and it
  // should appear on both.
  ref.read(messagesControllerProvider.notifier).applyForwardedFrom(
        target.id,
        wireId,
        name,
        authorId: localAuthorId,
      );
  await ref.read(messagingServiceProvider).announceForwardedFrom(
        canonicalId: target.id,
        wireIdHex: wireId,
        name: name,
        authorId: wireAuthorId,
      );
}

/// Whose name goes above a forwarded message.
///
/// This is what was missing entirely. It used to read `forwardedFrom ??
/// authorName`, and `authorName` is set only on channel messages — a room
/// mixes senders and has to say which one. A 1:1 message has no author field
/// because the chat itself is the answer, so every forward out of a private
/// conversation came back null here and returned: no header, no name, and
/// nothing to suggest one had been intended.
///
/// The chat is the answer, so it is used: the contact we hold for that bucket,
/// falling back to the name the chat list shows. Our own message keeps our own
/// name rather than none — passing on something we said is still a forward,
/// and a bubble that suddenly claims to be original is worse than one that
/// says where it came from.
String? _forwardAuthorName(
  WidgetRef ref,
  Message original,
  String fromChatId,
) {
  final carried = original.forwardedFrom ?? original.authorName;
  if (carried != null && carried.isNotEmpty) return carried;
  if (original.isMine) {
    final me = ref.read(nicknameControllerProvider).trim();
    return me.isEmpty ? null : me;
  }
  final peer = ref.read(knownPeersControllerProvider)[fromChatId];
  final name = peer?.displayName.trim();
  return (name == null || name.isEmpty) ? null : name;
}

/// Whose profile the line above a forward should open, if anybody's.
///
/// Three ways it comes back null, and each is a different "no":
///
///  * the author asked not to be linked to — their own setting, which reached
///    us with the rest of what we know about them;
///  * they said it in a room, where a signed frame reveals a fingerprint and
///    not a way to reach anybody;
///  * it was ours to begin with, and a forward of our own words is not
///    attributed to us at all.
///
/// A message that was already a forward keeps pointing at whoever wrote it
/// rather than at whoever passed it on, which is what makes a chain of them
/// still lead somewhere useful.
String? _forwardLocalAuthorId(
  WidgetRef ref,
  Message original,
  String fromChatId,
) {
  final earlier = original.forwardedFromId;
  if (_isOurs(original, earlier)) {
    // Our own switch decides this one too. Saying "do not link back to me" and
    // then linking to ourselves would be the app disagreeing with a setting in
    // the only place the setting is not enforced by somebody else's build.
    return ref.read(privacySettingsProvider).allowForwardLink
        ? Message.selfAuthorId
        : null;
  }
  final id = earlier ?? fromChatId;
  if (id.startsWith('#') || id.length != 64) return null;
  return ref.read(knownPeersControllerProvider.notifier).allowsForwardLink(id)
      ? id
      : null;
}

/// The same answer for the other phone, where our key is an ordinary contact.
///
/// Resolved through the identity, which is why this one is async: nothing
/// holds our own canonical id synchronously, and it is wanted here about once
/// per forward.
Future<String?> _forwardWireAuthorId(
  WidgetRef ref,
  Message original,
  String fromChatId,
) async {
  final earlier = original.forwardedFromId;
  if (_isOurs(original, earlier)) {
    if (!ref.read(privacySettingsProvider).allowForwardLink) return null;
    final identity = await ref.read(identityProvider.future);
    return [
      for (final b in identity.publicKey) b.toRadixString(16).padLeft(2, '0'),
    ].join();
  }
  return _forwardLocalAuthorId(ref, original, fromChatId);
}

/// Whether the words being passed on are ours.
///
/// A forward of a forward keeps pointing at whoever wrote the thing, so an
/// attribution already marked as ours stays ours however many hands it has
/// been through.
bool _isOurs(Message original, String? earlier) =>
    earlier == Message.selfAuthorId || (earlier == null && original.isMine);

/// A row that takes [rise] of its child's height, with the child pinned to
/// its top and hanging out of its bottom — unclipped, so what has not yet
/// risen into the row is still drawn below it. See `_MessageBubbleState._rise`.
///
/// At rest ([rise] at 1) it lays out exactly as its child. The [Align] stays
/// in the tree then too: dropping it when the rise ends would change the
/// shape above the bubble and rebuild everything in it — a playing circle, a
/// swipe in progress — from nothing.
class _RiseIn extends AnimatedWidget {
  const _RiseIn({required Animation<double> rise, required this.child})
      : super(listenable: rise);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final f = (listenable as Animation<double>).value;
    return Align(
      alignment: Alignment.topCenter,
      // Its child's width, as the transitions it replaced were: a bubble is
      // also drawn outside the list, where the width is not tight.
      widthFactor: 1,
      heightFactor: f.clamp(0.0, 1.0),
      child: child,
    );
  }
}

class MessageBubble extends ConsumerStatefulWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.chatId,
    this.album,
    this.animateEntry = false,
  });

  final Message message;

  /// The chat this bubble lives in (pubkey-hex peer id or `#channel`). Needed
  /// to route a reaction back over the wire.
  final String chatId;

  /// Every photo of the batch this message opens, [message] included, or null
  /// for a picture that arrived on its own.
  ///
  /// The bubble stays one message's bubble — its timestamp, ticks, reactions,
  /// reply and menu are still [message]'s. Only the payload becomes the grid,
  /// which is what keeps a batch of nine photos from being nine bubbles. The
  /// grouping itself is `groupPhotoAlbums`, in the chat data layer.
  final List<Message>? album;

  /// True only for a message the local user has just sent. Old rows should not
  /// replay their entrance every time a virtualized list rebuilds them.
  final bool animateEntry;

  @override
  ConsumerState<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends ConsumerState<MessageBubble>
    with TickerProviderStateMixin {
  bool _revealedFiltered = false;

  /// Created in [initState], not lazily at first use. The filter's folded
  /// row returns from [build] before anything touches these, and a lazy
  /// controller first created in [dispose] looks up TickerMode on a
  /// deactivated element — an assertion every time a folded bubble scrolled
  /// away (review of the Codex handoff, 2026-09-25). Every bubble that is
  /// not folded created both in its first build anyway.
  late final AnimationController _c;

  /// Drives the spring back to rest after a swipe-to-reply, whether or not the
  /// gesture crossed the threshold.
  late final AnimationController _swipe;

  /// Current horizontal offset of the bubble; never positive (this gesture only
  /// goes left) and never past [_swipeMax].
  ///
  /// A notifier rather than a field, and moved with `.value` rather than
  /// `setState`, because of what sits underneath it. Rebuilding this widget
  /// rebuilds the whole bubble — the photo, the caption, the reaction row, the
  /// read-by chip, every `MediaQuery` and localization lookup in the subtree —
  /// and the offset was being changed twice per gesture at frame rate: once per
  /// pointer move while the finger drags, then again on every tick of the
  /// spring coming home. On a 120 Hz screen that was the entire bubble rebuilt
  /// a hundred times a second to move it sideways by a few pixels, which is
  /// what made the swipe tear.
  ///
  /// The subtree is now built once and handed to [ValueListenableBuilder] as
  /// `child`, so a frame of this gesture costs one `Transform.translate` and
  /// nothing else. The animation is unchanged — same curve, same duration, same
  /// distance; only the per-frame bill for it is gone.
  final ValueNotifier<double> _dragX = ValueNotifier<double>(0);

  /// Where the spring started, so the animation can interpolate home.
  double _swipeFrom = 0;

  /// True once the drag is far enough that releasing would file a reply. Held
  /// separately from the offset so crossing the line can fire its own haptic
  /// exactly once.
  bool _armed = false;

  /// How much of its own height the row has taken so far, 0 to 1.
  ///
  /// The entrance is Telegram's: the conversation rises to make room and the
  /// new bubble rises with it, out from behind the composer. It used to fade
  /// in where it stood, nudged and scaled, over 360 ms — while every message
  /// above jumped up by its whole height on the first frame. The one thing
  /// that moved smoothly was the one thing that had not moved anywhere, which
  /// is what "дерганая и не понятная" (2026-10-15) was describing.
  ///
  /// The row's height grows, so the list — reversed, anchored at the bottom —
  /// lifts everything above it by the same amount each frame; the bubble is
  /// pinned to the top of that growing row and overhangs its bottom, so it is
  /// carried up from below the list's edge, behind the composer's glass.
  late final Animation<double> _rise =
      CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);

  /// A quick fade under the rise, so the first frames are not a hard edge
  /// sliding out from behind the glass.
  late final Animation<double> _fade = CurvedAnimation(
    parent: _c,
    curve: const Interval(0, 0.45, curve: Curves.easeOut),
  );

  /// Whether this bubble was built to rise in. Decided once: the rise's
  /// wrappers are in the tree for the life of a bubble that has them, and
  /// absent for the life of one that does not — which is nearly all of them,
  /// since only a message just sent rises.
  late final bool _entering;

  @override
  void initState() {
    super.initState();
    _entering = widget.animateEntry;
    _c = AnimationController(
      vsync: this,
      // Telegram's pace for a sent message: quick to clear the field, slow
      // to settle.
      duration: const Duration(milliseconds: 320),
      value: widget.animateEntry ? 0 : 1,
    );
    _swipe = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(() {
        if (_swipeFrom == 0) return;
        _dragX.value =
            _swipeFrom * (1 - Curves.easeOutCubic.transform(_swipe.value));
      });
    if (widget.animateEntry) _c.forward();
  }

  /// Reactions that landed in the latest change, which grow in instead of
  /// being there. Worked out from the change alone, so a bubble scrolled back
  /// into view — a brand new State — shows its reactions as they are.
  Set<String> _freshReactions = const {};

  /// Reactions just taken off, drawn a moment longer while they shrink away.
  final Map<String, Set<String>> _leavingReactions = {};

  /// The order they were in, so one leaving from the middle does not jump to
  /// the end for the length of its exit.
  List<String> _reactionOrder = const [];
  Timer? _leavingTimer;

  static Set<String> _reactionsIn(Map<String, Set<String>> reactions) => {
        for (final entry in reactions.entries)
          if (entry.value.isNotEmpty) entry.key,
      };

  @override
  void didUpdateWidget(MessageBubble old) {
    super.didUpdateWidget(old);
    final was = _reactionsIn(old.message.reactions);
    final now = _reactionsIn(widget.message.reactions);
    if (AppMotion.reduced(context)) {
      _freshReactions = const {};
      _leavingReactions.clear();
      return;
    }
    _freshReactions = now.difference(was);
    _leavingReactions.removeWhere((emoji, _) => now.contains(emoji));
    final gone = was.difference(now);
    if (gone.isEmpty) return;
    _reactionOrder = {
      if (_leavingReactions.isNotEmpty) ..._reactionOrder,
      ...old.message.reactions.keys,
    }.toList();
    for (final emoji in gone) {
      _leavingReactions[emoji] = old.message.reactions[emoji]!;
    }
    _leavingTimer?.cancel();
    _leavingTimer = Timer(_ReactionArrival.travel, () {
      if (mounted) setState(_leavingReactions.clear);
    });
  }

  /// What the row draws: today's reactions, with any on their way out still
  /// in the places they had.
  Map<String, Set<String>> get _shownReactions {
    final now = widget.message.reactions;
    if (_leavingReactions.isEmpty) return now;
    return {
      for (final emoji in _reactionOrder)
        if (now[emoji]?.isNotEmpty ?? false)
          emoji: now[emoji]!
        else if (_leavingReactions[emoji] != null)
          emoji: _leavingReactions[emoji]!,
      for (final entry in now.entries)
        if (!_reactionOrder.contains(entry.key)) entry.key: entry.value,
    };
  }

  @override
  void dispose() {
    _leavingTimer?.cancel();
    _c.dispose();
    _swipe.dispose();
    _dragX.dispose();
    super.dispose();
  }

  bool get _canReact => widget.message.wireId != null;

  /// Whether this bubble carries a way into the room its comments live in.
  ///
  /// Any post in an announcement channel, ours included.
  ///
  /// Our own were excluded on the reasoning that the reader's bar already
  /// leads to the discussion — which is exactly backwards: the reader's bar is
  /// what somebody who *cannot* post gets, so the administrator, whose posts
  /// are all their own, had no way into the comments on any of them.
  ///
  /// A room where anybody may write is its own discussion and gets nothing.
  /// Nor does the discussion room itself, which would otherwise offer a link
  /// into its own discussion, and so on.
  bool get _showsComments {
    if (!widget.chatId.startsWith('#')) return false;
    if (channelForCommunity(widget.chatId) != null) return false;
    return ref.watch(channelControllerProvider)[widget.chatId]?.adminOnly ??
        false;
  }

  /// Open the person a card names — importing them first when the card is an
  /// invitation carrying the whole signed announcement.
  ///
  /// An invitation from a room is the one case where the profile would
  /// otherwise open on somebody the app knows nothing about: no prekey, no
  /// relay identity, nothing to send to. Importing is exactly what the QR
  /// scanner does with the same card, and it is what turns "a name from a
  /// channel" into a contact who can be written to.
  Future<void> _openSharedContact(SharedContact contact) async {
    final card = contact.card;
    if (card != null) {
      try {
        await ref.read(messagingServiceProvider).addContactFromCard(card);
      } catch (e) {
        // Already known, or our own card offered back to us. Neither is worth
        // stopping the tap over — the profile below is still the right place
        // to land.
        debugPrint('contact invitation import: $e');
      }
    }
    if (!mounted) return;
    context.push(
      '/person/${Uri.encodeComponent(contact.pubkeyHex)}'
      '?name=${Uri.encodeQueryComponent(contact.displayName)}',
    );
  }

  /// The words under the picture, or under the whole batch of them.
  ///
  /// A batch carries its caption on the first photo, which is where it was
  /// drawn — as if it described that one picture. Any member's caption is the
  /// album's, because there is only ever one.
  String? get _caption {
    // Only a picture has one. `imageCaption` is the caption *field*, and for a
    // message that is not an image that field holds the mime type — so a clip
    // reported a caption of "video/mp4" and was never drawn one. Harmless
    // until the clock moved onto the media, which asks this the question "is
    // there another line in this bubble already" and got yes.
    if (widget.message.kind != MessageKind.image) return null;
    final album = widget.album;
    if (album == null) return widget.message.imageCaption;
    for (final message in album) {
      final caption = message.imageCaption;
      if (caption != null) return caption;
    }
    return null;
  }

  /// A reply needs the transport id everyone else filed the message under, and
  /// somewhere to compose it — the composer only builds reply frames in 1:1,
  /// so offering the gesture in a channel would swallow it silently.
  bool get _canReply =>
      widget.message.wireId != null && !widget.chatId.startsWith('#');

  void _startReply() {
    final m = widget.message;
    ref.read(messageReplyTargetProvider.notifier).state = MessageReplyTarget(
      chatId: widget.chatId,
      wireId: m.wireId!,
      preview: _replyPreview(m, AppLocalizations.of(context)),
      mine: m.isMine,
      authorName: m.authorName,
    );
  }

  /// Double-tap: the one-gesture path to the reaction people actually use —
  /// which is now the last one *they* used, not a constant in this file.
  void _quickReact() {
    if (!_canReact) return;
    _toggleReaction(
      ref.read(reactionEmojiControllerProvider.notifier).quickReaction,
    );
  }

  /// Logged once per bubble, so a conversation that will not swipe says why in
  /// the diagnostics log instead of only in the reporter's description.
  ///
  /// Reading the code has not been enough: the gate is `wireId != null` and not
  /// a channel, both look right, and the id is both persisted and restored — so
  /// the next report needs to carry which half is false rather than another
  /// round of guessing.
  bool _swipeRefusalLogged = false;

  void _onSwipeUpdate(DragUpdateDetails d) {
    if (!_canReply) {
      if (!_swipeRefusalLogged) {
        _swipeRefusalLogged = true;
        DebugLog.instance.log(
          'REPLY',
          'swipe ignored: wireId=${widget.message.wireId == null ? 'null' : 'set'}'
              ' channel=${widget.chatId.startsWith('#')}'
              ' kind=${widget.message.kind.name}',
        );
      }
      return;
    }
    _swipe.stop();
    final next = (_dragX.value + d.delta.dx).clamp(-_swipeMax, 0.0);
    final armed = next <= -_swipeTrigger;
    // Fires as the threshold is crossed in either direction, so the finger is
    // told what a release would do while it can still change its mind.
    if (armed != _armed) HapticFeedback.selectionClick();
    // No setState: _armed is haptics-only and never read in build, and the
    // offset drives the transform through its own notifier.
    _dragX.value = next;
    _armed = armed;
  }

  void _onSwipeEnd() {
    if (!_canReply) return;
    if (_armed) {
      HapticFeedback.mediumImpact();
      _startReply();
    }
    _armed = false;
    _swipeFrom = _dragX.value;
    if (_swipeFrom != 0) _swipe.forward(from: 0);
  }

  /// Anything with words in it can be copied — including the caption on a
  /// photo. A voice note or a bare image has nothing to put on the clipboard.
  bool get _copyingRestricted =>
      ref
          .read(conversationSettingsControllerProvider)[widget.chatId]
          ?.copyingRestricted ??
      false;

  SharedContact? get _sharedContact => widget.message.kind == MessageKind.text
      ? SharedContact.tryParse(widget.message.text)
      : null;

  /// A position rides inside a text message — see [SharedLocation] for why —
  /// so it is recognised the same way a shared contact is.
  SharedLocation? get _sharedLocation => widget.message.kind == MessageKind.text
      ? SharedLocation.tryParse(widget.message.text)
      : null;

  MapFriendLink? get _mapFriendLink => widget.message.kind == MessageKind.text
      ? MapFriendLink.tryParse(widget.message.text)
      : null;

  bool get _canCopy =>
      widget.message.text.trim().isNotEmpty &&
      tryParseCallRecord(widget.message.text) == null;

  /// Forwarding re-sends the text into another chat, so it needs text for the
  /// same reason [_canCopy] does. Media isn't forwarded: the bytes live in a
  /// chat-scoped file and re-sending them is a different job from this one.
  bool get _canForward => _canCopy;

  /// Only your own text messages can be rewritten, and only if we know the
  /// transport id everyone else filed them under.
  bool get _canEdit =>
      widget.message.isMine &&
      widget.message.kind == MessageKind.text &&
      widget.message.wireId != null;

  void _toggleReaction(String emoji) {
    // One tick for every way in — the double-tap, the strip, the picker. It
    // used to be the double-tap's alone, at this same strength.
    Haptics.toggle();
    final mineSet = widget.message.reactions[emoji];
    final alreadyMine = mineSet != null && mineSet.contains('me');
    // Adding one is a choice worth learning from; taking one back is not, and
    // promoting an emoji you just removed would be the strip learning exactly
    // the wrong thing.
    if (!alreadyMine) {
      unawaited(
        ref.read(reactionEmojiControllerProvider.notifier).remember(emoji),
      );
    }
    ref.read(messagingServiceProvider).sendReaction(
          widget.chatId,
          widget.message.wireId!,
          emoji,
          add: !alreadyMine,
        );
  }

  /// A hold on the row, or a right click on a computer: the actions, or while
  /// a selection is running, one more tick.
  void _hold(Offset at, {required bool selecting}) {
    if (selecting) {
      ref
          .read(messageSelectionProvider(widget.chatId).notifier)
          .toggle(widget.message.id);
      HapticFeedback.selectionClick();
      return;
    }
    HapticFeedback.mediumImpact();
    unawaited(_showActions(at));
  }

  /// The whole keyboard, for the reaction the strip doesn't carry.
  Future<void> _reactFromPicker() async {
    final emoji = await showEmojiPicker(context);
    if (emoji == null || !mounted || !_canReact) return;
    _toggleReaction(emoji);
  }

  /// Hold a message and everything else steps back.
  ///
  /// This was a popup menu anchored at the finger, which answered "what can I
  /// do to this?" while the conversation carried on behind it at full contrast
  /// — so the message the menu was about was one of thirty similar objects on
  /// screen, and the reaction strip along the top of it was a row of emoji
  /// floating over somebody else's sentence. See [showMessageSpotlight]: the
  /// room blurs, the message stays lit where it already is, and the choices
  /// arrange themselves around it.
  ///
  /// The vocabulary it answers in is unchanged — `r:<emoji>`, `r+`, or an
  /// action id — so everything below this call is the same code it always was.
  Future<void> _showActions(Offset at) async {
    final t = AppLocalizations.of(context);
    final pinnedHere = widget.message.wireId != null &&
        ref
            .read(pinnedControllerProvider.notifier)
            .isPinned(widget.chatId, widget.message.wireId!);
    final strip = ref.read(reactionEmojiControllerProvider);

    // Where this row actually sits, so the lit copy lands exactly on top of the
    // real one. Falls back to the press point if the render object has gone,
    // which puts the menu at the finger — the old behaviour, and a reasonable
    // last resort.
    final box = context.findRenderObject() as RenderBox?;
    final anchor = box != null && box.hasSize
        ? box.localToGlobal(Offset.zero) & box.size
        : at & const Size(1, 1);

    final picked = await showMessageSpotlight(
      context: context,
      anchor: anchor,
      mine: widget.message.isMine,
      // The same widget from the same message, built again and made inert. A
      // snapshot would be a frame of nothing between the press and the menu,
      // and a screenful of pixels held for every long press.
      bubble: MessageBubble(
        message: widget.message,
        chatId: widget.chatId,
        album: widget.album,
      ),
      details: _detailsLines(t),
      // Six here, not five: the strip is its own bar now rather than a row
      // squeezed into a 280-point menu, so the picker button no longer costs a
      // slot.
      reactions: _canReact ? strip.take(6).toList() : const <String>[],
      actions: [
        if (widget.message.wireId != null)
          SpotlightAction(
            id: 'reply',
            icon: Icons.reply_rounded,
            label: t.chatReplyAction,
          ),
        // A pin is conversation state, so it needs the shared transport id —
        // and either side may pin either side's message.
        if (widget.message.wireId != null)
          SpotlightAction(
            id: pinnedHere ? 'unpin' : 'pin',
            icon: Icons.push_pin_rounded,
            label: pinnedHere ? t.chatUnpinAction : t.chatPinAction,
          ),
        if (messageCanBeCopied(
              widget.message,
              copyingRestricted: _copyingRestricted,
            ) &&
            !_copyingRestricted &&
            _canCopy)
          SpotlightAction(
            id: 'copy',
            icon: Icons.copy_rounded,
            label: t.chatCopyAction,
          ),
        if (messageCanBeForwarded(
              widget.message,
              copyingRestricted: _copyingRestricted,
            ) &&
            !_copyingRestricted &&
            _canForward)
          SpotlightAction(
            id: 'forward',
            icon: Icons.shortcut_rounded,
            label: t.chatForwardAction,
          ),
        // Ours and not gone yet: take it back. Text in the queue, a photo, a
        // voice note, a circle, a file — see [MessagingService.cancelSending].
        if (widget.message.isMine &&
            widget.message.status == MessageStatus.sending &&
            !isSavedChat(widget.chatId))
          SpotlightAction(
            id: 'cancel-send',
            icon: Icons.cancel_schedule_send_rounded,
            label: t.chatCancelSend,
            tone: AppColors.danger,
          ),
        // Keep the recording on the phone, where other apps can open it.
        if (_downloadablePath != null)
          SpotlightAction(
            id: 'download',
            icon: Icons.download_rounded,
            label: t.chatDownloadAction,
          ),
        // A photo, a video or a file on this phone, to somebody in arm's
        // reach. Not a view-once picture and not a chat that forbids copying:
        // AirDrop is exactly "take it elsewhere".
        if (_airdropPath != null)
          SpotlightAction(
            id: 'airdrop',
            icon: Icons.wifi_tethering_rounded,
            label: t.airdropAction,
          ),
        // Not inside Saved itself: filing a note into the pile it is already
        // in does nothing but duplicate it.
        if (!isSavedChat(widget.chatId))
          SpotlightAction(
            id: 'save',
            icon: Icons.bookmark_add_outlined,
            label: t.chatSaveAction,
          ),
        // Keep the same access as the existing on-device transcription action.
        if (widget.message.isVoiceNote &&
            MediaPaths.existsOrNull(widget.message.voiceNotePath) &&
            !_transcribing &&
            ref.read(voiceTranscriptionProvider)[widget.message.id] == null)
          SpotlightAction(
            id: 'transcribe',
            icon: Icons.record_voice_over_rounded,
            label: t.chatTranscribeAction,
          ),
        if (widget.message.kind == MessageKind.text &&
            widget.message.text.trim().isNotEmpty &&
            ref.read(translationProvider)[widget.message.id] == null)
          SpotlightAction(
            id: 'translate',
            icon: Icons.translate_rounded,
            label: t.chatTranslateAction,
          ),
        if (_canEdit)
          SpotlightAction(
            id: 'edit',
            icon: Icons.edit_rounded,
            label: t.chatEditAction,
          ),
        // Keep somebody else's sticker.
        //
        // A picture already had this, through the gallery's own menu — but a
        // sticker deliberately does not open a gallery (it is a gesture, not a
        // document, and the viewer would be a dead end to back out of), so the
        // one thing in a conversation most worth keeping was the one thing
        // with no way to keep it. Holding it is where its actions live, so
        // this belongs here.
        //
        // Hidden once it is already kept rather than shown as a no-op: the
        // library is a set, and offering to add what is in it twice is an
        // offer that does nothing.
        if (widget.message.isSticker &&
            widget.message.imagePath != null &&
            !ref
                .read(stickerLibraryProvider.notifier)
                .has(widget.message.imagePath!))
          SpotlightAction(
            id: 'keep-sticker',
            icon: Icons.auto_awesome_rounded,
            label: t.stickerKeep,
          ),
        // Saved-chat only: a tag is a way back to a note in a growing pile,
        // and there is no pile to file in a real conversation. Says "remove"
        // when one is already on, so the same entry both sets and clears.
        if (isSavedChat(widget.chatId))
          SpotlightAction(
            id: 'tag',
            icon: Icons.sell_rounded,
            label: ref.read(savedTagsProvider)[widget.message.id] == null
                ? AppLocalizations.of(context).savedTagMenuTag
                : AppLocalizations.of(context).savedTagRemove,
          ),
        // A deadline on this one line, where auto-delete is a rule for the
        // whole conversation. Local, like auto-delete: their copy is theirs.
        SpotlightAction(
          id: 'timer',
          icon: Icons.hourglass_bottom_rounded,
          label: widget.message.expiresAt == null
              ? t.chatTimerAction
              : t.chatTimerRemove,
        ),
        if (!widget.message.isMine && !isSavedChat(widget.chatId))
          SpotlightAction(
            id: 'report',
            icon: Icons.flag_outlined,
            label: t.reportAction,
          ),
        if (!widget.message.isMine)
          SpotlightAction(
            id: 'hide',
            icon: Icons.visibility_off_outlined,
            label: t.messageHide,
          ),
        SpotlightAction(
          id: 'delete',
          icon: Icons.delete_outline_rounded,
          label: t.chatDeleteAction,
          tone: AppColors.danger,
        ),
        // Last, and behind a line. Everything above acts on the message being
        // held; this one leaves it alone and puts the whole chat into picking
        // mode. It was first for a while, on the grounds that it is the way in
        // to every bulk action — but at the top it sat where the thing people
        // actually reached for should be, and flush against Delete it read as
        // one more thing that could happen to the message.
        SpotlightAction(
          id: 'select',
          icon: Icons.checklist_rounded,
          label: t.chatSelectAction,
          separated: true,
        ),
      ],
    );

    if (picked == null || !mounted) return;
    if (picked == 'r+') {
      await _reactFromPicker();
    } else if (picked.startsWith('r:')) {
      _toggleReaction(picked.substring(2));
    } else if (picked == 'timer') {
      await _promptTimer();
    } else if (picked == 'reply') {
      _startReply();
    } else if (picked == 'copy') {
      await Clipboard.setData(
        ClipboardData(text: copyableText(widget.message) ?? ''),
      );
      if (!mounted) return;
      showCopiedToast(context, t.chatCopied);
    } else if (picked == 'pin' || picked == 'unpin') {
      // The same question the selection toolbar asks — for both of us, or just
      // for me. It asked in one place and not the other, and this is the path
      // most people actually use, so the choice looked as though it had never
      // been added. See [togglePinWithScope].
      if (!mounted) return;
      await togglePinWithScope(
        context,
        ref,
        chatId: widget.chatId,
        wireId: widget.message.wireId!,
      );
    } else if (picked == 'keep-sticker') {
      await _keepSticker();
    } else if (picked == 'forward') {
      await _promptForward();
    } else if (picked == 'edit') {
      // Load the message into the input row (Telegram-style inline edit); the
      // input commits it on send.
      ref.read(messageEditTargetProvider.notifier).state = MessageEditTarget(
        chatId: widget.chatId,
        wireId: widget.message.wireId!,
        originalText: widget.message.text,
      );
    } else if (picked == 'select') {
      ref
          .read(messageSelectionProvider(widget.chatId).notifier)
          .start(widget.message.id);
    } else if (picked == 'cancel-send') {
      await _cancelSend();
    } else if (picked == 'download') {
      await _download();
    } else if (picked == 'airdrop') {
      await _airdrop();
    } else if (picked == 'save') {
      await _saveToSaved();
    } else if (picked == 'transcribe') {
      await _transcribeVoice();
    } else if (picked == 'translate') {
      await _translateMessage();
    } else if (picked == 'tag') {
      await _tagSavedMessage();
    } else if (picked == 'report') {
      await _reportMessage();
    } else if (picked == 'hide') {
      _hideMessage();
    } else if (picked == 'delete') {
      await _promptDelete();
    }
  }

  /// Read a message written in a language you do not have.
  ///
  /// Translated on the device: the text never reaches a server. The model for a
  /// language pair is fetched from Google once, which says which languages this
  /// phone wants and nothing else — no message and no fragment of one — and
  /// after that the work is offline.
  ///
  /// Into the language the interface is in, which is the one the reader has
  /// already said they read. A message already in it is left alone rather than
  /// answered with a copy of itself.
  Future<void> _translateMessage() async {
    final t = AppLocalizations.of(context);
    final target = Localizations.localeOf(context).languageCode;
    final text = await ref.read(translationProvider.notifier).translate(
          messageId: widget.message.id,
          text: widget.message.text,
          target: target,
        );
    if (!mounted || text != null) return;
    showGlassToast(context, t.chatTranslateFailed);
  }

  /// A transcription in flight from this bubble, and whether the last one came
  /// back empty — the "→A" button spins on the first, and the second puts an
  /// honest line under the note instead of a toast that is gone in two seconds.
  bool _transcribing = false;
  bool _transcriptionFailed = false;

  /// Read a voice note instead of listening to it.
  ///
  /// The recording never leaves the phone — both platforms recognise speech
  /// locally, and the native side refuses rather than falling back to a cloud
  /// recogniser. Posting the decrypted contents of a private message to
  /// somebody's API is the one thing this app exists not to do.
  ///
  /// A null means this device cannot: Android below 13, a language with no
  /// local model, a recogniser switched off. The voice note is untouched, so
  /// the honest thing to say is that there is no text, not that something
  /// broke.
  Future<void> _transcribeVoice() async {
    final path = widget.message.voiceNotePath;
    final controller = ref.read(voiceTranscriptionProvider.notifier);
    if (_transcribing ||
        controller.isRunning(widget.message.id) ||
        !MediaPaths.existsOrNull(path)) {
      return;
    }
    setState(() {
      _transcribing = true;
      _transcriptionFailed = false;
    });
    try {
      final text = await controller.transcribe(
        messageId: widget.message.id,
        audioPath: path!,
        localeId: Localizations.localeOf(context).toLanguageTag(),
      );
      if (mounted) setState(() => _transcriptionFailed = text == null);
    } catch (_) {
      if (mounted) setState(() => _transcriptionFailed = true);
    } finally {
      if (mounted) setState(() => _transcribing = false);
    }
  }

  /// Fold the transcript away, or bring it back — no second recognition.
  void _toggleTranscript() {
    final id = widget.message.id;
    final hidden = ref.read(hiddenTranscriptsProvider.notifier);
    hidden.state = hidden.state.contains(id)
        ? ({...hidden.state}..remove(id))
        : {...hidden.state, id};
  }

  Widget _transcriptionButton({
    bool circle = false,
    String? transcript,
    bool transcriptHidden = false,
  }) {
    // With the text on show the button folds it away ("↑"); folded, it is
    // "→A" again and brings the same text back at once.
    final shown = transcript != null && !transcriptHidden;
    return TranscriptionButton(
      loading: _transcribing,
      expanded: shown,
      onPressed: transcript != null
          ? _toggleTranscript
          : MediaPaths.existsOrNull(widget.message.voiceNotePath)
              ? _transcribeVoice
              : null,
      circle: circle,
      // Beside a circle it leaves once tapped, while recognition runs, and
      // comes back as "↑" with the text; a failure brings it back as "→A".
      hidden: circle && _transcribing && transcript == null,
      flyLeft: widget.message.isMine,
    );
  }

  /// Take this send back while it is still going — see
  /// [MessagingService.cancelSending].
  Future<void> _cancelSend() async {
    await ref
        .read(messagingServiceProvider)
        .cancelSending(widget.chatId, widget.message);
  }

  /// The recording this message holds, if it is one that can be kept on the
  /// phone: a voice note or a circle. Not a view-once one, and not in a chat
  /// whose owner switched copying off — that switch is about exactly this.
  String? get _airdropPath {
    final m = widget.message;
    if (m.viewOnce || _copyingRestricted || m.isSticker) return null;
    final path = switch (m.kind) {
      MessageKind.image => m.imagePath,
      MessageKind.file => m.filePath,
      _ => null,
    };
    return MediaPaths.existsOrNull(path) ? path : null;
  }

  /// "Долгое нажатие на фото, видео или файл в чате → AirDrop."
  Future<void> _airdrop() async {
    final path = _airdropPath;
    if (path == null) return;
    final source = await AirDropSource.fromFile(
      File(path),
      name: widget.message.fileName,
    );
    if (!mounted) return;
    await startAirDropSend(context, ref, files: [source]);
  }

  String? get _downloadablePath {
    final m = widget.message;
    if (m.viewOnce || _copyingRestricted) return null;
    final path = m.kind == MessageKind.audio
        ? m.audioPath
        : m.isCircle
            ? m.filePath
            : null;
    return MediaPaths.existsOrNull(path) ? path : null;
  }

  /// "Кружок или ГС ещё можно было бы скачать."
  ///
  /// A circle is a video and goes to the gallery, where the phone's own
  /// videos are. A voice note is audio, which the gallery does not take, so
  /// the system's own "save as" asks where to put it — Downloads, a music
  /// folder, a cloud drive.
  Future<void> _download() async {
    final t = AppLocalizations.of(context);
    final path = _downloadablePath;
    if (path == null) return;
    final m = widget.message;
    final stamp = m.sentAt
        .toIso8601String()
        .substring(0, 19)
        .replaceAll(':', '-')
        .replaceAll('T', '_');
    var ok = false;
    try {
      if (m.isCircle) {
        final result = await SaverGallery.saveFile(
          filePath: path,
          fileName: 'cubechat_circle_$stamp.mp4',
          skipIfExists: false,
        );
        ok = result.isSuccess;
      } else {
        final mime = m.audioMime ?? '';
        final ext = mime.contains('ogg') || mime.contains('opus')
            ? 'ogg'
            : mime.contains('wav')
                ? 'wav'
                : 'm4a';
        final saved = await FilePicker.platform.saveFile(
          fileName: 'cubechat_voice_$stamp.$ext',
          bytes: await File(path).readAsBytes(),
        );
        if (saved == null) return; // dismissed
        ok = true;
      }
    } catch (e) {
      DebugLog.instance.log('CHAT', 'download failed: $e');
    }
    if (!mounted) return;
    showGlassToast(
      context,
      ok ? t.chatDownloaded : t.chatDownloadFailed,
      icon: ok ? Icons.download_done_rounded : null,
      tone: ok ? ToastTone.success : ToastTone.danger,
    );
  }

  /// Keep a copy of this message in Saved.
  ///
  /// Nothing is sent: Saved is a chat with no peer and no session, so this is a
  /// local copy and the bytes of a picture or a file are copied in rather than
  /// referenced — the original can be deleted afterwards and the note survives.
  ///
  /// Asked for a tag right away, because the moment of saving is the only one
  /// where you still remember why you kept it.
  Future<void> _saveToSaved() async {
    final t = AppLocalizations.of(context);
    final id = await ref
        .read(savedMessagesControllerProvider)
        .saveCopyOf(widget.message);

    if (!mounted || id == null) return;

    // Cancel means "keep it, untagged" — the note is already saved, which is
    // why the title says so rather than asking whether to save at all.
    final wantsTag = await confirmAction(
      context,
      title: t.savedTagAsk,
      confirmLabel: t.savedTagAdd,
      destructive: false,
    );
    if (!wantsTag || !mounted) return;
    final emoji = await showEmojiPicker(context);
    if (emoji == null) return;
    await ref.read(savedTagsProvider.notifier).setTag(id, emoji);
  }

  /// Put an emoji tag on this saved note, or clear the one it has.
  ///
  /// Already tagged: one tap here takes it off, no picker — removing a tag is
  /// the common half of managing them and should not cost a sheet. Untagged:
  /// the same emoji picker the quick-reaction setting uses.
  Future<void> _tagSavedMessage() async {
    final tags = ref.read(savedTagsProvider.notifier);
    if (tags.tagFor(widget.message.id) != null) {
      await tags.setTag(widget.message.id, null);
      return;
    }
    final emoji = await showEmojiPicker(context);
    if (emoji == null || !mounted) return;
    await tags.setTag(widget.message.id, emoji);
  }

  /// The message [wireId] quotes, resolved from this chat's list, or null if
  /// it's not in memory (e.g. cleared history or arrived out of order).
  Message? _resolveQuoted(String wireId) {
    // This runs inside a bubble, and a bubble is on screen a dozen times over.
    // Watching the whole map made every visible reply bubble rebuild whenever
    // any chat changed anywhere — a status tick on a photo still sending, a
    // receipt, a message in a conversation nobody has open. Selecting this
    // chat's list hands back the same List instance for all of those, so they
    // compare equal and nothing rebuilds.
    final list = ref.watch(
      messagesControllerProvider.select((m) => m[widget.chatId]),
    );
    if (list == null) return null;
    for (final m in list) {
      if (m.wireId == wireId) return m;
    }
    return null;
  }

  /// The quote box shown at the top of a reply bubble.
  Widget _quotedBox(String wireId) {
    final quoted = _resolveQuoted(wireId);
    // What the reply was written against, if we wrote it: kept on the message
    // so the box says something even when the original cannot be found. It
    // could not be found rather often — a cleared history, a message filed
    // under a different id, one that has not arrived yet — and every one of
    // those drew a bare "…". Replying to a sticker drew it every time.
    //
    // The lookup still comes first, because it is live: an edited message
    // should quote as it reads now, not as it read when it was answered.
    final preview = quoted != null
        ? _replyPreview(quoted, AppLocalizations.of(context))
        : (widget.message.replyPreview ?? '…');
    // Tappable: a quote names a message, and the thing anyone wants from it is
    // to see the message. Nothing to go to when the original is gone, so the
    // tap is withheld rather than bouncing off a toast.
    return GestureDetector(
      onTap: quoted == null
          ? null
          : () => ref
              .read(chatJumpRequestProvider(widget.chatId).notifier)
              .state = wireId,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        decoration: BoxDecoration(
          color: AppColors.glass(0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(color: AppColors.brandPrimary, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (quoted?.authorName != null)
              Text(
                quoted!.authorName!,
                style: TextStyle(
                  color: AppColors.brandPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            Text(
              preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textOnGlassDim,
                fontSize: 13,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A one-line snippet of [m] for a reply preview / quote box.
  ///
  /// The same line the chat list and a notification show — one description of
  /// a message per app, not one per screen. A shared contact and a map link
  /// are the two things a quote can say more about than a list can: they are
  /// text on the wire, and the name inside them is the useful part.
  static String _replyPreview(Message m, AppLocalizations t) {
    final contact = SharedContact.tryParse(m.text);
    if (contact != null) return contact.displayName;
    final mapLink = MapFriendLink.tryParse(m.text);
    if (mapLink != null) return mapLink.displayName;
    // What it said, not what happened to it — see [messageContentPreview].
    final preview = messageContentPreview(m, t).replaceAll('\n', ' ').trim();
    return preview.length > 80 ? '${preview.substring(0, 80)}…' : preview;
  }

  /// Non-tappable first row of the long-press menu: when this message was sent
  /// and, for our own messages the peer has acknowledged, when they read it.
  ///
  /// This is where the read time lives rather than in the bubble: the bubble
  /// already carries a clock and a tick, and a second timestamp on every line
  /// would crowd the conversation for something you only look up occasionally.
  /// It works for a photo or a voice note exactly as it does for text — the
  /// long-press covers the whole bubble, and media now carries the wireId a
  /// receipt refers to.
  Widget _detailsLines(AppLocalizations t) {
    final m = widget.message;
    final readAt = m.readAt;
    // In a channel the answer to "who has seen this" is a list, because there
    // is no roster to count against — only the people who said so. Newest last,
    // so the order matches the order they arrived in.
    final readers = m.readBy.entries.toList()
      ..sort((a, b) => a.value.at.compareTo(b.value.at));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.chatSentAt(formatMessageDetailsTime(context, m.sentAt)),
          style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
        ),
        // The mark beside the time, said in words.
        if (routeBadgeFor(m) case final badge?)
          Text(
            m.isMine
                ? t.chatRouteDeliveredVia(messageRouteText(t, badge))
                : t.chatRouteReceivedVia(messageRouteText(t, badge)),
            style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
          ),
        if (readAt != null)
          Text(
            t.chatReadAt(formatMessageDetailsTime(context, readAt)),
            style: const TextStyle(
              color: _BubbleMeta._readColor,
              fontSize: 12,
            ),
          ),
        for (final r in readers)
          Text(
            '${r.value.name} · '
            '${formatMessageDetailsTime(context, r.value.at)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _BubbleMeta._readColor,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  /// Pick a chat and re-send this message's text into it.
  ///
  /// Forwarding is a fresh send, not a relay of the original frame: the text
  /// goes out under our own identity, signed and sealed for the new recipient.
  /// That is the only shape that works here — the original is encrypted to a
  /// session the new chat has no key for, so it could not be passed along even
  /// if we wanted to.
  /// Keep a sticker somebody sent, under an emoji of your choosing.
  ///
  /// A copy, not a reference — the same promise the gallery's version makes:
  /// the message can be deleted, the history cleared or the whole chat
  /// auto-expired, and a sticker that vanished with it would be a strange thing
  /// to have kept.
  ///
  /// The picker opens on its own rather than pre-filled with the emoji it
  /// arrived under: the sheet takes no starting value, and threading one
  /// through for this alone would be a parameter with a single caller.
  Future<void> _keepSticker() async {
    final path = widget.message.imagePath;
    if (path == null) return;
    final t = AppLocalizations.of(context);
    final emoji = await showEmojiPicker(context, title: t.stickerEmojiTitle);
    if (!mounted) return;
    final kept = await ref
        .read(stickerLibraryProvider.notifier)
        .keep(path, emoji: emoji);
    if (!mounted) return;
    showGlassToast(
      context,
      kept ? t.stickerKept : t.stickerFailed,
      icon: kept ? Icons.auto_awesome_rounded : null,
      tone: kept ? ToastTone.success : ToastTone.danger,
    );
  }

  Future<void> _promptForward() async {
    final chosen = await pickForwardTargets(
      context,
      ref,
      widget.chatId,
      includeChannels: widget.message.kind != MessageKind.file,
    );
    if (chosen.isEmpty || !mounted) return;
    final t = AppLocalizations.of(context);
    for (final chat in chosen) {
      await forwardMessageTo(
        ref,
        chat,
        widget.message,
        fromChatId: widget.chatId,
      );
    }
    if (!mounted) return;
    showGlassToast(
      context,
      chosen.length == 1
          ? t.chatForwardSent(chosen.first.peerName)
          : t.chatForwardSentCount(chosen.length),
      icon: Icons.shortcut_rounded,
      tone: ToastTone.success,
    );
  }

  /// Put a deadline on this one message, or take it off.
  ///
  /// Reuses the auto-delete picker: the choice is the same shape — a duration
  /// with a handful of shortcuts — and a second picker offering the same list
  /// in a different order is how two controls start disagreeing.
  Future<void> _promptTimer() async {
    final t = AppLocalizations.of(context);
    final messages = ref.read(messagesControllerProvider.notifier);
    if (widget.message.expiresAt != null) {
      messages.setExpiry(widget.chatId, widget.message.id, null);
      return;
    }
    final chosen = await showAutoDeletePicker(context, ChatAutoDelete.off);
    if (chosen == null || !chosen.isOn || !mounted) return;
    messages.setExpiry(
      widget.chatId,
      widget.message.id,
      DateTime.now().add(chosen.duration!),
    );
    if (!mounted) return;
    showGlassToast(
      context,
      t.chatTimerSet(formatAutoDelete(t, chosen)),
      icon: Icons.hourglass_bottom_rounded,
      tone: ToastTone.success,
    );
  }

  Future<void> _reportMessage() async {
    final channel = widget.chatId.startsWith('#');
    final peer =
        channel ? null : ref.read(knownPeersControllerProvider)[widget.chatId];
    final npub = peer?.nostrPubkey;
    await showReportSheet(
      context,
      reportContext: channel ? ReportContext.channel : ReportContext.direct,
      targetHex: channel ? widget.message.authorId : widget.chatId,
      targetNpub: npub == null
          ? null
          : npub.map((b) => b.toRadixString(16).padLeft(2, '0')).join(),
      channelId: channel ? widget.chatId : null,
      message: widget.message,
      chatId: widget.chatId,
    );
  }

  void _hideMessage() {
    final m = widget.message;
    final messages = ref.read(messagesControllerProvider.notifier);
    final original = ref.read(messagesControllerProvider)[widget.chatId];
    final index = original?.indexWhere((entry) => entry.id == m.id) ?? -1;
    if (index < 0) return;
    final overlay = Overlay.of(context);
    final t = AppLocalizations.of(context);
    messages.deleteLocal(widget.chatId, m.id);
    showUndoToast(
      overlay,
      message: t.messageHidden,
      undoLabel: t.undo,
      onUndo: () => messages.restoreLocal(widget.chatId, m, index),
      onExpire: () {},
    );
  }

  Future<void> _promptDelete() async {
    final t = AppLocalizations.of(context);
    final m = widget.message;
    // "For everyone" only makes sense for our own message, and only when we
    // know the shared id the recipients filed it under.
    final canForEveryone = m.isMine && m.wireId != null;

    // A tick, not a second button — the same dialog the selection toolbar
    // uses. See [askWithEveryoneTick].
    final everyone = await askWithEveryoneTick(
      context,
      title: t.chatDeleteTitle,
      everyoneLabel: t.chatDeleteForEveryone,
      confirmLabel: t.chatDeleteAction,
      destructive: true,
      offerEveryone: canForEveryone,
    );
    final choice = everyone == null
        ? null
        : everyone
            ? 'everyone'
            : 'me';

    if (choice == 'me') {
      // Both read *now*, before the farewell's delay. The callback runs 220 ms
      // later, by which time this bubble may not exist: the row it lives in
      // shrinks to nothing on its way out and a `ListView.builder` disposes
      // what leaves the viewport. `ref` then throws, the throw is swallowed by
      // the un-awaited future, and the delete silently never happens — which
      // is exactly the "deleting does nothing" this caused.
      //
      // The notifiers themselves outlive any widget, so holding them across
      // the wait is safe; holding `ref` is not.
      final farewell =
          ref.read(messageFarewellProvider(widget.chatId).notifier);
      final messages = ref.read(messagesControllerProvider.notifier);
      unawaited(
        farewell.dismiss(
          {m.id},
          () => messages.deleteLocal(widget.chatId, m.id),
        ),
      );
      // Its tag goes with it, so a deleted note leaves no orphan in the filter
      // bar matching nothing.
      if (isSavedChat(widget.chatId)) {
        unawaited(ref.read(savedTagsProvider.notifier).forget(m.id));
      }
    } else if (choice == 'everyone') {
      // Marked here, where the message id is known: the service works in wire
      // ids and would have to look this one up to say the same thing. Read
      // before the wait for the same reason as above.
      final farewell =
          ref.read(messageFarewellProvider(widget.chatId).notifier);
      final messaging = ref.read(messagingServiceProvider);
      final wireId = m.wireId!;
      await farewell.dismiss(
        {m.id},
        () => unawaited(
          messaging.sendDeleteForEveryone(widget.chatId, wireId),
        ),
      );
    }
  }

  /// The row a bubble sits in (1200): the gestures, band, swipe and rise
  /// 1199 had, in fewer widgets. Per plain text bubble the 1199 row was 44
  /// elements (theirs) and 59 (ours, with the tick's switcher); see
  /// `test/chat_open_element_budget_test.dart` for what it is now.
  ///
  ///  * **One gesture detector instead of three.** The row's
  ///    [GestureDetector], the swipe's [RawGestureDetector] inside it and a
  ///    second double-tap detector around the bubble — which did what the
  ///    row's own double-tap already did, on a smaller target — are one
  ///    [RawGestureDetector] with the same recognizers, the swipe's first,
  ///    as it was when it sat innermost. One difference: a swipe can now
  ///    start anywhere on the message's line, as the hold and the double-tap
  ///    already could, not only on the bubble.
  ///  * **The swipe in one render object.** [_SwipeShift] moves the row by
  ///    `_dragX` and paints the reply arrow itself, where a
  ///    [ValueListenableBuilder], a [Stack] and a [Transform] stood — and a
  ///    frame of the gesture repaints instead of rebuilding.
  ///  * **The band in one render object.** [_RowBand] fades the jump and
  ///    selection colour in and out exactly as the [AnimatedContainer] did,
  ///    without the [Container], [Padding] and [ColoredBox] under it.
  ///  * **The rise only where something rises.** [_RiseIn] and the fade
  ///    under it wrap a bubble built with [MessageBubble.animateEntry] and
  ///    nothing else; and the [KeyedSubtree] that carried no key is gone.
  ///  * **The column under the bubble** only where a read-by chip can go.
  Widget _leanRow({
    required Message message,
    required bool mine,
    required bool circle,
    required bool selecting,
    required bool selected,
    required bool highlighted,
    required Widget bubble,
  }) {
    // Inert while selecting, so a photo's own tap cannot win the arena and
    // open the viewer when the row was meant to tick.
    final Widget inert = IgnorePointer(ignoring: selecting, child: bubble);
    // Only our own channel posts carry a read-by chip — "who has seen mine"
    // is the question people ask, and only a channel has more than one
    // reader to count. Decided by what the message is, so the chip's first
    // reader does not re-parent the bubble.
    final readByRoom =
        mine && (widget.chatId.startsWith('#') || message.readBy.isNotEmpty);
    final row = Row(
      // Ours on the right, circles included. A circle grows away from its
      // own edge when tapped, the way Telegram's does, so an outgoing one
      // opens leftwards across the screen rather than jumping to the other
      // side of it.
      mainAxisAlignment: mine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (selecting) ...[
          Icon(
            selected
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 20,
            color:
                selected ? AppColors.brandPrimary : AppColors.textOnGlassFaint,
          ),
          const SizedBox(width: 8),
        ],
        ConstrainedBox(
          // A tapped circle is allowed past the usual three quarters: it
          // grows to most of the screen, and a cap meant for text would
          // squeeze it. See [VideoBubble.circleExpanded].
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * (circle ? 1.0 : 0.75),
          ),
          child: !readByRoom
              ? inert
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    inert,
                    if (message.readBy.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: _ReadByChip(
                          label: AppLocalizations.of(context)
                              .chatReadByCount(message.readBy.length),
                          onTapAt: _showActions,
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );

    // The hold, the right button, the tick while selecting, the double-tap
    // and the swipe, all on the whole line of the message:
    //
    //  * **Hold** answers anywhere on the row and opens the spotlight — the
    //    room blurs, this message stays lit and the reactions and actions
    //    arrange themselves around it. It used to go straight into selection
    //    mode, which left the menu with no way in at all (`_showActions` was
    //    reachable only from the read-by chip, which exists on your own
    //    messages in a channel and nowhere else). Selecting is the first
    //    action in the sheet now; while a selection is running the hold keeps
    //    its old meaning, tick another one. A mouse has no hold: the right
    //    button is it.
    //  * **Double-tap** is on the row for the same reason. Wired only to the
    //    painted surfaces it meant hitting a target a few characters wide on
    //    a short message. Off while selecting: there the row means one thing,
    //    and it is the tick.
    //  * **Swipe** is leftward only, so a drag the other way reaches the
    //    page's back gesture; a plain horizontal detector accepts at the
    //    slop whichever way the finger went and then clamps the offset to
    //    zero on the right, winning the arena to do nothing. It is registered
    //    only when there is a reply to be made — registered always and
    //    refusing inside the handler, the recognizer wins and everything else
    //    in the arena loses for nothing. And it starts from the touch, not
    //    from where the arena was won, or the bubble trails the thumb by the
    //    slop spent deciding.
    final onDoubleTap = selecting || !_canReact ? null : _quickReact;
    final Widget gestures = RawGestureDetector(
      behavior: HitTestBehavior.translucent,
      gestures: <Type, GestureRecognizerFactory>{
        if (!selecting && _canReply)
          LeftwardDragRecognizer:
              GestureRecognizerFactoryWithHandlers<LeftwardDragRecognizer>(
            LeftwardDragRecognizer.new,
            (r) => r
              ..dragStartBehavior = DragStartBehavior.down
              ..onUpdate = _onSwipeUpdate
              ..onEnd = ((_) => _onSwipeEnd())
              ..onCancel = _onSwipeEnd,
          ),
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(debugOwner: this),
          (r) => r
            ..onTap = selecting
                ? () => ref
                    .read(messageSelectionProvider(widget.chatId).notifier)
                    .toggle(message.id)
                : null
            ..onSecondaryTapUp =
                (d) => _hold(d.globalPosition, selecting: selecting),
        ),
        if (onDoubleTap != null)
          DoubleTapGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
            () => DoubleTapGestureRecognizer(debugOwner: this),
            (r) => r.onDoubleTap = onDoubleTap,
          ),
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          // 350 ms, not the framework's 500: the hold is what opens the
          // spotlight with the reactions and actions, the most used thing a
          // finger does to a message after reading it, and half a second of
          // nothing under a held finger reads as the hold not having been
          // noticed ("жесты лучше откликались", 2026-11-11). Telegram's is in
          // the same place. The slop that cancels it for a scroll is
          // unchanged, so a drag that starts on a row still scrolls.
          () => LongPressGestureRecognizer(
            debugOwner: this,
            duration: const Duration(milliseconds: 350),
          ),
          (r) => r.onLongPressStart =
              (d) => _hold(d.globalPosition, selecting: selecting),
        ),
      },
      child: _SwipeShift(
        offset: _dragX,
        hint: AppColors.brandPrimary,
        child: row,
      ),
    );

    final Widget band = _RowBand(
      color: selected
          ? AppColors.brandPrimary.withValues(alpha: 0.22)
          : highlighted
              ? AppColors.brandPrimary.withValues(alpha: 0.16)
              : Colors.transparent,
      child: gestures,
    );
    if (!_entering) return band;
    return _RiseIn(
      rise: _rise,
      child: FadeTransition(opacity: _fade, child: band),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Counted and timed for the frame meter: opening a chat builds every
    // visible bubble in one frame, and how much of that frame they are was the
    // open question on 2026-10-16. This is the bubble's own build only — its
    // text is measured later, in layout (see TimedSubtree).
    final watch = Stopwatch()..start();
    try {
      return _buildBubble(context);
    } finally {
      FrameStats.countBuild('bubble');
      FrameStats.countTime('bubble.build', watch.elapsedMicroseconds);
    }
  }

  Widget _buildBubble(BuildContext context) {
    final transcript = ref.watch(
      voiceTranscriptionProvider.select((texts) => texts[widget.message.id]),
    );
    final transcriptHidden = ref.watch(
      hiddenTranscriptsProvider
          .select((ids) => ids.contains(widget.message.id)),
    );
    final message = widget.message;
    final mine = message.isMine;
    final isChannel = widget.chatId.startsWith('#');
    // Only a rude message pays for the stranger check, which walks the
    // conversation — see [hasWrittenIn] for why "stranger" is "somebody you
    // have not written to" and not "somebody in knownPeers".
    final rude = shouldFilter(
      message: message,
      isChannel: true,
      fromContact: false,
      enabled: ref.watch(filterEnabledProvider),
    );
    final filtered = rude &&
        (isChannel ||
            !ref.watch(
              messagesControllerProvider.select(
                (all) => hasWrittenIn(all[widget.chatId]),
              ),
            ));
    if (filtered && !_revealedFiltered) {
      final t = AppLocalizations.of(context);
      return Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onLongPressStart: (details) => _showActions(details.globalPosition),
          onSecondaryTapUp: (details) => _showActions(details.globalPosition),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            padding: const EdgeInsets.fromLTRB(14, 4, 4, 4),
            decoration: BoxDecoration(
              color: AppColors.glass(0.1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.glass(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.visibility_off_outlined,
                    size: 18, color: AppColors.textOnGlassDim),
                const SizedBox(width: 8),
                Text(t.filteredMessage,
                    style: TextStyle(color: AppColors.textOnGlassDim)),
                TextButton(
                  onPressed: () => setState(() => _revealedFiltered = true),
                  child: Text(t.filteredShow),
                ),
                IconButton(
                  tooltip: t.reportAction,
                  onPressed: () => unawaited(_reportMessage()),
                  icon: const Icon(Icons.flag_outlined, size: 18),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final copyingRestricted = ref
            .watch(conversationSettingsControllerProvider)[widget.chatId]
            ?.copyingRestricted ??
        false;
    final sharedContact = _sharedContact;
    final sharedLocation = _sharedLocation;
    final mapFriendLink = _mapFriendLink;
    final activeMapFriends = ref.watch(mapFriendsControllerProvider);

    // Marked in the bubble too, not only in the banner up top: scrolling back
    // through history, you want to see which line the banner is pointing at.
    ref.watch(pinnedControllerProvider);
    final pinned = message.wireId != null &&
        ref
            .read(pinnedControllerProvider.notifier)
            .isPinned(widget.chatId, message.wireId!);

    // Set for a moment after a jump lands on this message — from a tapped
    // quote, the pinned bar, or a search result. Without it the screen simply
    // moves and nothing says which line you were sent to.
    final highlighted =
        ref.watch(chatHighlightProvider(widget.chatId)) == message.id;

    // The term to mark inside this bubble's own words. Watched rather than
    // passed in, so a message that is not text — a photo, a voice note — costs
    // nothing but the subscription.
    final searchQuery = ref.watch(chatSearchQueryProvider(widget.chatId));

    // While a selection is running the whole row becomes a checkbox: a tap
    // ticks instead of doing whatever that bubble's tap normally does (open a
    // photo, play a voice note), because a mode where some taps select and
    // others open is a mode nobody can predict.
    final selection = ref.watch(messageSelectionProvider(widget.chatId));
    final selecting = selection.isNotEmpty;
    final selected = selection.contains(message.id);

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(mine ? 18 : 6),
      bottomRight: Radius.circular(mine ? 6 : 18),
    );
    // Each bubble is its own levitating island, the same principle the chat
    // list and the nav bar use — nothing welded behind it, just a pane over the
    // aurora. It can't be a FloatingGlass (that surface is deliberately neutral
    // and these have to stay colour-coded by sender), so it wears the shared
    // shadow recipe over its own fill.
    //
    // No BackdropFilter here, deliberately. Every bubble used to run its own
    // gaussian, which on a full screen of conversation is a dozen blur passes
    // per frame — the most expensive thing in the app, on its most-scrolled
    // screen. What it sampled was the aurora: four wide radial gradients.
    // Blurring a soft gradient returns the same soft gradient, so the passes
    // bought nothing visible (the same reasoning FloatingGlass.blur already
    // documents for the rows). The fill, border and shadows are unchanged.
    //
    // The RepaintBoundary stays: it keeps one bubble's repaint out of its
    // neighbours as the list scrolls.
    // A sticker has no bubble at all: no fill, no border, no shadow. It is a
    // picture with a transparent background, and any of those would draw a
    // rectangle around something whose whole point is not having one.
    final sticker = message.isSticker;

    // A message that is nothing but emoji is drawn the way a sticker is: large,
    // and with no bubble around it. A bubble is a frame for text, and there is
    // no text here — asked for against Telegram, where two laughing faces come
    // out as two big faces and nothing else.
    //
    // Shares the sticker's path rather than inventing a second bare shape, so
    // the two cannot drift apart. What it does *not* share is the sticker's
    // fixed width: this is a line of text, and it is sized by its own font.
    final bareEmoji =
        message.kind == MessageKind.text ? message.bareEmojiCount : null;
    // A video whose bytes are on this phone, so it plays in the bubble rather
    // than being handed to whatever the phone calls a video player.
    //
    // Asked once and passed down. `handles` stats the file, and three things
    // in this build need the answer — this is the scrolling path, and a
    // synchronous stat per bubble per frame is the kind of cost this tree has
    // measured and removed before.
    final playableVideo = VideoBubble.handles(message);
    // Circular video is already clipped to its own shape. A normal message
    // fill behind it turned the circle into a video sitting on a square card.
    final circle = playableVideo && VideoBubble.isCircle(message);
    final bare = sticker || bareEmoji != null || circle;

    // The drawn face for a message that is one emoji and nothing else, when
    // there is a drawing of that emoji. Null for everything else, which is
    // most things: the pack has thirty-six faces and the keyboard has
    // thousands, and a glyph with no drawing is drawn as a glyph.
    final drawnFace =
        bareEmoji == 1 ? StickerPack.faceForGlyph[message.text.trim()] : null;

    // Drawn edge to edge, so the rows around it put their own inset back.
    final photo = message.kind == MessageKind.image;
    // A clip out of the gallery is a picture that moves, and it is now drawn
    // as one. It used to sit in fourteen points of tinted glass on every side
    // with its own fourteen-point radius inside the bubble's eighteen: the
    // bubble came out 28 points wider than the clip, so a chat holding both a
    // photo and a video had two column widths, and the mismatched radii left a
    // sliver of glass in each corner — the same frame the photo bubble spent a
    // release removing, put back around the other medium. Reported off a
    // screenshot of a clip beside a photo.
    //
    // The round one is not included: it is clipped to a circle already, and it
    // takes [bare] instead, which removes the whole card behind it.
    final clip = playableVideo && !circle;
    final media = photo || clip;
    const inset = EdgeInsets.symmetric(horizontal: 14, vertical: 10);
    Widget inBubble(Widget child) =>
        media ? Padding(padding: inset, child: child) : child;

    // Still true while the last one shrinks away: the row has to stay for it.
    final reacted = message.reactions.values.any((by) => by.isNotEmpty) ||
        _leavingReactions.isNotEmpty;
    // The clock rides *on* a picture that has nothing else to say — the way
    // every messenger draws one. A strip of bubble under the photo carrying
    // four characters is the frame this design spent a release removing, put
    // back one edge at a time. As soon as there is something else on that line
    // (a caption, a reaction) the row comes back and the clock joins it.
    final metaOnMedia = media && !reacted && _caption == null;
    // Our own words on our own fill, in the palette's darkest. They were
    // white on the bright green and blended into it, as did the white time and
    // the light-blue read ticks ("стрелочки прочитаные ... сливаеться", "текст
    // мой тоже надо сделать темнее", 2026-10-31). Stronger than
    // [readingColor] below — this is the message, that is a note about it —
    // and still not pure black, which an earlier report found harsh.
    final ownInk =
        mine && !bare ? AppColors.bgDeep.withValues(alpha: 0.88) : null;
    final meta = _BubbleMeta(
      message: message,
      pinned: pinned,
      onMedia: metaOnMedia,
      onOwnFill: mine && !bare && !metaOnMedia,
      // Only in the saved chat does a tag exist, so only there is the map read.
      tag: isSavedChat(widget.chatId)
          ? ref.watch(savedTagsProvider.select((t) => t[message.id]))
          : null,
    );

    // With no reactions the footer is the clock line itself; the
    // [_BubbleFooter] around it only ever returned it unchanged.
    Widget footerOf({required bool spread}) => inBubble(
          !reacted
              ? meta
              : _BubbleFooter(
                  reactions: reacted
                      ? _ReactionsRow(
                          reactions: _shownReactions,
                          fresh: _freshReactions,
                          leaving: _leavingReactions.keys.toSet(),
                          onTap: _canReact ? _toggleReaction : null,
                        )
                      : null,
                  meta: meta,
                  spread: spread,
                ),
        );
    final footer = footerOf(spread: false);

    // **The clock in the bottom-right corner, as every messenger has it.**
    // "Перемести час отправки в правий угол смс, а не в лівий" — it sat at the
    // left because the bubble's column starts its rows at the left, and the
    // column is only as wide as its widest row, so there was no "right" to
    // push it to. A Row or an Align that reached for the right edge would
    // stretch every bubble to the full width. Instead the footer keeps its
    // place in the column invisibly — the bubble stays as wide and as tall as
    // it needs — and the drawn one is laid over that place, against the
    // right. Not under a channel post's comments link, which comes after it,
    // and not on a bare message (a sticker, a lone emoji, a circle): there is
    // no bubble to have a corner, its column can be as wide as a reply quote
    // above it, and the clock belongs by the picture — at the right of ours
    // already, and against the left of theirs (bare_bubble_alignment_test).
    final footerAtEnd = !metaOnMedia && !_showsComments && !bare;

    // The colour of what is read *about* a message — a transcript, a
    // translation. It was the dim tier, white at 0.6, which on our own bubble
    // is white on bright green and could barely be read ("сделай текст
    // чёрным, чтобы его видно было"). On our own bubble it is the palette's
    // own darkest now; on theirs, and under a circle, which has no bubble
    // behind it, the full-strength glass text.
    //
    // Not pure dark, which read as harsh ("не такой приторный чёрный"): the
    // palette's darkest at 70%, which on the green lands on a deep muted
    // green-grey — clearly readable, and softer than the text it sits under.
    final readingColor = mine && !bare
        ? AppColors.bgDeep.withValues(alpha: 0.7)
        : AppColors.textOnGlass;
    // The bubble's own column. What goes around it — the footer at its end,
    // the fill, the clip, and the row with its gestures — is put on after it.
    final Widget column = Column(
      // Left inside a bubble, right when there is no bubble and the
      // message is ours.
      //
      // Inside a bubble the box is drawn around its content, so start
      // is the only sensible answer and always was. A bare message has
      // no box: the column is as wide as its *widest* row, which for a
      // sticker or a lone emoji is the reply quote above it — so the
      // picture and the clock sat at the left of a quote-wide column
      // and read as having drifted away from the edge every other
      // outgoing message hugs. Reported off a screenshot, where the
      // face and its tick float in the middle of the row.
      //
      // Only for ours: an incoming bare message is against the left
      // edge already, and start is what puts it there.
      crossAxisAlignment:
          bare && mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Passed on from somebody else, said above the message rather
        // than inside it: the words below are theirs and the bubble
        // must not look like it is quoting them into a sentence.
        if (message.forwardedFrom case final from?) ...[
          inBubble(
            _ForwardHeader(
              name: from,
              // Present only when the author allows being reached this
              // way. Without it the row is the same row and simply
              // does not answer a tap — which is the whole of what
              // their privacy switch buys them here.
              authorId: message.forwardedFromId,
            ),
          ),
          const SizedBox(height: 4),
        ],
        // Channel messages from others: show the author's name on top,
        // since a channel mixes many senders in one conversation.
        if (!mine && message.authorName != null) ...[
          inBubble(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Their face, small, beside their name. A room mixes
                // senders and a name alone is a line of text to read;
                // the picture is recognised before it is read, which
                // is the whole job of the line.
                if (message.authorId case final id?) ...[
                  PeerAvatar(
                    peerId: id,
                    label: message.authorName!,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    message.authorName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      // One hue per person rather than the brand for
                      // everybody — see [AppColors.authorTint].
                      color: AppColors.authorTint(
                        message.authorId ?? message.authorName!,
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!media) const SizedBox(height: 2),
        ],
        if (message.replyToWireId != null)
          inBubble(_quotedBox(message.replyToWireId!)),
        if (message.kind == MessageKind.image) ...[
          // The picture, with the clock floating in its bottom corner
          // when the bubble has no other line to put it on.
          Stack(
            children: [
              if (widget.album case final album?)
                _AlbumPayload(
                  messages: album,
                  chatId: widget.chatId,
                  onDoubleTap: _canReact ? _quickReact : null,
                )
              else
                _ImagePayload(
                  message: message,
                  chatId: widget.chatId,
                  onDoubleTap: _canReact ? _quickReact : null,
                ),
              if (metaOnMedia)
                Positioned(
                  right: 8,
                  bottom: 8,
                  // Inert, so the pill cannot swallow the tap that
                  // opens the photo underneath it.
                  child: IgnorePointer(child: _MetaPill(child: meta)),
                ),
              // How far the upload has got. Only on our own pictures
              // and only while they are still going: a photo over
              // Bluetooth is a few hundred chunks and minutes of them,
              // and "sending" for all of it could not be told apart
              // from a transfer that had stalled.
              if (message.isMine && message.status == MessageStatus.sending)
                Positioned.fill(
                  child: _SendProgressRing(
                    messageId: message.id,
                    onCancel: _cancelSend,
                  ),
                ),
            ],
          ),
          // The caption, which used to go missing entirely. It rides in
          // `text`, and the chain below renders `text` only for a
          // message that matched none of these branches — so a photo
          // took the image branch and its caption was never drawn,
          // however carefully it had been typed and delivered.
          // One caption for the set. It is sent on the first photo of a
          // batch, which is where it used to be drawn — reading as a
          // remark about that one picture rather than about the lot.
          if (_caption case final caption?)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: widget.album == null
                      ? photoBubbleWidth(context)
                      : _kAlbumWidth,
                ),
                child: MentionText(caption, highlight: searchQuery),
              ),
            ),
        ] else if (message.kind == MessageKind.audio)
          // A voice note over Bluetooth is as long a wait as a photo,
          // and said as little about itself. Beside the bubble rather
          // than over it: the waveform is the thing being read, and a
          // disc in the middle of it would cover exactly that.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: VoiceBubble(
                      message: message,
                      chatId: widget.chatId,
                      transcriptionButton: _transcriptionButton(
                        transcript: transcript,
                        transcriptHidden: transcriptHidden,
                      ),
                    ),
                  ),
                  if (message.isMine &&
                      message.status == MessageStatus.sending) ...[
                    const SizedBox(width: 8),
                    _SendProgressRing(
                      messageId: message.id,
                      // 32 rather than 26: a cross in it has to be a
                      // target a thumb can find.
                      diameter: 32,
                      onSurface: true,
                      onCancel: _cancelSend,
                    ),
                  ],
                ],
              ),
            ],
          )
        else if (playableVideo)
          // A clip travels as a file and used to be drawn as one: a
          // row with a name and a size, opened by handing it to
          // whatever the phone calls a video player. It plays here
          // now. Still a file underneath — the transport, the
          // transfer queue and the long-press actions are unchanged.
          //
          // The same Stack the picture above gets, for the same
          // reasons: the clock in the corner rather than on a strip of
          // bubble below, and our own upload counted out on the clip
          // instead of the word "sending" for the whole of a transfer
          // that is minutes long over Bluetooth.
          //
          // A circle takes neither: `metaOnMedia` is false for it,
          // because it is round and already carries its own ring and
          // its own countdown — a rectangular pill would hang off the
          // shape at the corner.
          Stack(
            children: [
              VideoBubble(
                message: message,
                chatId: widget.chatId,
                transcriptionButton: circle
                    ? _transcriptionButton(
                        circle: true,
                        transcript: transcript,
                        transcriptHidden: transcriptHidden,
                      )
                    : null,
              ),
              if (metaOnMedia)
                Positioned(
                  right: 8,
                  bottom: 8,
                  // Inert, so the pill cannot swallow the tap that
                  // starts the clip underneath it.
                  child: IgnorePointer(child: _MetaPill(child: meta)),
                ),
              if (clip &&
                  message.isMine &&
                  message.status == MessageStatus.sending)
                Positioned.fill(
                  child: _SendProgressRing(
                    messageId: message.id,
                    onCancel: _cancelSend,
                  ),
                ),
            ],
          )
        else if (message.kind == MessageKind.file)
          // Restricted means "do not take this elsewhere", not "do not
          // look at it". Wrapping the row in an IgnorePointer made a
          // received file unopenable on the device it was sent to,
          // which is not a privacy control — it is the file simply not
          // working. The restriction belongs one level in, on the
          // share-to-another-app fallback.
          FileBubble(
            message: message,
            sharingRestricted: copyingRestricted,
          )
        else if (message.kind == MessageKind.poll)
          PollBubble(
            message: message,
            chatId: widget.chatId,
          )
        else if (mapFriendLink != null && !widget.chatId.startsWith('#'))
          _MapFriendLinkBubble(
            link: mapFriendLink,
            active: activeMapFriends.contains(widget.chatId),
            mine: message.isMine,
            onTap: () async {
              if (mapFriendLink.kind == MapFriendLinkKind.invite &&
                  !message.isMine &&
                  !activeMapFriends.contains(widget.chatId)) {
                await ref
                    .read(mapFriendsControllerProvider.notifier)
                    .activate(widget.chatId);
                await ref.read(messagingServiceProvider).sendText(
                      widget.chatId,
                      MapFriendLink.accepted(
                        displayName: ref.read(nicknameControllerProvider),
                      ).encode(),
                    );
                // Accepting pairs two people on the map; showing your
                // own location is asked separately. It used to switch
                // sharing on in the same tap, on the reasoning that
                // accepting was agreeing — App Store review rejected
                // that under guideline 5.1.2(i), which wants a person
                // asked, with the option to decline. A "no" still
                // leaves the pairing: they see the friend, the friend
                // does not see them until they choose Show me.
                if (!context.mounted) return;
                if (await confirmMapSharing(context, ref)) {
                  await ref
                      .read(mapPresenceControllerProvider.notifier)
                      .pokeNow();
                }
              }
              if (!context.mounted) return;
              context.go('/map');
            },
          )
        else if (sharedLocation != null)
          _SharedLocationBubble(location: sharedLocation)
        else if (sharedContact != null)
          _SharedContactBubble(
            contact: sharedContact,
            onTap: () => _openSharedContact(sharedContact),
          )
        else if (tryParseCallRecord(message.text) case final call?)
          // A call you can make again from where it sits, the way
          // Telegram's are: "зробити клікабельні дзвінки, натискаєш і
          // дзвониш прямо в стрічці". It was a line of text. Off while
          // selecting, where a tap on the row means the tick.
          _CallRecordBubble(
            call: call,
            ownInk: ownInk,
            onCall: selecting || !ref.read(platformCapabilitiesProvider).calls
                ? null
                : () => unawaited(
                      ref.read(callControllerProvider).dial(
                            widget.chatId,
                            video: call.video,
                          ),
                    ),
          )
        else if (drawnFace != null)
          // One emoji, and we have a drawing of that one: it moves.
          //
          // Only when it is alone. Two of them are closer to a line of
          // text than to a gesture, and three animations side by side
          // in a transcript is a decoration nobody asked for running
          // while somebody is trying to read. The rule is the same one
          // the size switch below states in points — one is the loudest
          // — said in movement instead.
          Image.asset(
            StickerPack.animation(drawnFace),
            width: 96,
            height: 96,
            filterQuality: FilterQuality.medium,
          )
        else
          MentionText(
            message.text,
            highlight: searchQuery,
            ink: ownInk,
            // Fewer of them, bigger — one on its own is the loudest and
            // three are closer to a line of text than to a gesture.
            // Sticker-sized at the top end rather than merely larger:
            // the point of a bare emoji is that it is not a sentence.
            fontSize: switch (bareEmoji) {
              1 => 48,
              2 => 40,
              3 => 32,
              _ => null,
            },
          ),
        // The circle's button has flown off by now, so the wait is
        // shown where the text is about to land. A voice note keeps
        // its spinner in the button, which stays.
        if (circle && _transcribing && transcript == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.6,
                    color: AppColors.textOnGlassDim,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).chatTranscribing,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textOnGlassDim,
                  ),
                ),
              ],
            ),
          ),
        // Folded away with "↑" hides the text, not the failure note.
        if (message.isVoiceNote &&
            (transcript != null ? !transcriptHidden : _transcriptionFailed))
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              transcript ??
                  switch (ref
                      .read(voiceTranscriptionProvider.notifier)
                      .failureOf(message.id)) {
                    // Said as what to do, not just that it failed:
                    // both have a way out.
                    'model_downloading' =>
                      AppLocalizations.of(context).chatTranscribeDownloading,
                    'language_not_supported' =>
                      AppLocalizations.of(context).chatTranscribeNoLanguage,
                    // iOS: refused once, refused until Settings.
                    'not_authorized' =>
                      AppLocalizations.of(context).chatTranscribeNotAllowed,
                    _ => AppLocalizations.of(context).chatTranscribeFailed,
                  },
              style: TextStyle(
                fontSize: 14,
                height: 1.35,
                color: readingColor,
              ),
            ),
          ),
        // Under the message, never instead of it. What they wrote is
        // still what they wrote; this is a reading of it, and a
        // translation that replaced the original would hide the one
        // thing a reader can check.
        // A voice note's translation is a reading of its transcript,
        // and folds away with it.
        if (ref.watch(
          translationProvider.select((t) => t[message.id]),
        )
            case final String translated
            when !(message.isVoiceNote && transcriptHidden))
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              translated,
              // Upright: the reading colour already sets the
              // translation apart (unslop pass, no italic).
              style: TextStyle(
                fontSize: 14,
                height: 1.35,
                color: readingColor,
              ),
            ),
          ),
        // Reactions and the clock on one line, inside the bubble.
        //
        // They used to be a second row hanging *below* the bubble,
        // which is a shape no messenger draws: it detached the
        // reaction from the thing reacted to, pushed the next message
        // down by a whole row, and left the bubble's own bottom line
        // carrying nothing but four characters of time. One line, the
        // reaction where it was put and the clock where it always is.
        //
        // When it is drawn at the right, [_FooterBelowAtEnd] lays it out
        // below this column instead — see there.
        if (!metaOnMedia && !footerAtEnd) ...[
          if (!media) const SizedBox(height: 4),
          footer,
        ],
        // The way into what everybody said about this post.
        //
        // Only under a post in an announcement channel, because that
        // is the only place a reader has nowhere else to put a reply —
        // in a room where anybody may write, the reply goes in the
        // room. Not on our own posts either: the admin already has the
        // discussion a tap away in the header.
        if (_showsComments) ...[
          const SizedBox(height: 4),
          inBubble(
            _CommentsLink(
              channelName: widget.chatId,
              post: message,
            ),
          ),
        ],
      ],
    );

    // Reactions spread across the bubble when drawn, so what is drawn is not
    // what sizes it: the unspread row goes along as the sizer. Without
    // reactions the two are the same row, laid out once.
    final Widget? drawnFooter = footerAtEnd
        ? reacted
            ? footerOf(spread: !mine)
            : footer
        : null;
    final Widget? sizer = footerAtEnd && reacted ? footer : null;
    final double footerGap = media ? 0 : 4;

    // A photo or a clip fills its bubble; everything else sits inside
    // padding.
    //
    // A picture framed by fourteen points of tinted glass on every side reads
    // as a picture *of* a message. Letting it run to the rounded corners is
    // what every messenger does, and it also buys back the width: the same
    // photo is drawn larger without the bubble growing. The rows that keep
    // their inset — an author's name, the caption, the time — ask for it
    // themselves below.
    final padding = media || circle
        ? EdgeInsets.zero
        : const EdgeInsets.symmetric(horizontal: 14, vertical: 10);
    // And no border on a photo bubble, which is why its corners looked broken.
    // `Border.all` paints its stroke *inside* the container, so the picture
    // sits a pixel in from it and is then clipped by the ClipRRect at the
    // outer radius: the stroke reads cleanly along the straight edges and
    // comes apart in every corner. That is the "обводка плохо сделано, углов
    // нету" in the report.
    //
    // Telegram draws no frame around a photo at all, and the reason carries
    // over — a border exists to give a pane of glass an edge, and a picture
    // already has one. A clip is a picture that moves and takes the same
    // answer. Everything else keeps its border.
    final decoration = bare
        ? const BoxDecoration()
        : mine
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.brandPrimary.withValues(alpha: 0.85),
                    AppColors.brandSecondary.withValues(alpha: 0.85),
                  ],
                ),
                borderRadius: radius,
                // No frame around a photo — see the note by `padding`.
                border: media ? null : Border.all(color: AppColors.glass(0.18)),
              )
            : BoxDecoration(
                color: AppColors.glass(0.10),
                borderRadius: radius,
                border: media ? null : Border.all(color: AppColors.glass(0.16)),
              );

    // **The same bubble in fewer widgets (1200).** Every element here is
    // created for every message that scrolls into view — 1.2 ms of
    // `item.inflate` per bubble on the S24+ (1199), before a letter of it
    // is measured — so what drew nothing went:
    //
    //  * the shadow box: [FloatingGlass.shadows] has been empty for a long
    //    time, and a decoration of no shadows paints nothing;
    //  * the clip, on a bubble whose content sits inside padding: the fill
    //    draws its own rounded corners, and nothing inside reaches them.
    //    A photo, a clip and a bare message keep it — they run to the edge;
    //  * [Container], for the two boxes it builds anyway;
    //  * the wrapper widget that used to sit around [_FooterBelowAtEnd], for
    //    the render object it returns.
    //
    // The decoration is skipped only when it is empty (a bare message) and
    // the padding only when it is zero (media). Which of these a bubble has
    // follows from what the message is, so a bubble does not change shape
    // while it is on screen. `test/chat_open_element_budget_test.dart`
    // holds the count.
    Widget body = drawnFooter == null
        ? column
        : _FooterBelowAtEnd(
            gap: footerGap,
            content: column,
            footer: drawnFooter,
            sizer: sizer,
          );
    // Plus the border's own width, as [Container] did: it insets its child
    // by the decoration's padding too, so the hairline never sits under the
    // text. Left out, every bordered bubble came out 2 pt smaller each way
    // (caught by `test/bubble_meta_paragraph_test.dart`).
    final bodyInset = padding.add(decoration.padding);
    if (bodyInset != EdgeInsets.zero) {
      body = Padding(padding: bodyInset, child: body);
    }
    if (!bare) body = DecoratedBox(decoration: decoration, child: body);
    if (media || bare) {
      body = ClipRRect(borderRadius: radius, child: body);
    }
    final bubble = RepaintBoundary(child: body);

    return _leanRow(
      message: message,
      mine: mine,
      circle: circle,
      selecting: selecting,
      selected: selected,
      highlighted: highlighted,
      bubble: bubble,
    );
  }
}

/// The arrow that arrives from the right edge as a bubble is dragged left,
/// telling the finger what releasing will do before it commits.
///
/// Fills in as the drag approaches the threshold and reaches full strength
/// exactly when the release would take, so "will this work?" is answered by
/// looking rather than by trying.
/// A shared position: what it is, how precise, and a way out to a real map.
///
/// No tiles. Rendering a map means fetching the square somebody is standing in
/// from a tile server, which tells that server where they are — see
/// [SharedLocation.geoUri]. The phone's own maps app is where the user already
/// decided how they feel about that.
class _SharedLocationBubble extends StatelessWidget {
  const _SharedLocationBubble({required this.location});

  final SharedLocation location;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final expired = location.expired;
    // 168-212, was 200-250. The title row used to be an [Expanded] in a
    // full-width [Row], which took whatever the maximum was, so every position
    // was 250 wide however short its words ("локація", a pair of coordinates)
    // — "пузырь карты ... не такие длинные" (2026-11-11). Sized by what is in
    // it now, between a floor that keeps a run of them aligned and a ceiling
    // that keeps the coordinates on one line at 12 pt.
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 168, maxWidth: 212),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                expired ? Icons.location_off_rounded : Icons.place_rounded,
                size: 20,
                color:
                    expired ? AppColors.textOnGlassDim : AppColors.brandPrimary,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  t.locationBubbleTitle,
                  style: TextStyle(
                    color: AppColors.textOnGlass,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${location.latitude.toStringAsFixed(5)}, '
            '${location.longitude.toStringAsFixed(5)}',
            style:
                AppTypography.mono(size: 12, color: AppColors.textOnGlassDim),
          ),
          if (location.accuracyMetres > 0) ...[
            const SizedBox(height: 2),
            Text(
              t.locationAccuracy(location.accuracyMetres),
              style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
            ),
          ],
          const SizedBox(height: 8),
          if (expired)
            // The row stays and says so. Hiding it would leave a gap where the
            // sender plainly remembers sending something.
            Text(
              t.locationExpired,
              style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
            )
          else
            GestureDetector(
              onTap: () async {
                final uri = location.mapsUri;
                if (!await launchUrl(uri,
                    mode: LaunchMode.externalApplication)) {
                  if (!context.mounted) return;
                  showGlassToast(context, t.locationUnavailable);
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map_rounded,
                      size: 16, color: AppColors.brandPrimary),
                  const SizedBox(width: 6),
                  Text(
                    t.locationOpenInMaps,
                    style: TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MapFriendLinkBubble extends StatelessWidget {
  const _MapFriendLinkBubble({
    required this.link,
    required this.active,
    required this.mine,
    required this.onTap,
  });

  final MapFriendLink link;
  final bool active;
  final bool mine;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final accepted = active || link.kind == MapFriendLinkKind.accepted;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => unawaited(onTap()),
      child: ConstrainedBox(
        // 168-212, was 210-250: the same ceiling as a shared position, and
        // for the same reason — see [_SharedLocationBubble].
        constraints: const BoxConstraints(minWidth: 168, maxWidth: 212),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    accepted
                        ? Icons.location_on_rounded
                        : Icons.person_add_alt_1_rounded,
                    size: 20,
                    color: AppColors.brandPrimary,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      accepted ? t.mapTitle : t.mapInviteTitle,
                      style: TextStyle(
                        color: AppColors.textOnGlass,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                link.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textOnGlassDim,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    accepted || mine
                        ? Icons.map_rounded
                        : Icons.check_circle_rounded,
                    size: 16,
                    color: AppColors.brandPrimary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    accepted ? t.mapTitle : t.mapInviteAction(1),
                    style: TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A finished call, in the conversation: which way it went, how long it
/// lasted, and the phone to call again.
class _CallRecordBubble extends StatelessWidget {
  const _CallRecordBubble({
    required this.call,
    required this.onCall,
    this.ownInk,
  });

  final CallRecord call;

  /// Null while the message list is picking messages out.
  final VoidCallback? onCall;

  /// The ink of our own words on our own green fill, or null on theirs.
  ///
  /// On our bubble the arrow and its round were brand green on brand green
  /// and all but vanished, and the label was white while the clock under it
  /// was already the dark ink — two inks in one bubble. "На мой пузырь сделай
  /// такой же цвет как текст в смс мой" (2026-11-10): the whole row takes the
  /// ink our text does.
  final Color? ownInk;

  /// One width for every call row, so a run of calls lines up.
  ///
  /// It was 190-250 and as wide as its label, so "Вихідний", "Вхідний" and
  /// "Пропущений дзвінок" one under another were three different widths and
  /// the camera sat in three different places ("звонки в чате пузырь
  /// выровняй", 2026-11-10). 244 holds the longest Ukrainian label at 15 pt;
  /// a longer one ellipsises, as it already could at the old maximum.
  ///
  /// 220 since 1208 ("пузырь ... вызовов не такие длинные", 2026-11-11): the
  /// round is 36 and the label 14 pt, which is what 220 holds the longest
  /// label at (36 + 10 + ~146 + 8 + 20), 24 pt shorter than before.
  static const double _width = 220;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final missed = !call.outgoing && !call.answered;
    final (icon, label) = switch ((call.outgoing, call.answered)) {
      (true, true) => (Icons.call_made_rounded, t.previewCallOutgoing),
      (true, false) => (Icons.call_made_rounded, t.callNoAnswer),
      (false, true) => (Icons.call_received_rounded, t.previewCallIncoming),
      (false, false) => (Icons.call_missed_rounded, t.previewCallMissed),
    };
    final own = ownInk;
    final tone = own ?? (missed ? AppColors.danger : AppColors.brandPrimary);
    final labelInk = own ?? (missed ? AppColors.danger : AppColors.textOnGlass);
    // A step lighter than the label, as the dim tier is on theirs.
    final durationInk = own?.withValues(alpha: 0.7) ?? AppColors.textOnGlassDim;
    final callBackInk = onCall == null
        ? (own?.withValues(alpha: 0.4) ?? AppColors.textOnGlassFaint)
        : (own ?? AppColors.brandPrimary);
    return Semantics(
      button: onCall != null,
      label: '$label. ${t.callsCallBack}',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onCall,
        child: SizedBox(
          width: _width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tone.withValues(alpha: own == null ? 0.16 : 0.12),
                  ),
                  child: Icon(icon, size: 19, color: tone),
                ),
                const SizedBox(width: 10),
                // Expanded, so the camera is at the right edge of every row.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: labelInk,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (call.answered) ...[
                        const SizedBox(height: 2),
                        Text(
                          callClock(call.talkedFor),
                          style: TextStyle(
                            color: durationInk,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // The way it will call back: a video call again with video.
                Icon(
                  call.video ? Icons.videocam_rounded : Icons.call_rounded,
                  size: 20,
                  color: callBackInk,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SharedContactBubble extends ConsumerWidget {
  const _SharedContactBubble({
    required this.contact,
    required this.onTap,
  });

  final SharedContact contact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    // Whether the invitation names us, by the sixteen hex characters of our
    // own signing key that a room frame carries.
    final myFingerprint = ref.watch(myChannelFingerprintProvider).value;
    final forMe = contact.invitedMemberId != null &&
        myFingerprint != null &&
        contact.invitedMemberId == myFingerprint;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 210, maxWidth: 250),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              PeerAvatar(
                peerId: contact.pubkeyHex,
                label: contact.displayName,
                size: 46,
                online: false,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      // An invitation says so, and says so louder when it is
                      // addressed to the person reading it — in a room where
                      // everybody sees every frame, that is the difference
                      // between "somebody was invited" and "you were".
                      contact.isInvitation
                          ? (forMe
                              ? t.chatContactInvitationForYou
                              : t.chatContactInvitation)
                          : t.profileContactCard,
                      style: TextStyle(
                        color: contact.isInvitation && forMe
                            ? AppColors.brandPrimary
                            : AppColors.textOnGlassDim,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textOnGlass,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.contactProfileOpen,
                      style: TextStyle(
                        color: AppColors.textOnGlassDim,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textOnGlassDim,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A message's row moved sideways by a swipe-to-reply, with the reply arrow
/// that arrives from the right edge as it goes — in one render object.
///
/// It stands where 1199 had a [ValueListenableBuilder] around a [Stack] of a
/// [Transform.translate] and, past a pixel of travel, a widget for the arrow:
/// three elements and two render objects in every bubble, built for a
/// gesture most bubbles never see, and rebuilt on every frame of it. This
/// listens to the offset itself, so a frame of the swipe repaints and
/// nothing is built. The arrow is drawn as that widget did — a
/// 32 pt disc of [hint] at 18% and a ring at 50% of the arrow's progress,
/// the arrow at full colour, all of it scaled from 0.7 and faded in by that
/// same progress — at the row's right edge, centred on its height, and does
/// not move with the row.
class _SwipeShift extends SingleChildRenderObjectWidget {
  const _SwipeShift({
    required this.offset,
    required this.hint,
    required super.child,
  });

  final ValueListenable<double> offset;
  final Color hint;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderSwipeShift(offset, hint);

  @override
  void updateRenderObject(
      BuildContext context, _RenderSwipeShift renderObject) {
    renderObject
      ..offset = offset
      ..hint = hint;
  }
}

class _RenderSwipeShift extends RenderProxyBox {
  _RenderSwipeShift(this._offset, this._hint);

  ValueListenable<double> _offset;
  set offset(ValueListenable<double> value) {
    if (identical(value, _offset)) return;
    if (attached) _offset.removeListener(markNeedsPaint);
    _offset = value;
    if (attached) _offset.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  Color _hint;
  set hint(Color value) {
    if (value == _hint) return;
    _hint = value;
    _arrow?.dispose();
    _arrow = null;
    markNeedsPaint();
  }

  /// The arrow glyph, laid out the first time a swipe draws it.
  TextPainter? _arrow;

  double get _dx => _offset.value;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _offset.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _offset.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void dispose() {
    _arrow?.dispose();
    super.dispose();
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      result.addWithPaintOffset(
        offset: Offset(_dx, 0),
        position: position,
        hitTest: (result, transformed) =>
            super.hitTestChildren(result, position: transformed),
      );

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.translateByDouble(_dx, 0, 0, 1);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) context.paintChild(child, offset + Offset(_dx, 0));
    if (_dx < -1) _paintArrow(context.canvas, offset);
  }

  void _paintArrow(Canvas canvas, Offset offset) {
    final progress = (_dx.abs() / _swipeTrigger).clamp(0.0, 1.0);
    final centre = offset + Offset(size.width - 16, size.height / 2);
    final arrow = _arrow ??= TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.reply_rounded.codePoint),
        style: TextStyle(
          inherit: false,
          fontFamily: Icons.reply_rounded.fontFamily,
          package: Icons.reply_rounded.fontPackage,
          fontSize: 17,
          height: 1,
          color: _hint,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas
      ..saveLayer(
        Rect.fromCircle(center: centre, radius: 17),
        Paint()..color = Color.fromRGBO(0, 0, 0, progress),
      )
      ..translate(centre.dx, centre.dy)
      ..scale(0.7 + 0.3 * progress)
      ..drawCircle(
        Offset.zero,
        16,
        Paint()..color = _hint.withValues(alpha: 0.18 * progress),
      )
      ..drawCircle(
        Offset.zero,
        15.5,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = _hint.withValues(alpha: 0.5 * progress),
      );
    arrow.paint(canvas, Offset(-arrow.width / 2, -arrow.height / 2));
    canvas.restore();
  }
}

/// The band across a message's row that says "you were brought here" or
/// "picked" — [AnimatedContainer]'s colour fade and padding, in one render
/// object instead of four elements and two.
class _RowBand extends ImplicitlyAnimatedWidget {
  const _RowBand({required this.color, required this.child})
      : super(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
        );

  final Color color;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_RowBand> createState() => _RowBandState();
}

class _RowBandState extends AnimatedWidgetBaseState<_RowBand> {
  ColorTween? _color;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(
      _color,
      widget.color,
      (dynamic value) => ColorTween(begin: value as Color),
    ) as ColorTween?;
  }

  @override
  Widget build(BuildContext context) => _BandBox(
        color: _color?.evaluate(animation) ?? widget.color,
        child: widget.child,
      );
}

class _BandBox extends SingleChildRenderObjectWidget {
  const _BandBox({required this.color, required super.child});

  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderBand(color);

  @override
  void updateRenderObject(BuildContext context, _RenderBand renderObject) {
    renderObject.color = color;
  }
}

/// The row's padding, with [color] painted under all of it. Hit-tests as the
/// [ColoredBox] it replaces did — opaque over its whole box.
class _RenderBand extends RenderPadding {
  _RenderBand(this._color)
      : super(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        );

  Color _color;
  set color(Color value) {
    if (value == _color) return;
    _color = value;
    markNeedsPaint();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (!size.contains(position)) return false;
    hitTestChildren(result, position: position);
    result.add(BoxHitTestEntry(this, position));
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_color.a > 0) {
      context.canvas.drawRect(offset & size, Paint()..color = _color);
    }
    super.paint(context, offset);
  }
}

/// The bubble's column, with its footer drawn against the right edge.
///
/// [child] is the column without the footer; [footer] is laid out below it,
/// [gap] apart, its bottom-right corner on the bubble's. The bubble is as wide
/// as the wider of the two. With no [footer] it is just the column.
///
/// [sizer], when there is one, is the row that decides the bubble's size and
/// is never drawn. That is the reactions case: the drawn row spreads across the
/// bubble (see [_BubbleFooter.spread]), so it cannot be what measures it. Every
/// bubble without reactions has no sizer, and its footer is laid out once.
///
/// **What this replaced.** The column used to carry an invisible copy of the
/// footer as its last row, with the drawn one laid over it from a [Stack] — on
/// every bubble, reacted to or not. The clock row is three or four paragraphs
/// (route badge, lock, time, tick), and on the S24+ (1194, 2026-11-10) its two
/// copies took more layout than the message text did: `meta.layout` 26-39 ms
/// against `text.layout` 11-16 ms per 5 s window of scrolling, `meta.inflate`
/// 11.5-16 ms against 1.6-1.8. The same widget serves both cases so that a
/// first reaction does not swap the parent and remount the bubble's content.
///
/// Measured after, same phone, same 40 bubbles built per scroll window (1196):
/// `meta.layout` 26.0 → 17.0 ms, `meta.inflate` 11.5 → 7.2, `item.layout`
/// 50.3 → 42.8, with `text.layout` unchanged at 11.2 as the control. The open
/// frame is too noisy to show it by itself: the same phone drifted from 22 to
/// 29 ms a chat open over one evening on unchanged code (1193 vs 1198, scripted
/// run), so compare open frames only between builds run back to back.
/// `test/bubble_footer_single_pass_test.dart` holds the geometry the copy
/// produced.
///
/// The layout behind it.
///
/// The geometry the old [Stack] produced, rule for rule: the content gets the
/// loose constraints a stack gives its child; the bottom row — [sizer] if
/// there is one, else [footer] — whatever width the bubble allows, as a row in
/// that column did; the box is the wider of the two and their heights plus
/// [gap]; and [footer] is laid out within that width and placed by its
/// bottom-right corner, as `Positioned(left: 0, right: 0, bottom: 0)` around
/// `Align.bottomRight` did. Absolute right, not end, as that alignment was.
class _FooterBelowAtEnd extends MultiChildRenderObjectWidget {
  _FooterBelowAtEnd({
    required this.gap,
    required Widget content,
    required Widget footer,
    Widget? sizer,
  }) : super(
          children: [
            content,
            footer,
            // Out of the gestures, as the invisible copy was. Its tickers run
            // on (it was `maintainAnimation`), so a reaction arriving sizes
            // the bubble as it grows.
            if (sizer != null) IgnorePointer(child: sizer),
          ],
        );

  final double gap;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderFooterBelowAtEnd(gap);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderFooterBelowAtEnd renderObject,
  ) {
    renderObject.gap = gap;
  }
}

class _FooterBelowParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderFooterBelowAtEnd extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _FooterBelowParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _FooterBelowParentData> {
  _RenderFooterBelowAtEnd(this._gap);

  double _gap;
  set gap(double value) {
    if (value == _gap) return;
    _gap = value;
    markNeedsLayout();
  }

  RenderBox get _content => firstChild!;
  RenderBox get _footer => childAfter(_content)!;
  RenderBox? get _sizer => childAfter(_footer);

  /// The row the bubble is measured by.
  RenderBox get _bottom => _sizer ?? _footer;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _FooterBelowParentData) {
      child.parentData = _FooterBelowParentData();
    }
  }

  BoxConstraints _rowConstraints(double maxWidth) =>
      BoxConstraints(maxWidth: maxWidth);

  Size _boxFor(BoxConstraints constraints, Size content, Size bottom) =>
      constraints.constrain(
        Size(
          content.width > bottom.width ? content.width : bottom.width,
          content.height + _gap + bottom.height,
        ),
      );

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) => _boxFor(
        constraints,
        _content.getDryLayout(constraints.loosen()),
        _bottom.getDryLayout(_rowConstraints(constraints.maxWidth)),
      );

  @override
  void performLayout() {
    final content = _content
      ..layout(constraints.loosen(), parentUsesSize: true);
    final footer = _footer;
    final sizer = _sizer;
    final Size bottom;
    if (sizer == null) {
      footer.layout(
        _rowConstraints(constraints.maxWidth),
        parentUsesSize: true,
      );
      bottom = footer.size;
      size = _boxFor(constraints, content.size, bottom);
    } else {
      sizer.layout(_rowConstraints(constraints.maxWidth), parentUsesSize: true);
      bottom = sizer.size;
      size = _boxFor(constraints, content.size, bottom);
      footer.layout(_rowConstraints(size.width), parentUsesSize: true);
      (sizer.parentData! as _FooterBelowParentData).offset =
          Offset(0, size.height - bottom.height);
    }
    (content.parentData! as _FooterBelowParentData).offset = Offset.zero;
    (footer.parentData! as _FooterBelowParentData).offset = Offset(
      size.width - footer.size.width,
      size.height - footer.size.height,
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final a = _content.getMinIntrinsicWidth(double.infinity);
    final b = _bottom.getMinIntrinsicWidth(double.infinity);
    return a > b ? a : b;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final a = _content.getMaxIntrinsicWidth(double.infinity);
    final b = _bottom.getMaxIntrinsicWidth(double.infinity);
    return a > b ? a : b;
  }

  @override
  double computeMinIntrinsicHeight(double width) =>
      _content.getMinIntrinsicHeight(width) +
      _gap +
      _bottom.getMinIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) =>
      _content.getMaxIntrinsicHeight(width) +
      _gap +
      _bottom.getMaxIntrinsicHeight(width);

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) =>
      _content.getDistanceToActualBaseline(baseline);

  // The sizer is measured and nothing else: not painted, not hit, not read
  // out — what `Visibility(visible: false, maintainSize: true)` did for it.

  @override
  bool paintsChild(RenderBox child) => child != _sizer;

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    visitor(_content);
    visitor(_footer);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final child in [_footer, _content]) {
      final data = child.parentData! as _FooterBelowParentData;
      final hit = result.addWithPaintOffset(
        offset: data.offset,
        position: position,
        hitTest: (result, transformed) =>
            child.hitTest(result, position: transformed),
      );
      if (hit) return true;
    }
    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    for (final child in [_content, _footer]) {
      final data = child.parentData! as _FooterBelowParentData;
      context.paintChild(child, data.offset + offset);
    }
  }
}

/// The bottom line of a bubble: what people reacted with, then the clock.
///
/// A [Row] with the reactions flexible and the meta fixed, so a long run of
/// chips wraps inside its own half instead of pushing the time out of the
/// bubble. With nothing to show on the left it collapses to exactly what it
/// used to be — the meta, right-aligned.
class _BubbleFooter extends StatelessWidget {
  const _BubbleFooter({
    required this.meta,
    this.reactions,
    this.spread = false,
  });

  final Widget meta;
  final Widget? reactions;

  /// Reactions against the left edge and the clock against the right, across
  /// the whole bubble. Only for the copy [_FooterBelowAtEnd] draws, whose width is
  /// the bubble's: the invisible copy that sizes the bubble must stay as
  /// narrow as its content, or every reacted bubble would stretch full width.
  ///
  /// For somebody else's message, where Telegram puts a reaction: at the start
  /// of the line the text starts on. Huddled against the clock it sat a whole
  /// line's width from the text on a long message ("реакція зліва смс або
  /// фото", 2026-10-01).
  final bool spread;

  @override
  Widget build(BuildContext context) {
    if (reactions == null) return meta;
    if (spread) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Align(alignment: Alignment.centerLeft, child: reactions),
          ),
          const SizedBox(width: 8),
          meta,
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(child: reactions!),
        const SizedBox(width: 8),
        meta,
      ],
    );
  }
}

/// The dark lozenge the clock sits in when it is drawn over a picture.
///
/// A photo can be any colour under those four characters, including white sky,
/// so the contrast has to be brought along rather than assumed.
class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(11),
      ),
      child: child,
    );
  }
}

/// Row of reaction chips shown under a bubble. Each chip carries the faces of
/// who reacted and the emoji; a chip the local user contributed to is tinted.
class _ReactionsRow extends StatelessWidget {
  const _ReactionsRow({
    required this.reactions,
    required this.fresh,
    required this.leaving,
    required this.onTap,
  });

  final Map<String, Set<String>> reactions;
  final Set<String> fresh;
  final Set<String> leaving;
  final void Function(String emoji)? onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final entry in reactions.entries)
          if (entry.value.isNotEmpty)
            _ReactionArrival(
              key: ValueKey(entry.key),
              grow: fresh.contains(entry.key),
              leaving: leaving.contains(entry.key),
              child: _ReactionChip(
                emoji: entry.key,
                reactors: entry.value,
                mine: entry.value.contains('me'),
                // A reaction on its way out is not there to be tapped: the
                // tap would put back what was just taken off.
                onTap: onTap == null || leaving.contains(entry.key)
                    ? null
                    : () => onTap!(entry.key),
              ),
            ),
      ],
    );
  }
}

/// A reaction arriving on a message, or leaving it.
///
/// The space it takes opens and closes with it, so the other chips and the
/// bubble slide over rather than jump. A factor on an [Align], not a
/// `SizeTransition`: that one keeps a clip on every chip for good, and the
/// transcript draws a lot of chips that are not moving. At rest this is a
/// plain box with nothing scheduled.
class _ReactionArrival extends StatefulWidget {
  const _ReactionArrival({
    super.key,
    required this.grow,
    required this.leaving,
    required this.child,
  });

  /// How long either way. The bubble holds a leaving chip for exactly this.
  static const Duration travel = Duration(milliseconds: 240);

  /// Read once: true only when this chip came into being because a reaction
  /// just landed, never because the bubble was built.
  final bool grow;
  final bool leaving;
  final Widget child;

  @override
  State<_ReactionArrival> createState() => _ReactionArrivalState();
}

class _ReactionArrivalState extends State<_ReactionArrival>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: _ReactionArrival.travel,
    value: widget.grow ? 0 : 1,
  );
  late final Animation<double> _room = CurvedAnimation(
    parent: _c,
    curve: AppMotion.curve,
    reverseCurve: Curves.easeInCubic,
  );
  late final Animation<double> _scale =
      Tween<double>(begin: 0.5, end: 1).animate(
    CurvedAnimation(
      parent: _c,
      curve: AppMotion.pop,
      reverseCurve: Curves.easeInCubic,
    ),
  );

  @override
  void initState() {
    super.initState();
    if (widget.grow) unawaited(_c.forward());
  }

  @override
  void didUpdateWidget(_ReactionArrival old) {
    super.didUpdateWidget(old);
    if (widget.leaving == old.leaving) return;
    unawaited(widget.leaving ? _c.reverse() : _c.forward());
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _room,
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedBuilder(
            animation: _room,
            builder: (_, child) => Align(
              alignment: Alignment.bottomLeft,
              widthFactor: _room.value,
              heightFactor: _room.value,
              child: child,
            ),
            child: widget.child,
          ),
        ),
      );
}

/// The face of one person who reacted.
///
/// The reactor id is not a roster key — it is the first sixteen hex characters
/// of the Ed25519 signing key, while the roster is keyed by the X25519
/// identity key. Handing it straight to [PeerAvatar] draws a gradient for a
/// seed nothing else in the app uses, so the same person appears in two sets
/// of colours; [KnownPeersController.bySignFingerprint] is the bridge.
class _ReactorFace extends ConsumerWidget {
  const _ReactorFace({required this.reactorId, required this.size});

  final String reactorId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (reactorId == 'me') {
      // Our own face comes from our own avatar rather than from the roster,
      // which has no card for this phone.
      final name = ref.watch(nicknameControllerProvider);
      return IdentityAvatar(
        seed: name,
        label: name,
        size: size,
        imageBytes: ref.watch(avatarProvider),
      );
    }
    // Watched for the rebuild — a picture that arrives while the chat is open
    // has to reach the chip too — and read through the notifier for the scan.
    ref.watch(knownPeersControllerProvider);
    final peer = ref
        .read(knownPeersControllerProvider.notifier)
        .bySignFingerprint(reactorId);
    if (peer == null) {
      // Somebody who left the roster, or a channel member we never met. The
      // gradient still tells two strangers apart, which is all it has to do.
      return IdentityAvatar(seed: reactorId, label: '?', size: size);
    }
    return PeerAvatar(
      peerId: peer.pubkeyHex,
      label: peer.displayName,
      size: size,
    );
  }
}

/// The faces on a chip, overlapping the way a group of them always is drawn.
class _ReactorFaces extends StatelessWidget {
  const _ReactorFaces({required this.reactors, required this.size});

  final List<String> reactors;
  final double size;

  /// How much of each face the next one covers. A third: enough to read as a
  /// stack rather than a row, little enough that two people are still two.
  static const double _overlapFraction = 0.34;

  @override
  Widget build(BuildContext context) {
    final step = size * (1 - _overlapFraction);
    return SizedBox(
      width: size + step * (reactors.length - 1),
      height: size,
      child: Stack(
        children: <Widget>[
          // Later faces sit on top, so the stack reads left to right the way
          // the list does.
          for (var i = 0; i < reactors.length; i++)
            Positioned(
              left: step * i,
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // A hairline in the chip's own colour, so overlapping faces
                  // stay separate against each other.
                  border: Border.all(
                    color: AppColors.bgDeep.withValues(alpha: 0.55),
                    width: 1,
                  ),
                ),
                child: _ReactorFace(reactorId: reactors[i], size: size),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Read by N" under one of our own channel messages.
///
/// Deliberately just a count. The names and times are one tap away in the same
/// details popup that already answers "when was this sent / read", because a
/// channel with a dozen members would otherwise put a dozen names under every
/// line — and the count is what anyone glancing at the chat actually wants.
class _ReadByChip extends StatelessWidget {
  const _ReadByChip({required this.label, required this.onTapAt});

  final String label;

  /// Takes the tap's global position, because the details popup opens anchored
  /// to where it was tapped — same as a long-press on the bubble itself.
  final void Function(Offset) onTapAt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) => onTapAt(d.globalPosition),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.glass(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glass(0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.done_all_rounded,
              size: 12,
              color: _BubbleMeta._readColor,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: _BubbleMeta._readColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReactionChip extends StatelessWidget {
  const _ReactionChip({
    required this.emoji,
    required this.reactors,
    required this.mine,
    required this.onTap,
  });

  final String emoji;
  final Set<String> reactors;
  final bool mine;
  final VoidCallback? onTap;

  /// How many faces fit before the chip stops being a chip. Past this it is a
  /// number, which is what a count is for — and in a one-to-one chat, the only
  /// place most reactions happen, there can never be more than two.
  static const int _maxFaces = 3;

  @override
  Widget build(BuildContext context) {
    final count = reactors.length;
    // Ours first, so the face you look for is always in the same place.
    final ordered = <String>[
      if (mine) 'me',
      ...reactors.where((r) => r != 'me'),
    ];
    final faces = ordered.take(_maxFaces).toList();
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        // Eases between ours and theirs when a tap joins or leaves it.
        duration: AppMotion.duration(context, AppMotion.control),
        curve: AppMotion.curve,
        // A rounded lozenge rather than a small square badge: it sits on the
        // bubble's own bottom line beside the clock, and at this size and
        // radius it reads as a chip on the message instead of a second bubble
        // stuck to it.
        //
        // Tighter than it was now that a face is inside it: the padding used
        // to be what gave the chip its height, and the avatar does that on its
        // own.
        padding: const EdgeInsets.fromLTRB(4, 3, 8, 3),
        decoration: BoxDecoration(
          color: mine
              ? AppColors.brandPrimary.withValues(alpha: 0.26)
              : AppColors.glass(0.14),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: mine
                ? AppColors.brandPrimary.withValues(alpha: 0.65)
                : AppColors.glass(0.18),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The faces before the emoji, because "who" is the part that
            // changes: the emoji is already on the chip you tapped, and in a
            // chat between two people the whole question a reaction raises is
            // which of them left it.
            // Who changed, not merely how many: a second person joining pops
            // the faces, and the chip widens with them.
            AnimatedSize(
              duration: AppMotion.duration(context, AppMotion.control),
              curve: AppMotion.curve,
              child: ValuePop(
                value: faces.join(','),
                child: _ReactorFaces(reactors: faces, size: 15),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              emoji,
              style: const TextStyle(fontSize: 14),
              textScaler: TextScaler.noScaling,
            ),
            if (count > _maxFaces) ...[
              const SizedBox(width: 4),
              ValuePop(
                value: count,
                child: Text(
                  '+${count - _maxFaces}',
                  style: TextStyle(
                    color: AppColors.textOnGlass,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// In-bubble image rendering. While the bytes are still in flight (sender
/// hasn't finished chunking, or receiver hasn't reassembled), shows a
/// placeholder block with a spinner — the bubble still occupies space so
/// the list doesn't reflow when the image finally appears.
/// How wide an album is drawn. Wider than a single photo's 220, because a grid
/// of three has to divide it and still show what is in each cell.
const double _kAlbumWidth = 252;

/// A batch of photos as one grid, the way they were sent.
///
/// Deliberately a plain grid rather than Telegram's mosaic, which sizes every
/// cell from its picture's aspect ratio. The mosaic looks better on a set of
/// mixed shapes and is a different feature: it needs each photo's dimensions
/// before the first is decoded, which this app does not record, and would send
/// the layout jumping about as they load. Equal cells need nothing and are
/// stable from the first frame.
///
/// The last row stretches to fill the width instead of leaving a hole where
/// the missing cells would be — five photos read as a row of three and a row of
/// two, not as a row of three and two thirds of a row.
class _AlbumPayload extends StatelessWidget {
  const _AlbumPayload({
    required this.messages,
    required this.chatId,
    this.onDoubleTap,
  });

  final List<Message> messages;
  final String chatId;
  final VoidCallback? onDoubleTap;

  static const _gap = 3.0;

  @override
  Widget build(BuildContext context) {
    final columns = messages.length <= 4 ? 2 : 3;
    final cell = (_kAlbumWidth - _gap * (columns - 1)) / columns;
    final rows = <List<Message>>[];
    for (var i = 0; i < messages.length; i += columns) {
      rows.add(messages.sublist(
        i,
        i + columns > messages.length ? messages.length : i + columns,
      ));
    }

    return SizedBox(
      width: _kAlbumWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: _gap),
              SizedBox(
                height: cell,
                child: Row(
                  children: [
                    for (var c = 0; c < rows[r].length; c++) ...[
                      if (c > 0) const SizedBox(width: _gap),
                      Expanded(
                        child: _AlbumCell(
                          message: rows[r][c],
                          chatId: chatId,
                          width: cell,
                          onDoubleTap: onDoubleTap,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AlbumCell extends StatelessWidget {
  const _AlbumCell({
    required this.message,
    required this.chatId,
    required this.width,
    this.onDoubleTap,
  });

  final Message message;
  final String chatId;

  /// The drawn width, which is also the decode width — a grid of nine photos
  /// decoded at the size they were sent is the single most expensive thing a
  /// conversation can ask of this phone.
  final double width;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final path = message.imagePath;
    if (path == null || !MediaPaths.exists(path)) {
      return _ImagePlaceholder(
        icon: message.status == MessageStatus.failed
            ? Icons.broken_image_rounded
            : Icons.image_rounded,
        label: '',
        spinning: message.status == MessageStatus.sending,
      );
    }
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      // Straight to this photo, not to the album's first — tapping the fourth
      // picture and being shown the first is the sort of thing that makes a
      // grid feel like a picture of a grid.
      onTap: () => Navigator.of(context).push(
        mediaRoute<void>(
          (_) => ChatMediaGalleryScreen(
            chatId: chatId,
            initialMessageId: message.id,
          ),
        ),
      ),
      child: Hero(
        tag: 'image-${message.id}',
        flightShuttleBuilder: photoFlightShuttle(path),
        child: TransitionProbe.instance.placeholderMedia.value
            ? const _MediaPlaceholder()
            : Image.file(
                File(path),
                fit: BoxFit.cover,
                cacheWidth:
                    (width * MediaQuery.devicePixelRatioOf(context)).round(),
                errorBuilder: (_, __, ___) => _ImagePlaceholder(
                  icon: Icons.broken_image_rounded,
                  label: '',
                ),
              ),
      ),
    );
  }
}

/// A photo that is not decoded: the Diagnostics experiment that measures a
/// chat opening without any of its pictures - see
/// [TransitionProbe.placeholderMedia].
class _MediaPlaceholder extends StatelessWidget {
  const _MediaPlaceholder();

  @override
  Widget build(BuildContext context) =>
      const ColoredBox(color: Color(0x33FFFFFF), child: SizedBox.expand());
}

class _ImagePayload extends StatelessWidget {
  const _ImagePayload({
    required this.message,
    required this.chatId,
    this.onDoubleTap,
  });

  final Message message;
  final String chatId;

  /// Quick-reaction handler, handed down from the bubble.
  ///
  /// A photo owns its own tap (it opens the viewer), and a child's tap wins the
  /// arena outright — so without this the second tap of a double-tap would just
  /// open the gallery and the reaction would never fire. Registering both on the
  /// same detector lets Flutter hold the single tap until the double-tap window
  /// closes, which costs the viewer a barely perceptible delay and is what makes
  /// the gesture work on media at all.
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final path = message.imagePath;
    final fileExists = path != null && MediaPaths.exists(path);

    // A view-once photo never renders as a thumbnail. The whole point is that
    // it is looked at deliberately, once — a picture you can scroll past twice
    // in the transcript has already been seen more than once.
    if (message.viewOnce) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220, maxHeight: 220),
        child: _ViewOncePayload(
          message: message,
          chatId: chatId,
          available: fileExists,
        ),
      );
    }

    final heroTag = 'image-${message.id}';
    // A sticker does not open, and it has no flight either.
    //
    // It is a gesture, not a document: there is nothing inside one to look at
    // closer, so a full-screen viewer for it is a dead end somebody has to
    // back out of — and it is the easiest thing in a conversation to hit by
    // accident, being a large target with no text on it. Holding it still
    // lights it in the spotlight with everything that can be done to it, which
    // is where a sticker's actions belong and where Telegram keeps them too.
    final opens = fileExists && !message.isSticker;
    final picture =
        TransitionProbe.instance.placeholderMedia.value && !message.isSticker
            ? const _MediaPlaceholder()
            : Image.file(
                // Only ever drawn on the `fileExists` side of the branch below, which is
                // where the null check lives.
                File(path!),
                // A sticker is drawn whole, not cropped to a square: it has a shape,
                // usually with transparency around it, and cover would trim exactly the
                // part that gives it one.
                fit: message.isSticker ? BoxFit.contain : BoxFit.cover,
                // Decoded at the size it is drawn, not the size it was sent.
                //
                // Without this the bubble decodes the whole photo — the mesh encoder
                // tops out around 1600 px, so that is a 1600×1600 bitmap, ten megabytes
                // of it, to fill a box 220 points wide. Every photo in the conversation,
                // held in the image cache. Scrolling a chat with pictures in it then
                // costs a full-resolution decode per photo and a texture upload to
                // match, which is most of why such a chat warms the phone. At the drawn
                // size it is a twenty-fifth of the pixels.
                cacheWidth: ((message.isSticker
                            ? kStickerWidth
                            : photoBubbleWidth(context)) *
                        MediaQuery.devicePixelRatioOf(context))
                    .round(),
                errorBuilder: (_, __, ___) => _ImagePlaceholder(
                  icon: Icons.broken_image_rounded,
                  label: message.imageMime ?? 'image',
                ),
              );
    final body = fileExists
        ? GestureDetector(
            onDoubleTap: onDoubleTap,
            onTap: opens
                ? () => Navigator.of(context).push(
                      mediaRoute<void>(
                        (_) => ChatMediaGalleryScreen(
                          chatId: chatId,
                          initialMessageId: message.id,
                        ),
                      ),
                    )
                : null,
            child: opens
                // No rounding of its own any more: the bubble clips to its own
                // corners now that the photo reaches them, and a second,
                // tighter radius inside that one drew a visible sliver of
                // bubble in each corner — the frame this change exists to
                // remove, only thinner.
                ? Hero(
                    tag: heroTag,
                    flightShuttleBuilder: photoFlightShuttle(path),
                    child: ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: picture,
                    ),
                  )
                : picture,
          )
        : _ImagePlaceholder(
            icon: message.status == MessageStatus.failed
                ? Icons.broken_image_rounded
                : Icons.image_rounded,
            label: message.imageMime ?? message.text,
            spinning: message.status == MessageStatus.sending,
          );

    final width = message.isSticker ? kStickerWidth : photoBubbleWidth(context);
    return ConstrainedBox(
      // Stickers keep a size of their own — see [kStickerWidth]. A photo takes
      // the width it is given and as much height as its own shape asks for,
      // capped so a panorama shot in portrait cannot become a bubble you have
      // to scroll past.
      constraints: BoxConstraints(
        // Stretched to the column, not only capped by it. A portrait
        // screenshot drew at its own narrow shape with the bubble showing down
        // one side; `cover` crops it to the column instead, the way a photo in
        // any messenger fills its bubble.
        minWidth: message.isSticker ? 0 : width,
        maxWidth: width,
        maxHeight: message.isSticker ? kStickerWidth : width * 1.25,
      ),
      child: body,
    );
  }
}

/// Whether tapping a view-once bubble may open the photo.
///
/// Never for our own: a photo you sent is gone from here the moment it leaves,
/// the way Telegram treats one. It used to stay openable until the recipient's
/// ack came back, which read as "still mine for now" and was worse than it
/// sounds — the viewer fired the same "I have seen it" notice for it, so
/// glancing at what you sent destroyed the copy the other person had not
/// opened. There is nothing to look at anyway now: an outgoing view-once photo
/// is never written to this phone's disk.
///
/// [fileExists] is the received half — the bytes may still be arriving, or have
/// already been burned.
bool viewOnceCanBeOpened(Message message, {required bool fileExists}) =>
    !message.isMine && !message.viewOnceConsumed && fileExists;

/// The states a view-once photo can be in: waiting to be opened, spent, still
/// arriving, or one of ours that was sent.
///
/// Deliberately never the picture itself. Tapping opens
/// [ViewOnceMediaScreen] — not the swipeable gallery, which has Share and
/// Save buttons and would happily page from this photo to every other one in
/// the chat.
class _ViewOncePayload extends ConsumerWidget {
  const _ViewOncePayload({
    required this.message,
    required this.chatId,
    required this.available,
  });

  final Message message;
  final String chatId;
  final bool available;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final spent = message.viewOnceConsumed;
    final mine = message.isMine;
    final openable = viewOnceCanBeOpened(message, fileExists: available);

    return GestureDetector(
      onTap: openable
          ? () => Navigator.of(context).push(
                mediaRoute<void>(
                  (_) => ViewOnceMediaScreen(
                    chatId: chatId,
                    message: message,
                  ),
                ),
              )
          : null,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.glass(spent ? 0.05 : 0.12),
          border: Border.all(
            color: spent
                ? AppColors.glass(0.10)
                : AppColors.brandPrimary.withValues(alpha: 0.35),
          ),
        ),
        // Centred as a group rather than left-aligned with the text filling
        // whatever is left: on two lines the old layout put the icon against
        // one edge and a ragged block of text against the other, which read as
        // a mistake rather than a label.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              spent
                  ? Icons.visibility_off_rounded
                  : mine
                      ? Icons.done_rounded
                      : Icons.local_fire_department_rounded,
              size: 20,
              color:
                  spent ? AppColors.textOnGlassFaint : AppColors.brandPrimary,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                // Four states, and the one that is ours says only that it went.
                // "Opened" still lands on it afterwards, which is the one piece
                // of news the sender does want: they looked.
                spent
                    ? t.viewOnceOpened
                    : mine
                        ? t.viewOnceSent
                        : openable
                            ? t.viewOnceTapToView
                            : t.viewOnceUnavailable,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: spent
                      ? AppColors.textOnGlassFaint
                      : AppColors.textOnGlass,
                  fontSize: 13,
                  fontWeight: spent ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({
    required this.icon,
    required this.label,
    this.spinning = false,
  });

  final IconData icon;
  final String label;
  final bool spinning;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.glass(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (spinning)
            SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.brandPrimary,
              ),
            )
          else
            Icon(icon, color: AppColors.textOnGlassDim, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

/// The filling circle over a picture that is still on its way out.
///
/// Reads [mediaSendProgressProvider], which the send loop reports chunks to. A
/// transfer that has not reported yet — the manifest is still going, or this is
/// a build that predates the reporting — shows an indeterminate spinner rather
/// than an empty ring sitting at zero, because those two look identical and
/// mean opposite things.
class _SendProgressRing extends ConsumerWidget {
  const _SendProgressRing({
    required this.messageId,
    this.diameter = 46,
    this.onSurface = false,
    this.onCancel,
  });

  final String messageId;
  final double diameter;

  /// Tapping the ring takes the send back — a cross in its middle, the way
  /// Telegram draws it. Only the disc answers; a tap beside it still reaches
  /// the picture underneath.
  final VoidCallback? onCancel;

  /// True when the ring sits on the bubble beside its content rather than over
  /// a photograph. There is no picture to lift it off, so it drops the dark
  /// disc that exists purely for contrast against one.
  final bool onSurface;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // One message's progress, not the map. A batch of photos writes progress
    // for whichever one is transferring, several times a second; watching the
    // map rebuilt the ring on every *other* sending bubble at that rate too.
    final value = ref.watch(
      mediaSendProgressProvider.select((p) => p[messageId]),
    );
    final disc = Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: onSurface
            ? Colors.transparent
            : Colors.black.withValues(alpha: 0.42),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(onSurface ? 2 : 9),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: TweenAnimationBuilder<double>(
              // Chunk reports arrive in visible steps; the ring should sweep
              // between them rather than tick.
              tween: Tween<double>(begin: 0, end: value ?? 0),
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOut,
              builder: (context, animated, _) => CircularProgressIndicator(
                value: value == null ? null : animated,
                strokeWidth: 2.4,
                backgroundColor: Colors.white.withValues(alpha: 0.28),
                color: AppColors.brandPrimary,
              ),
            ),
          ),
          if (onCancel != null)
            Icon(
              Icons.close_rounded,
              size: diameter * 0.42,
              color: onSurface ? AppColors.textOnGlass : Colors.white,
            ),
        ],
      ),
    );
    return Center(
      child: onCancel == null
          ? disc
          : Semantics(
              button: true,
              label: AppLocalizations.of(context).chatCancelSend,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCancel,
                child: disc,
              ),
            ),
    );
  }
}

/// The road a message took, in words: "Bluetooth напряму", "Меш · 3
/// пересилання", "Інтернет". The same answer the mark beside the time gives,
/// for the details under a long press and for a screen reader.
String messageRouteText(
  AppLocalizations t,
  ({RouteBadgeKind kind, int? hops}) badge,
) {
  final hops = badge.hops;
  return switch (badge.kind) {
    RouteBadgeKind.bluetooth => t.chatRouteBluetoothDirect,
    RouteBadgeKind.mesh =>
      hops == null ? t.chatRouteMesh : t.chatRouteMeshHops(hops),
    RouteBadgeKind.internet => t.chatRouteInternet,
  };
}

/// The line a bubble ends on: the saved-note tag, the pin, the lock, "edited",
/// the road the message came by, the time, and on ours the tick.
///
/// **One paragraph since 1200**, the icons drawn as glyphs of their own font
/// inside it. It was a [Row] of three to six widgets — every icon an [Icon]
/// (six elements and a paragraph of its own), every gap a [SizedBox] — and on
/// the S24+ this row was the most expensive thing a bubble laid out:
/// `meta.layout` 26 ms per 5 s of scrolling against 11 ms for the message
/// text (1194), still 17 ms once the invisible sizing copy was gone (1196).
/// Each [Icon] is a separate paragraph to shape; this is one.
///
/// What it costs in looks: a glyph in a paragraph sits on the baseline,
/// where the row centred each icon on the line. The Material icon font is
/// all ascent (512 of 512 units, no descent), so a 12 pt icon's box now ends
/// on the time's baseline instead of 1.5 pt under it — the pin, the lock and
/// the tick ride about 2 pt higher against the digits than they did, the
/// 10.5 pt road mark about 1.3 pt. Sizes, colours, the 4 pt gaps (letter
/// spacing after the glyph) and the line's height are as they were;
/// `test/bubble_meta_paragraph_test.dart` holds the sizes against the real
/// fonts.
///
/// The tick still pops when it changes. At rest it is in the paragraph; for
/// the length of a pop it steps out into a box of its own beside the line,
/// baseline-aligned so it lands exactly where the paragraph puts it, and
/// steps back in when the pop is over. A screenful of bubbles at rest holds
/// no switcher, no stack and no transitions for it — the [ValuePop] it
/// replaces kept all three on every one of our bubbles.
class _BubbleMeta extends StatefulWidget {
  const _BubbleMeta({
    required this.message,
    this.pinned = false,
    this.onMedia = false,
    this.onOwnFill = false,
    this.tag,
  });

  final Message message;

  /// True when this row sits on our own green fill, where white ink and the
  /// light-blue read ticks blended in; it takes the palette's darkest instead.
  final bool onOwnFill;

  /// The saved-note tag on this message, or null. Shown at the head of the
  /// meta line so a tagged note reads as tagged without opening it — the same
  /// place a pin or a shield sits, for the same reason.
  final String? tag;

  /// True when this is the chat's pinned message.
  final bool pinned;

  /// True when this row is drawn over the picture rather than under it, on the
  /// dark pill — where the sender's own tint is the wrong contrast to reach
  /// for, because what is behind it is a photograph and not a bubble.
  final bool onMedia;

  /// Distinct tint for a "read" tick so it reads apart from plain delivery —
  /// the theme's, shared with the chat list.
  static const _readColor = AppColors.readTick;

  @override
  State<_BubbleMeta> createState() => _BubbleMetaState();
}

class _BubbleMetaState extends State<_BubbleMeta>
    with SingleTickerProviderStateMixin {
  /// The row's [SizedBox] gaps, now letter spacing after the item before.
  static const double _gap = 4;

  /// Made the first time the tick changes under this bubble, which most
  /// bubbles never see.
  AnimationController? _pop;
  late CurvedAnimation _popIn;
  late CurvedAnimation _popOut;

  /// The tick being replaced, shrinking away under the new one during a pop.
  InlineSpan? _leaving;

  /// [ValuePop]'s numbers, so the pop looks as it did.
  static final _grow = Tween<double>(begin: 0.6, end: 1);

  /// What decides whether the tick has changed — the same pair [ValuePop]
  /// was keyed on.
  static (MessageStatus, bool) _tickKey(Message m) =>
      (m.status, m.route == MessageRoute.queued);

  @override
  void didUpdateWidget(_BubbleMeta old) {
    super.didUpdateWidget(old);
    if (!widget.message.isMine ||
        _tickKey(old.message) == _tickKey(widget.message)) {
      return;
    }
    final duration = AppMotion.duration(context, AppMotion.control);
    if (duration == Duration.zero) return;
    _leaving = _tick(
      old.message,
      onOwnFill: old.onOwnFill,
      onMedia: old.onMedia,
      t: AppLocalizations.of(context),
    ).$1;
    var pop = _pop;
    if (pop == null) {
      pop = _pop = AnimationController(vsync: this)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            setState(() => _leaving = null);
          }
        });
      _popIn = CurvedAnimation(parent: pop, curve: AppMotion.pop);
      _popOut = CurvedAnimation(
        parent: ReverseAnimation(pop),
        curve: Curves.easeInCubic,
      );
    }
    pop
      ..duration = duration
      ..forward(from: 0);
  }

  @override
  void dispose() {
    if (_pop case final pop?) {
      _popIn.dispose();
      _popOut.dispose();
      pop.dispose();
    }
    super.dispose();
  }

  /// The ink for everything in this row, given what it is drawn on.
  static Color _ink(
    double onBubble, {
    required bool onMedia,
    required bool onOwnFill,
  }) =>
      onMedia
          ? Colors.white.withValues(alpha: 0.95)
          : onOwnFill
              ? AppColors.bgDeep.withValues(alpha: onBubble)
              : AppColors.ink(onBubble);

  /// [icon] as a run of text in its own font.
  ///
  /// [Icon] draws with `height: 1` and the box centred; here the 12 pt ones
  /// take `height: 0.75`, so the glyph claims no more of the line above the
  /// baseline than Inter's 11 pt time does (0.969 em ascent, 10.7 pt) and the
  /// line keeps the height the row had. The glyph itself is drawn the same
  /// size either way.
  ///
  /// No `semanticsLabel` on the span: what a screen reader hears is the
  /// line's own label, put together in [build] in the same order — the words
  /// the [Icon]s' labels said, without a private-use character in the middle
  /// of the paragraph's text for anything that reads it as text.
  static TextSpan _glyph(
    IconData icon, {
    required double size,
    required Color color,
    double after = 0,
  }) =>
      TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontFamilyFallback: icon.fontFamilyFallback,
          fontSize: size,
          height: size > 11 ? 0.75 : 1,
          leadingDistribution: TextLeadingDistribution.even,
          color: color,
          letterSpacing: after,
        ),
      );

  /// [text] in [style], with [after] of space following its last character.
  static void _words(
    List<InlineSpan> into,
    String text,
    TextStyle style, {
    double after = 0,
  }) {
    if (after == 0 || text.isEmpty) {
      into.add(TextSpan(text: text, style: style));
      return;
    }
    final chars = text.characters;
    if (chars.length > 1) {
      into.add(TextSpan(text: chars.skipLast(1).toString(), style: style));
    }
    into.add(
      TextSpan(
        text: chars.last,
        style: style.copyWith(letterSpacing: after),
      ),
    );
  }

  /// The tick, and what it says.
  static (TextSpan, String) _tick(
    Message message, {
    required bool onOwnFill,
    required bool onMedia,
    required AppLocalizations t,
  }) {
    // Two different waits, which used to share one clock: a message on its
    // way right now, and one that found no road at all and is held until
    // Bluetooth or the internet comes back. The second can last hours, and
    // "always show whether it is waiting for a connection or delivered" was
    // asked for in so many words.
    final queued = message.route == MessageRoute.queued;
    final glyph = _glyph(
      switch (message.status) {
        MessageStatus.sending =>
          queued ? Icons.cloud_off_rounded : Icons.schedule_rounded,
        MessageStatus.delivered => Icons.done_rounded,
        MessageStatus.read => Icons.done_all_rounded,
        MessageStatus.failed => Icons.error_outline_rounded,
      },
      size: 12,
      color: switch (message.status) {
        MessageStatus.failed => AppColors.danger,
        // On our fill the read pair is the full dark, the delivered tick a
        // shade lighter: the light blue vanished into the green.
        MessageStatus.read =>
          onOwnFill ? AppColors.bgDeep : _BubbleMeta._readColor,
        _ => _ink(
            onOwnFill ? 0.6 : 0.85,
            onMedia: onMedia,
            onOwnFill: onOwnFill,
          ),
      },
    );
    return (
      glyph,
      switch (message.status) {
        MessageStatus.sending =>
          queued ? t.chatWaitingForConnection : t.chatSending,
        MessageStatus.delivered => t.chatDelivered,
        MessageStatus.read => t.chatRead,
        MessageStatus.failed => '!',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = widget;
    final t = AppLocalizations.of(context);
    final message = w.message;
    final mine = message.isMine;
    Color ink(double onBubble) =>
        _ink(onBubble, onMedia: w.onMedia, onOwnFill: w.onOwnFill);
    final spans = <InlineSpan>[];
    // What the line says out loud, item by item, as the row's widgets did.
    final said = <String>[];

    if (w.tag case final tag?) {
      _words(spans, tag, const TextStyle(fontSize: 12), after: _gap);
      said.add(tag);
    }
    if (w.pinned) {
      spans.add(
        _glyph(
          Icons.push_pin_rounded,
          size: 12,
          color: ink(mine ? 0.8 : 0.55),
          after: _gap,
        ),
      );
      said.add(t.chatPinnedTitle);
    }
    if (message.forwardSecret) {
      spans.add(
        _glyph(
          Icons.lock_clock_rounded,
          size: 12,
          color: ink(mine ? 0.8 : 0.55),
          after: _gap,
        ),
      );
      said.add('forward secret');
    }
    if (message.editedAt != null) {
      _words(
        spans,
        t.chatEdited,
        TextStyle(fontSize: 11, color: ink(mine ? 0.7 : 0.45)),
        after: _gap,
      );
      said.add(t.chatEdited);
    }
    // Which way this message came — see [routeBadgeFor]. Small and as dim as
    // the clock: a fact for whoever looks, not a status to read.
    if (routeBadgeFor(message) case final badge?) {
      final hops = badge.hops;
      spans.add(
        _glyph(
          switch (badge.kind) {
            RouteBadgeKind.bluetooth => Icons.bluetooth_rounded,
            RouteBadgeKind.mesh => Icons.hub_rounded,
            RouteBadgeKind.internet => Icons.public_rounded,
          },
          size: 10.5,
          color: ink(mine ? 0.7 : 0.45),
          after: hops != null ? 1 : _gap,
        ),
      );
      said.add(messageRouteText(t, badge));
      if (hops != null) {
        _words(
          spans,
          '$hops',
          TextStyle(fontSize: 11, color: ink(mine ? 0.7 : 0.45)),
          after: _gap,
        );
        said.add('$hops');
      }
    }
    final time = formatBubbleTime(context, message.sentAt);
    _words(
      spans,
      time,
      TextStyle(fontSize: 11, color: ink(mine ? 0.8 : 0.5)),
      after: mine ? _gap : 0,
    );
    said.add(time);

    final pop = _pop;
    final popping = pop != null && (pop.isAnimating || _leaving != null);
    final (tick, tickSays) =
        _tick(message, onOwnFill: w.onOwnFill, onMedia: w.onMedia, t: t);
    if (mine && !popping) {
      spans.add(tick);
      said.add(tickSays);
    }
    final line = Text.rich(
      TextSpan(children: spans),
      semanticsLabel: said.join(' '),
    );
    if (!mine || !popping) return line;

    // The tick changed while this bubble was on screen — the one moment the
    // icon is news. Out of the paragraph for the length of the pop.
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        line,
        Stack(
          alignment: Alignment.center,
          children: [
            if (_leaving case final leaving?)
              ExcludeSemantics(
                child: FadeTransition(
                  opacity: _popOut,
                  child: ScaleTransition(
                    scale: _grow.animate(_popOut),
                    child: Text.rich(leaving),
                  ),
                ),
              ),
            FadeTransition(
              opacity: _popIn,
              child: ScaleTransition(
                scale: _grow.animate(_popIn),
                child: Text.rich(tick, semanticsLabel: tickSays),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// "Comments" under a channel post, opening the room they live in.
///
/// A link rather than a count. Counting them would mean reading the discussion
/// room to draw the channel, and the discussion room is a separate
/// conversation that a reader may not have opened yet — so the number would be
/// zero until they looked, which is worse than no number.
class _CommentsLink extends ConsumerWidget {
  const _CommentsLink({required this.channelName, required this.post});

  final String channelName;

  /// Which post this opens the comments *on*. It used to open the whole
  /// discussion room, so every announcement's comments were the same flat
  /// conversation and "what was said about this one" had no answer.
  final Message post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => openPostComments(
        context,
        channelName: channelName,
        post: post,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mode_comment_outlined,
            size: 14,
            color: AppColors.brandPrimary,
          ),
          const SizedBox(width: 5),
          Text(
            t.channelPostComments,
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Who wrote this before it was passed on.
///
/// Their face and their name, above the bubble rather than inside it: the
/// words below are theirs, and a bubble that quoted them into a sentence would
/// read as the forwarder saying them.
///
/// Tappable only when the attribution carried a way back to them — see
/// [Message.forwardedFromId]. An older build's forward, a room's, and one from
/// somebody who asked not to be linked all arrive without it and all read the
/// same: a name, going nowhere. Nothing in the row moves between the two
/// states, so a forward that cannot be followed does not look like a control
/// that is broken.
class _ForwardHeader extends ConsumerWidget {
  const _ForwardHeader({required this.name, this.authorId});

  final String name;
  final String? authorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = authorId;
    // Our own words, passed on. The face comes from our own avatar rather than
    // from the contacts roster, which has no card for this phone.
    final ours = id == Message.selfAuthorId;
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (ours) ...[
          IdentityAvatar(
            seed: name,
            label: name,
            size: 16,
            imageBytes: ref.watch(avatarProvider),
          ),
          const SizedBox(width: 6),
        ] else if (id != null) ...[
          PeerAvatar(peerId: id, label: name, size: 16),
          const SizedBox(width: 6),
        ] else ...[
          Icon(
            Icons.shortcut_rounded,
            size: 14,
            color: AppColors.brandSecondary,
          ),
          const SizedBox(width: 5),
        ],
        Flexible(
          child: Text(
            AppLocalizations.of(context).chatForwardedFrom(name),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.brandSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
    if (id == null) return row;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // Our own profile is a tab, not a contact card. Pushing `/person/<our
      // key>` would open the screen built for somebody else and fill it with
      // nothing: no verification, no last seen, no way to write to them.
      onTap: () => context.push(
        ours ? '/profile' : '/person/$id?name=${Uri.encodeComponent(name)}',
      ),
      child: row,
    );
  }
}
