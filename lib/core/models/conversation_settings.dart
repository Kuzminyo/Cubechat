import 'package:flutter/foundation.dart';

// Moved from `features/chat/data/conversation_settings_controller.dart`, which
// re-exports them: the transport reads a conversation's copy restriction and
// wallpaper when it sends, and must not import a feature to do it.

/// How long a message survives in one conversation, as a plain duration.
///
/// Was a four-value enum (off / 1 / 7 / 30 days). Any fixed set is wrong for
/// somebody: the interesting choices are usually much shorter than a day, and
/// "a week" is nobody's threat model. Seconds carry every preset the enum had
/// plus whatever the user actually wants, and the presets survive only as
/// suggestions in the picker.
@immutable
class ChatAutoDelete {
  const ChatAutoDelete(this.seconds);

  /// Zero (and anything negative, which cannot be entered but can be decoded
  /// from a mangled store) means messages are kept.
  final int seconds;

  static const off = ChatAutoDelete(0);

  /// Offered in the picker, in order. Not a constraint — just the shortcuts.
  static const presets = <ChatAutoDelete>[
    off,
    ChatAutoDelete(60),
    ChatAutoDelete(60 * 60),
    ChatAutoDelete(24 * 60 * 60),
    ChatAutoDelete(7 * 24 * 60 * 60),
    ChatAutoDelete(30 * 24 * 60 * 60),
  ];

  /// Longest we accept, so a typo cannot set something indistinguishable from
  /// off while still reading as "on" in the UI.
  static const maxSeconds = 365 * 24 * 60 * 60;

  bool get isOn => seconds > 0;

  Duration? get duration => isOn ? Duration(seconds: seconds) : null;

  /// Decode a value stored before this was a duration.
  static ChatAutoDelete fromLegacyName(String? name) => switch (name) {
        'oneDay' => const ChatAutoDelete(24 * 60 * 60),
        'sevenDays' => const ChatAutoDelete(7 * 24 * 60 * 60),
        'thirtyDays' => const ChatAutoDelete(30 * 24 * 60 * 60),
        _ => off,
      };

  @override
  bool operator ==(Object other) =>
      other is ChatAutoDelete && other.seconds == seconds;

  @override
  int get hashCode => seconds.hashCode;
}

/// What one conversation is drawn on.
///
/// Purely local and purely cosmetic: nothing goes on the wire, so two people
/// in the same chat can each pick their own, exactly as they already can with
/// auto-delete.
@immutable
class ChatWallpaper {
  const ChatWallpaper({
    this.presetIndex,
    this.imagePath,
    this.dim = 0.35,
  });

  static const none = ChatWallpaper();

  /// Index into [presets]. Null when this is an image, or nothing at all.
  final int? presetIndex;

  /// A picture the user chose, already copied into app storage — the picker's
  /// own temporary file is collected out from under us otherwise.
  final String? imagePath;

  /// How much dark scrim goes over the top, 0..1. A photograph makes an
  /// unreadable backdrop for text at almost any brightness, so a wallpaper
  /// without a legibility layer is one people turn back off.
  final double dim;

  bool get isSet => presetIndex != null || imagePath != null;

  /// Bundled gradients, as pairs of colour values. Deliberately a handful:
  /// the point is a conversation that looks distinct at a glance, not a
  /// theming engine.
  static const presets = <List<int>>[
    [0xFF1B3A2F, 0xFF0B1A16],
    [0xFF2A1F3D, 0xFF120B1C],
    [0xFF1F2E4A, 0xFF0B1220],
    [0xFF3D2320, 0xFF1A0E0C],
    [0xFF23343A, 0xFF0C1518],
  ];

  ChatWallpaper copyWith({
    int? presetIndex,
    String? imagePath,
    double? dim,
    bool clearPreset = false,
    bool clearImage = false,
  }) =>
      ChatWallpaper(
        presetIndex: clearPreset ? null : (presetIndex ?? this.presetIndex),
        imagePath: clearImage ? null : (imagePath ?? this.imagePath),
        dim: dim ?? this.dim,
      );

  @override
  bool operator ==(Object other) =>
      other is ChatWallpaper &&
      other.presetIndex == presetIndex &&
      other.imagePath == imagePath &&
      other.dim == dim;

