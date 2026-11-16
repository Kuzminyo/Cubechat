import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';
import '../../../core/transport/ports/conversation_prefs.dart';
import '../../chats/data/message_requests_controller.dart';
import '../../profile/data/privacy_settings_controller.dart';
import '../../../core/models/conversation_settings.dart';
import 'messages_controller.dart';

// The models live in core; re-exported so the chat's code keeps reading them
// from here.
export '../../../core/models/conversation_settings.dart';

/// Per-conversation privacy preferences.
///
/// Auto-delete and the wallpaper are local: two people in the same chat can
/// each pick their own, and nothing about either goes on the wire. The copy
/// restriction is the exception — it is a request *about the conversation*,
/// so it travels (as an `InnerPayloadType.copyRestriction` frame) and arrives
/// here as [ConversationSettings.peerRestrictsCopying]. Message surfaces read
/// [ConversationSettings.copyingRestricted], which is both sides at once, so
/// copy, forward and system-share controls disappear together whichever end
/// asked for it.
class ConversationSettingsController
    extends Notifier<Map<String, ConversationSettings>>
    implements ConversationPrefs {
  static const _key = 'conversation_settings';

  Box<dynamic>? _box;
  Timer? _pruneTimer;
  Future<void>? _loading;

  Future<void> get loaded => _loading ?? Future<void>.value();

  @override
  Map<String, ConversationSettings> build() {
    _pruneTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => unawaited(pruneExpired()),
    );
    ref.onDispose(() => _pruneTimer?.cancel());
    unawaited(_loading = _load());
    return const <String, ConversationSettings>{};
  }

  ConversationSettings forChat(String chatId) =>
      state[chatId] ?? ConversationSettings.initial;

  Future<void> setAutoDelete(
    String chatId,
    ChatAutoDelete period,
  ) async {
    final before = forChat(chatId);
    // The anchor moves only on off→on. Turning it off drops it, so switching
    // back on later starts a fresh window rather than resurrecting the reach of
    // a setting that was cancelled; changing the period while it is on keeps
    // it, so a shorter timer still cannot bite into anything older than the
    // moment the user first said yes.
    final next = period.isOn
        ? before.copyWith(
            autoDelete: period,
            autoDeleteFrom: before.autoDelete.isOn
                ? (before.autoDeleteFrom ?? DateTime.now())
                : DateTime.now(),
          )
        : before.copyWith(autoDelete: period, clearAutoDeleteFrom: true);
    await _put(chatId, next);
    await _pruneChat(chatId, period, next.autoDeleteFrom);
  }

  Future<void> setRestrictCopying(String chatId, bool restricted) =>
      _put(chatId, forChat(chatId).copyWith(restrictCopying: restricted));

  /// Record what the peer asked for. Called from the transport when their
  /// [InnerPayloadType.copyRestriction] lands — never from the UI, because
  /// this half of the setting is not ours to change.
  Future<void> setPeerRestrictsCopying(String chatId, bool restricted) =>
      _put(chatId, forChat(chatId).copyWith(peerRestrictsCopying: restricted));

  Future<void> setWallpaper(String chatId, ChatWallpaper wallpaper) =>
      _put(chatId, forChat(chatId).copyWith(wallpaper: wallpaper));

  /// Try the internet before the radios for this conversation.
  Future<void> setPreferRelay(String chatId, bool prefer) =>
      _put(chatId, forChat(chatId).copyWith(preferRelay: prefer));

  bool prefersRelay(String chatId) => forChat(chatId).preferRelay;

  /// Silence a conversation, optionally until a moment.
  ///
  /// [until] null means indefinitely. Turning it off clears the deadline too,
  /// so switching a timed mute off and on again does not resurrect a stale one.
  Future<void> setMuted(String chatId, bool muted, {DateTime? until}) => _put(
        chatId,
        forChat(chatId).copyWith(
          muted: muted,
          mutedUntil: muted ? until : null,
          clearMutedUntil: !muted || until == null,
        ),
      );

  bool isMuted(String chatId) => forChat(chatId).isMutedNow;

  Future<void> setHideAvatar(String chatId, bool hidden) =>
      _put(chatId, forChat(chatId).copyWith(hideAvatar: hidden));

  Future<void> setHideLastSeen(String chatId, bool hidden) =>
      _put(chatId, forChat(chatId).copyWith(hideLastSeen: hidden));

  Future<void> setHideReadReceipts(String chatId, bool hidden) =>
      _put(chatId, forChat(chatId).copyWith(hideReadReceipts: hidden));

  /// This person's exception to the calls switch, or null to follow it.
  Future<void> setAcceptCalls(String chatId, bool? accept) => _put(
        chatId,
        forChat(chatId).copyWith(
          acceptCalls: accept,
          clearAcceptCalls: accept == null,
        ),
      );

  /// Whether a call from [chatId] may ring: this person's exception if they
  /// have one, the global switch otherwise. Unlike the three below, an
  /// exception can be more open than the switch as well as less — that is
  /// what "nobody, except" is.
  ///
  /// A stranger still waiting in Requests cannot ring at all, whatever the
  /// switch says — accepting the request is what lets them.
  bool acceptsCallsFrom(String chatId) =>
      !ref.read(messageRequestsProvider).pending.contains(chatId) &&
      (forChat(chatId).acceptCalls ??
          ref.read(privacySettingsProvider).acceptCalls);

  /// The three questions the transport asks before it sends something about
  /// us, answered by the global switch and this contact's exception together.
  ///
  /// Always the more private of the two, and only ever in that direction: an
  /// exception can withhold from one person what everybody else gets, and can
  /// never hand out what the global switch has already refused. Combined here
  /// rather than at each call site so that rule has one home.
  bool sharesAvatarWith(String chatId) => !forChat(chatId).hideAvatar;

  bool sharesLastSeenWith(String chatId) =>
      ref.read(privacySettingsProvider).shareLastSeen &&
      !forChat(chatId).hideLastSeen;

  bool sharesReadReceiptsWith(String chatId) =>
      ref.read(privacySettingsProvider).shareReadReceipts &&
      !forChat(chatId).hideReadReceipts &&
      // A stranger's request learns nothing — not even that it was read —
      // until it is accepted.
      !ref.read(messageRequestsProvider).pending.contains(chatId);

  Future<void> forget(String chatId) async {
    if (!state.containsKey(chatId)) return;
    state = {...state}..remove(chatId);
    await _persist();
  }

  Future<void> clear() async {
    state = const <String, ConversationSettings>{};
    try {
      await _box?.delete(_key);
    } catch (e) {
      debugPrint('ConversationSettings clear failed: $e');
    }
  }

  Future<void> pruneExpired() async {
    // Messages with a deadline of their own go first, and in every chat rather
    // than only in the ones with a conversation-wide rule — a timer put on one
    // line has nothing to do with whether the chat has a setting.
    ref.read(messagesControllerProvider.notifier).pruneExpiredMessages();
    for (final entry in state.entries) {
      await _pruneChat(
        entry.key,
        entry.value.autoDelete,
        entry.value.autoDeleteFrom,
      );
    }
  }

  Future<void> _pruneChat(
    String chatId,
    ChatAutoDelete period,
    DateTime? from,
  ) async {
    final lifetime = period.duration;
    if (lifetime == null) return;
    final cutoff = DateTime.now().subtract(lifetime);
    await ref
        .read(messagesControllerProvider.notifier)
        .deleteBefore(chatId, cutoff, since: from);
  }

  Future<void> _put(String chatId, ConversationSettings value) async {
    final next = {...state};
    if (value.isDefault) {
      next.remove(chatId);
    } else {
      next[chatId] = value;
    }
    state = next;
    await _persist();
  }

  Future<void> _load() async {
    try {
      final box = await hiveCipherProvider
          .openEncryptedBox<dynamic>(HiveBoxes.settings);
      _box = box;
      final raw = box.get(_key);
      if (raw is Map) {
        final loaded = <String, ConversationSettings>{};
        for (final entry in raw.entries) {
          if (entry.key is! String || entry.value is! Map) continue;
          final value = entry.value as Map;
          // `autoDeleteSeconds` is what this build writes; `autoDelete` is
          // the enum name older installs stored, and is still read so an
          // existing setting is not silently switched off by an update.
          final rawSeconds = value['autoDeleteSeconds'];
          final period = rawSeconds is int
              ? ChatAutoDelete(rawSeconds.clamp(0, ChatAutoDelete.maxSeconds))
              : ChatAutoDelete.fromLegacyName(value['autoDelete'] as String?);
          // Absent for a setting saved before the anchor existed. Left null,
          // which reads as "no lower bound" and keeps those installs behaving
          // exactly as they did — the alternative, stamping them with `now`,
          // would spare messages the old build had already been deleting.
          final rawFrom = value['autoDeleteFromMs'];
          final settings = ConversationSettings(
            autoDelete: period,
            autoDeleteFrom: rawFrom is int
                ? DateTime.fromMillisecondsSinceEpoch(rawFrom)
                : null,
            restrictCopying: value['restrictCopying'] == true,
            peerRestrictsCopying: value['peerRestrictsCopying'] == true,
            wallpaper: ChatWallpaper(
              presetIndex: value['wallpaperPreset'] as int?,
              // Only the path — the bytes live in app storage, and putting a
              // picture inside the settings map would load every chat's
              // wallpaper on every read of this box.
              imagePath: value['wallpaperImage'] as String?,
              dim: (value['wallpaperDim'] as num?)?.toDouble() ?? 0.35,
            ),
            hideAvatar: value['hideAvatar'] == true,
            hideLastSeen: value['hideLastSeen'] == true,
            hideReadReceipts: value['hideReadReceipts'] == true,
            acceptCalls: value['acceptCalls'] as bool?,
            preferRelay: value['preferRelay'] == true,
            muted: value['muted'] == true,
            mutedUntil: value['mutedUntilMs'] is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    value['mutedUntilMs'] as int,
                  )
                : null,
          );
          if (!settings.isDefault) loaded[entry.key as String] = settings;
        }
        if (loaded.isNotEmpty) state = {...loaded, ...state};
      }
      await pruneExpired();
    } catch (e) {
      debugPrint('ConversationSettings load failed: $e');
    }
  }

  Future<void> _persist() async {
    final box = _box;
    if (box == null) return;
    try {
      await box.put(_key, {
        for (final entry in state.entries)
          entry.key: {
            'autoDeleteSeconds': entry.value.autoDelete.seconds,
            if (entry.value.autoDeleteFrom != null)
              'autoDeleteFromMs':
                  entry.value.autoDeleteFrom!.millisecondsSinceEpoch,
            'restrictCopying': entry.value.restrictCopying,
            'peerRestrictsCopying': entry.value.peerRestrictsCopying,
            if (entry.value.wallpaper.presetIndex != null)
              'wallpaperPreset': entry.value.wallpaper.presetIndex,
            if (entry.value.wallpaper.imagePath != null)
              'wallpaperImage': entry.value.wallpaper.imagePath,
            if (entry.value.wallpaper.isSet)
              'wallpaperDim': entry.value.wallpaper.dim,
            if (entry.value.hideAvatar) 'hideAvatar': true,
            if (entry.value.hideLastSeen) 'hideLastSeen': true,
            if (entry.value.hideReadReceipts) 'hideReadReceipts': true,
            if (entry.value.acceptCalls != null)
              'acceptCalls': entry.value.acceptCalls,
            if (entry.value.preferRelay) 'preferRelay': true,
            if (entry.value.muted) 'muted': true,
            if (entry.value.mutedUntil != null)
              'mutedUntilMs': entry.value.mutedUntil!.millisecondsSinceEpoch,
          },
      });
    } catch (e) {
      debugPrint('ConversationSettings persist failed: $e');
    }
  }
}

final conversationSettingsControllerProvider = NotifierProvider<
    ConversationSettingsController, Map<String, ConversationSettings>>(
  ConversationSettingsController.new,
);