  @override
  int get hashCode => Object.hash(presetIndex, imagePath, dim);
}

@immutable
class ConversationSettings {
  const ConversationSettings({
    this.autoDelete = ChatAutoDelete.off,
    this.autoDeleteFrom,
    this.restrictCopying = false,
    this.peerRestrictsCopying = false,
    this.wallpaper = ChatWallpaper.none,
    this.hideAvatar = false,
    this.hideLastSeen = false,
    this.hideReadReceipts = false,
    this.acceptCalls,
    this.preferRelay = false,
    this.muted = false,
    this.mutedUntil,
  });

  static const initial = ConversationSettings();

  final ChatAutoDelete autoDelete;

  /// When [autoDelete] was switched on, and therefore the oldest message it is
  /// allowed to touch.
  ///
  /// Without it, turning on "delete after an hour" deleted the last year of
  /// the conversation on the spot — every message already older than an hour
  /// was past its cutoff the instant the setting existed. That is a defensible
  /// reading of the words and a terrible reading of the intent: the switch is
  /// understood as "from now on", and its most likely use is right after
  /// saying something you would rather not leave lying around, in a chat you
  /// otherwise want to keep.
  ///
  /// Set on off→on only. Changing the period while it is already on keeps the
  /// original anchor, so shortening the timer cannot suddenly reach further
  /// back than the switch itself ever did.
  final DateTime? autoDeleteFrom;

  /// What *we* asked for in this conversation.
  final bool restrictCopying;

  /// What the person on the other end asked for.
  ///
  /// Held apart from [restrictCopying] rather than folded into it so the two
  /// cannot cancel each other: turning our own switch off must not lift their
  /// request, and their turning theirs off must not lift ours. Only the side
  /// that set a flag can clear it.
  final bool peerRestrictsCopying;

  final ChatWallpaper wallpaper;

  /// Three exceptions to the global privacy switches, for one person.
  ///
  /// The switches in Privacy answer "who may see this" with *everyone or
  /// nobody*, which is the wrong shape for the ordinary case: there is usually
  /// one contact you would rather not show a photo to, or not have your times
  /// read by, while everybody else is fine. These say "not this one".
  ///
  /// None of them touches the wire. Each is a decision not to *send* something
  /// the other side has no other way of learning:
  ///
  ///  * [hideAvatar] — their build asks for our picture and this one is not
  ///    answered. They see the generated gradient, which is what everybody
  ///    sees before an avatar is set.
  ///  * [hideLastSeen] — the presence beacon minted for them carries the
  ///    `hideLastSeen` flag it already has a field for, and typing is not
  ///    announced to them. They see us without a clock beside the status.
  ///  * [hideReadReceipts] — no receipt is composed for them, so their ticks
  ///    stop at one. Their own receipts still arrive here: this withholds, it
  ///    does not retaliate.
  ///
  /// Only ever more private than the global switch, never less — see
  /// `ConversationSettingsController.hidesAvatarFrom` and its neighbours,
  /// which is where the two are combined.
  final bool hideAvatar;
  final bool hideLastSeen;
  final bool hideReadReceipts;

  /// Calls from this person, against the global switch
  /// (`PrivacySettings.acceptCalls`): true lets them ring when calls are
  /// refused, false refuses them when calls are accepted, null follows the
  /// switch. The one exception here that can go either way — "never take calls,
  /// except from these", and "take calls, except from these", are both what a
  /// phone's own settings offer.
  final bool? acceptCalls;

  /// Try the internet before the radios for this conversation.
  ///
  /// A bias, not a lock. The road is picked per message from what is actually
  /// reachable at that instant, so a preference that could not be honoured is
  /// simply not honoured — the message still goes. What this changes is the
  /// order things are tried in when more than one is available.
  ///
  /// Off by default, because Bluetooth first is the right default for an app
  /// whose point is working without the internet: it is faster in the room,
  /// costs no data, and tells a relay nothing. Somebody on a bad Bluetooth
  /// link and good wifi wants the opposite, and only they can know that.
  final bool preferRelay;

  /// Silenced: the messages arrive and are stored, nothing is announced.
  ///
  /// A second home for a setting that already has one, and deliberately. A 1:1
  /// mute lives on the person (`KnownPeer.mutedAt`) because that is what it is
  /// about — the same human across every place they turn up. A channel has no
  /// person to hang it on: nobody is muting *#news*, they are muting a room.
  /// So rooms keep it here, with the conversation, and [isMutedNow] is what
  /// every surface asks. See the notification gate, which consults both.
  ///
  /// [mutedUntil] null while [muted] is on means indefinitely — what the
  /// button in a channel's bar does. A date is what a timed mute writes, and
  /// it expires on its own without anything having to sweep it: the getter
  /// compares against the clock, so a mute that has run out is simply not one.
  final bool muted;
  final DateTime? mutedUntil;

  /// Muted *right now*, which is the only question worth asking. An expired
  /// timer is not a mute.
  bool get isMutedNow =>
      muted && (mutedUntil == null || mutedUntil!.isAfter(DateTime.now()));

  /// Whether copying, forwarding and sharing are off in this conversation —
  /// the question every message surface actually asks. Either side saying so
  /// is enough; it is a request about the conversation, not about one device.
  bool get copyingRestricted => restrictCopying || peerRestrictsCopying;

  ConversationSettings copyWith({
    ChatAutoDelete? autoDelete,
    DateTime? autoDeleteFrom,
    bool clearAutoDeleteFrom = false,
    bool? restrictCopying,
    bool? peerRestrictsCopying,
    ChatWallpaper? wallpaper,
    bool? hideAvatar,
    bool? hideLastSeen,
    bool? hideReadReceipts,
    bool? acceptCalls,
    bool clearAcceptCalls = false,
    bool? preferRelay,
    bool? muted,
    DateTime? mutedUntil,
    bool clearMutedUntil = false,
  }) =>
      ConversationSettings(
        acceptCalls: clearAcceptCalls ? null : (acceptCalls ?? this.acceptCalls),
        autoDelete: autoDelete ?? this.autoDelete,
        autoDeleteFrom:
            clearAutoDeleteFrom ? null : (autoDeleteFrom ?? this.autoDeleteFrom),
        restrictCopying: restrictCopying ?? this.restrictCopying,
        peerRestrictsCopying: peerRestrictsCopying ?? this.peerRestrictsCopying,
        wallpaper: wallpaper ?? this.wallpaper,
        hideAvatar: hideAvatar ?? this.hideAvatar,
        hideLastSeen: hideLastSeen ?? this.hideLastSeen,
        hideReadReceipts: hideReadReceipts ?? this.hideReadReceipts,
        preferRelay: preferRelay ?? this.preferRelay,
        muted: muted ?? this.muted,
        mutedUntil: clearMutedUntil ? null : (mutedUntil ?? this.mutedUntil),
      );

  /// True when there is nothing here worth storing. The hidings count: an
  /// entry that only says "not this person" is the whole of what that setting
  /// is, and dropping it as "default" would quietly un-hide them on the next
  /// launch.
  bool get isDefault =>
      !autoDelete.isOn &&
      !copyingRestricted &&
      !wallpaper.isSet &&
      !hideAvatar &&
      !hideLastSeen &&
      !hideReadReceipts &&
      acceptCalls == null &&
      !preferRelay &&
      !muted;

  @override
  bool operator ==(Object other) =>
      other is ConversationSettings &&
      other.autoDelete == autoDelete &&
      other.autoDeleteFrom == autoDeleteFrom &&
      other.restrictCopying == restrictCopying &&
      other.peerRestrictsCopying == peerRestrictsCopying &&
      other.wallpaper == wallpaper &&
      other.hideAvatar == hideAvatar &&
      other.hideLastSeen == hideLastSeen &&
      other.hideReadReceipts == hideReadReceipts &&
      other.acceptCalls == acceptCalls &&
      other.preferRelay == preferRelay &&
      other.muted == muted &&
      other.mutedUntil == mutedUntil;

  @override
  int get hashCode => Object.hash(
        autoDelete,
        autoDeleteFrom,
        restrictCopying,
        peerRestrictsCopying,
        wallpaper,
        hideAvatar,
        hideLastSeen,
        hideReadReceipts,
        acceptCalls,
        preferRelay,
        muted,
        mutedUntil,
      );
}
