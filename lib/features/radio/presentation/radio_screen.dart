import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ble/background_mode_controller.dart';
import '../../../core/identity/anon_name.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/context_popup.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/more_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../chat/presentation/widgets/chat_input.dart'
    show MessageIslandGlass;
import '../../peers/data/contact_aliases_controller.dart';
import '../../peers/data/known_peers_controller.dart';
import '../data/radio_controller.dart';
import 'radio_join_sheet.dart';

/// The walkie-talkie: the groups you are in, the one button, and who has the
/// channel.
///
/// [contactId] is set when it was opened from a 1:1 chat's header: that
/// contact is tuned in once the screen is up, so the first thing the button
/// does is talk to the person whose chat you came from.
///
/// A sub-screen on the root navigator, like Relays and Customize - not a tab -
/// so it has the plain app bar those have rather than the tab header.
class RadioScreen extends ConsumerStatefulWidget {
  const RadioScreen({super.key, this.contactId});

  final String? contactId;

  @override
  ConsumerState<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends ConsumerState<RadioScreen> {
  /// How long a refused press keeps its explanation on the line above the
  /// button. The controller keeps `blockedReason` until the next press that
  /// works, which on a screen left open would be a stale "a call is in
  /// progress" long after the call; the words are a flash, not a status.
  static const Duration _reasonFor = Duration(seconds: 3);

  /// Taken up front so [dispose] can let go of the button without reading
  /// `ref`, which an element being torn down no longer allows.
  late final RadioController _radio =
      ref.read(radioControllerProvider.notifier);

  RadioBlockedReason? _reason;
  Timer? _reasonTimer;

  /// Whether a finger is down on the button, so leaving the screen under it
  /// (the system back gesture) lets the channel go.
  bool _holding = false;

  @override
  void initState() {
    super.initState();
    // While this screen is open the radio may dial for links; the scanner
    // also asks whether the app is in front (`RadioReach.wanted`).
    _radio.screenShown(true);
    final contact = widget.contactId;
    if (contact != null) {
      // After the first frame: tuning in writes the controller's state, which
      // a provider may not take from inside a build.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _radio.select(RadioContact(contact));
      });
    }
  }

  @override
  void dispose() {
    _reasonTimer?.cancel();
    // No provider state behind it, so no microtask: it may be told here.
    _radio.screenShown(false);
    if (_holding) {
      // A microtask for the reason in initState: releasing writes state.
      final radio = _radio;
      scheduleMicrotask(() => unawaited(radio.releaseToTalk()));
    }
    super.dispose();
  }

  void _showReason(RadioBlockedReason reason) {
    if (!mounted) return;
    _reasonTimer?.cancel();
    setState(() => _reason = reason);
    _reasonTimer = Timer(_reasonFor, () {
      if (mounted) setState(() => _reason = null);
    });
  }

  void _hideReason() {
    _reasonTimer?.cancel();
    _reasonTimer = null;
    if (_reason != null) setState(() => _reason = null);
  }

  Future<void> _press() async {
    _holding = true;
    final ok = await _radio.pressToTalk();
    if (!mounted) return;
    if (ok) {
      _hideReason();
      return;
    }
    // From the press itself rather than the listener below: a second refusal
    // for the same reason leaves the state's reason unchanged, and the words
    // should still come back.
    final reason = ref.read(radioControllerProvider).blockedReason;
    if (reason != null) _showReason(reason);
  }

  void _release() {
    _holding = false;
    unawaited(_radio.releaseToTalk());
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = ref.watch(radioControllerProvider);
    // A reason the controller raised on its own - the press that ran out its
    // minute - arrives with no press to report it.
    ref.listen<RadioBlockedReason?>(
      radioControllerProvider.select((s) => s.blockedReason),
      (prev, next) {
        if (next != null && next != prev) {
          _showReason(next);
        } else if (next == null) {
          _hideReason();
        }
      },
    );
    final active = state.active;
    WidgetsBinding.instance.addPostFrameCallback((_) => _measurePanel());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.textOnGlass),
        title: Text(
          t.radioTitle,
          style: AppTypography.heading(
            size: AppMenu.title,
            color: AppColors.textOnGlass,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        // The panel floats over the list, as the composer floats over a
        // conversation, so what scrolls under it is what its glass is made
        // of ("задний фон должен быть как остров", 2026-11-11). Under a
        // Column the list ended above it and the island stood on bare
        // background, a dark slab rather than glass. The list's bottom padding
        // is the panel's measured height, so the last row can still be
        // scrolled clear of it.
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 16 + _panelHeight),
                children: [
                  if (active is RadioContact) ...[
                    _Label(text: t.radioDirectLabel),
                    _ContactTile(
                      contact: active,
                      onTap: () => _radio.select(null),
                    ),
                    const SizedBox(height: 14),
                  ],
                  _Label(text: t.radioGroupsLabel),
                  if (state.groups.isEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                      child: Text(
                        t.radioNoGroups,
                        style: TextStyle(
                          color: AppColors.textOnGlassDim,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  for (final group in state.groups)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _GroupTile(
                        group: group,
                        selected: group == active,
                        // The tuned one again is "switch off": the only other
                        // way out is the button in the talk panel, and a list
                        // of radios where tapping the lit one does nothing
                        // reads as stuck.
                        onTap: () =>
                            _radio.select(group == active ? null : group),
                        onLeave: () =>
                            unawaited(_radio.leaveGroup(group.tagHex)),
                      ),
                    ),
                  const SizedBox(height: 2),
                  GlassCard(
                    key: const ValueKey('radio-add'),
                    onTap: () => unawaited(showRadioJoinSheet(context)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 20,
                          color: AppColors.brandPrimary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          t.radioAddGroup,
                          style: TextStyle(
                            color: AppColors.textOnGlass,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SwitchTile(
                    tileKey: const ValueKey('radio-silent-tile'),
                    title: t.radioSilentTitle,
                    hint: t.radioSilentHint,
                    value: state.playInSilentMode,
                    onChanged: (v) => unawaited(_radio.setPlayInSilentMode(v)),
                  ),
                  const SizedBox(height: 8),
                  _SwitchTile(
                    tileKey: const ValueKey('radio-personal-tile'),
                    title: t.radioPersonalCallsTitle,
                    hint: t.radioPersonalCallsHint,
                    value: state.personalCalls,
                    onChanged: (v) => unawaited(_radio.setPersonalCalls(v)),
                  ),
                  const _BackgroundHint(),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: KeyedSubtree(
                key: _panelKey,
                child: _TalkPanel(
                  state: state,
                  reason: _reason,
                  onOff: () => _radio.select(null),
                  onPress: () => unawaited(_press()),
                  onRelease: _release,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey _panelKey = GlobalKey();

  /// The talk panel's height, read after layout; the list pads by it.
  double _panelHeight = 0;

  void _measurePanel() {
    if (!mounted) return;
    final box = _panelKey.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final height = box.size.height;
    if ((height - _panelHeight).abs() > 0.5) {
      setState(() => _panelHeight = height);
    }
  }
}

/// The name a person goes by here: what you called them, else what they call
/// themselves - the same resolution a chat header does - and for somebody this
/// phone has no record of (a stranger in a group) the first eight characters
/// of the id they signed with, which is short enough to read out and still
/// different from the next person's.
String _peerLabel(WidgetRef ref, String id) {
  final known = ref.watch(knownPeersControllerProvider.select((r) => r[id]));
  if (known == null) return id.length > 8 ? id.substring(0, 8) : id;
  final alias =
      ref.watch(contactAliasesControllerProvider.select((a) => a[id]));
  return contactDisplayName(
    alias: alias,
    rawBroadcastName: known.displayName,
    pubkeyHex: known.pubkeyHex,
  );
}

class _Label extends StatelessWidget {
  const _Label({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: AppColors.textOnGlassDim,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
      );
}

/// A circle with a glyph in it, the leading mark of a row.
class _Mark extends StatelessWidget {
  const _Mark({required this.icon, required this.selected});

  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final tone = selected ? AppColors.brandPrimary : AppColors.textOnGlassDim;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tone.withValues(alpha: 0.16),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Icon(icon, size: 20, color: tone),
    );
  }
}

class _GroupTile extends StatelessWidget {
  const _GroupTile({
    required this.group,
    required this.selected,
    required this.onTap,
    required this.onLeave,
  });

  final RadioRoom group;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(14, 8, 4, 8),
      child: Row(
        children: [
          _Mark(icon: Icons.groups_rounded, selected: selected),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    group.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textOnGlass,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (group.hasPassword) ...[
                  const SizedBox(width: 6),
                  Icon(
                    Icons.lock_rounded,
                    size: 13,
                    color: AppColors.textOnGlassDim,
                  ),
                ],
              ],
            ),
          ),
          if (selected)
            Icon(
              Icons.check_circle_rounded,
              size: 20,
              color: AppColors.brandPrimary,
            ),
          Builder(
            builder: (buttonContext) => MoreButton(
              // A row of a list, not a header: the card is its backing.
              disc: false,
              tooltip: t.chatsMenuTooltip,
              onPressed: () async {
                // The button's own rect, so the menu grows from under it.
                final box = buttonContext.findRenderObject() as RenderBox?;
                if (box == null) return;
                final choice = await showAnimatedMenu<String>(
                  context: buttonContext,
                  anchor: box.localToGlobal(Offset.zero) & box.size,
                  items: [
                    AnimatedMenuItem(
                      value: 'leave',
                      icon: Icons.logout_rounded,
                      label: t.radioLeave,
                      tone: AppColors.danger,
                    ),
                  ],
                );
                if (choice == 'leave') onLeave();
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// The person a chat's radio button tuned to. Not removable - there is nothing
/// joined - so no menu; tapping it switches the radio off.
class _ContactTile extends ConsumerWidget {
  const _ContactTile({required this.contact, required this.onTap});

  final RadioContact contact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = _peerLabel(ref, contact.canonicalId);
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          const _Mark(icon: Icons.person_rounded, selected: true),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textOnGlass,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            Icons.check_circle_rounded,
            size: 20,
            color: AppColors.brandPrimary,
          ),
        ],
      ),
    );
  }
}

/// A setting of the radio's own: a title, one line saying what it does, and
/// the switch. The whole card toggles it, not only the switch.
class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.tileKey,
    required this.title,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  final Key tileKey;
  final String title;
  final String hint;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      key: tileKey,
      onTap: () => onChanged(!value),
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textOnGlass,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hint,
                  style: TextStyle(
                    color: AppColors.textOnGlassDim,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            activeThumbColor: AppColors.brandPrimary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// One line under the settings while the mesh's background mode is off
/// (Ruling 29): without its foreground service Android kills the process
/// once the screen goes dark, and a tuned radio then hears nobody. Android
/// only - on iOS the screen-off radio is a different story (PushToTalk), and
/// this sentence would promise something background mode does not do there.
class _BackgroundHint extends ConsumerWidget {
  const _BackgroundHint();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return const SizedBox.shrink();
    }
    if (ref.watch(backgroundModeProvider)) return const SizedBox.shrink();
    return Padding(
      key: const ValueKey('radio-background-hint'),
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 15,
            color: AppColors.textOnGlassDim,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context).radioBackgroundHint,
              style: TextStyle(
                color: AppColors.textOnGlassDim,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Who has the channel, and the button. Fixed at the bottom, and every line in
/// it has a fixed height: a line that appeared and moved the button would move
/// it out from under the finger that is holding it.
class _TalkPanel extends StatelessWidget {
  const _TalkPanel({
    required this.state,
    required this.reason,
    required this.onOff,
    required this.onPress,
    required this.onRelease,
  });

  final RadioState state;
  final RadioBlockedReason? reason;

  /// Un-tunes the radio. Offered only while something is tuned.
  final VoidCallback onOff;
  final VoidCallback onPress;
  final VoidCallback onRelease;

  @override
  Widget build(BuildContext context) {
    final floor = state.floor;
    final active = state.active;
    return Padding(
      // 12 at the sides, the margin of the composer and the header capsule.
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      // On its glass pane again. It was taken off on 2026-11-09 ("просто
      // сделай кнопки", build 1191) and asked back on 2026-11-10 with a
      // screenshot of the pane and the plain round button as "как должно
      // быть".
      //
      // And as an island, not a card (2026-11-11, "надо сделать в формате как
      // главный бар в чате, островки профиля и смс"): the same smoked glass,
      // radius and side margin as the chat's header, pinned bar and composer,
      // so the pane you hold to talk reads as one more of that family rather
      // than as a card from a list.
      child: MessageIslandGlass(
        borderRadius: 28,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The off switch sits beside the title, with a blank of its own
            // width on the other side so the title stays centred. 40 high:
            // an icon button's target, and the row never changes height
            // whether or not the switch is there.
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    child: Center(
                      child: switch (active) {
                        null => Text(
                            AppLocalizations.of(context).radioPickChannel,
                            style: TextStyle(
                              color: AppColors.textOnGlassDim,
                              fontSize: 15,
                            ),
                          ),
                        RadioRoom(:final name) => _ChannelTitle(name),
                        RadioContact() => Consumer(
                            builder: (context, ref, _) => _ChannelTitle(
                              _peerLabel(ref, active.canonicalId),
                            ),
                          ),
                      },
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: active == null
                        ? null
                        : IconButton(
                            key: const ValueKey('radio-off'),
                            tooltip: AppLocalizations.of(context).radioTurnOff,
                            onPressed: onOff,
                            padding: EdgeInsets.zero,
                            iconSize: 22,
                            icon: Icon(
                              Icons.power_settings_new_rounded,
                              color: AppColors.textOnGlassDim,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
              child: Center(
                child: _StatusLine(
                  floor: floor,
                  speakerBusy: state.speakerBusy,
                  reason: reason,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _TalkButton(
              state: state,
              onPress: onPress,
              onRelease: onRelease,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChannelTitle extends StatelessWidget {
  const _ChannelTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.heading(size: 16, color: AppColors.textOnGlass),
      );
}

/// «Говорить: <ім'я>» while somebody else has the channel, the reason a press
/// was refused for a moment after it, and nothing the rest of the time.
class _StatusLine extends ConsumerWidget {
  const _StatusLine({
    required this.floor,
    required this.speakerBusy,
    required this.reason,
  });

  final FloorState floor;
  final bool speakerBusy;
  final RadioBlockedReason? reason;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final f = floor;
    // "Busy" while somebody is heard says what the speaker line and the
    // button already say, better; the reason is for the refusals nothing else
    // explains.
    final heard = f is Listening || speakerBusy;
    final shownReason =
        reason == RadioBlockedReason.busy && heard ? null : reason;
    if (shownReason != null) {
      return Text(
        _reasonText(t, shownReason),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.warning,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (f is Listening) {
      return Text(
        t.radioSpeaker(_peerLabel(ref, f.senderId)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.brandPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  static String _reasonText(AppLocalizations t, RadioBlockedReason reason) =>
      switch (reason) {
        RadioBlockedReason.tooLong => t.radioBlockedTooLong,
        RadioBlockedReason.busy => t.radioChannelBusy,
        RadioBlockedReason.call => t.radioBlockedCall,
        RadioBlockedReason.microphone => t.radioBlockedMicrophone,
        RadioBlockedReason.unavailable => t.radioBlockedUnavailable,
        RadioBlockedReason.noChannel => t.radioBlockedNoChannel,
      };
}

/// The big round button.
///
/// A [Listener], not a long-press: a long press waits about half a second
/// before it says "started", and the first half second of a sentence is the
/// part that would be lost. The pointer going down starts the transmission;
/// going up or being cancelled (the system took the touch, a scroll won it)
/// ends it. Only the first finger counts - a second one on the button must
/// not end the first one's turn when it lifts.
class _TalkButton extends StatefulWidget {
  const _TalkButton({
    required this.state,
    required this.onPress,
    required this.onRelease,
  });

  final RadioState state;
  final VoidCallback onPress;
  final VoidCallback onRelease;

  @override
  State<_TalkButton> createState() => _TalkButtonState();
}

class _TalkButtonState extends State<_TalkButton>
    with SingleTickerProviderStateMixin {
  static const double _size = 148;

  /// The ring's period. Slow enough to read as breathing, not as an alert.
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  int? _pointer;

  bool get _talking => widget.state.floor is Talking;

  /// Somebody else holds the channel - or has just let go and the end of
  /// what they said is still playing, which a press would talk over.
  bool get _heard =>
      widget.state.floor is Listening || widget.state.speakerBusy;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncPulse();
  }

  @override
  void didUpdateWidget(_TalkButton old) {
    super.didUpdateWidget(old);
    _syncPulse();
  }

  /// The ring moves only while somebody is talking - me or the person being
  /// heard - and is parked the moment the channel goes quiet. A ticker left
  /// running on a screen that sits open is a frame scheduled every vsync for
  /// nothing; this one lives for the length of a sentence.
  void _syncPulse() {
    final wanted =
        (_talking || _heard) && !MediaQuery.disableAnimationsOf(context);
    if (wanted && !_pulse.isAnimating) {
      unawaited(_pulse.repeat());
    } else if (!wanted && _pulse.isAnimating) {
      _pulse.stop();
      _pulse.value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _down(PointerDownEvent e) {
    // Nothing tuned (the radio is off, or was never on): nothing to talk to.
    // The panel's title says to pick something; a press here would only be
    // refused with the same sentence.
    if (widget.state.active == null) return;
    if (_pointer != null) return;
    _pointer = e.pointer;
    widget.onPress();
  }

  void _up(PointerEvent e) {
    if (e.pointer != _pointer) return;
    _pointer = null;
    widget.onRelease();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tuned = widget.state.active != null;
    final label = _talking
        ? t.radioTalking
        : _heard
            ? t.radioChannelBusy
            : t.radioPushToTalk;
    // Dim when pressing would be refused anyway. Busy stays live, so the press
    // says why instead of doing nothing; with nothing tuned it is dead (see
    // [_down]).
    final dim = !tuned || _heard;
    final ink = dim ? AppColors.textOnGlassDim : AppColors.textOnGlass;
    // One round of glass with the microphone and the words inside it — the
    // button as it was before the eye (2026-10-31, "как глаз", three rings and
    // the label underneath), restored on 2026-11-10 from a screenshot of this
    // one as "как должно быть". Lit green while talking, faded when a press
    // would be refused. No glow while talking, unlike the original: the glows
    // left the app in c32c48a9, and the fill already says it.
    final fill = _talking
        ? AppColors.brandPrimary.withValues(alpha: 0.34)
        : AppColors.glass(dim ? 0.08 : 0.18);
    final edge = _talking
        ? AppColors.brandPrimary
        : dim
            ? AppColors.glass(0.18)
            : AppColors.brandPrimary.withValues(alpha: 0.55);

    return SizedBox(
      width: _size + 44,
      height: _size + 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_talking || _heard)
            IgnorePointer(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, __) => Transform.scale(
                    scale: 1 + 0.3 * _pulse.value,
                    child: Container(
                      width: _size,
                      height: _size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.brandPrimary.withValues(
                            alpha: 0.6 * (1 - _pulse.value),
                          ),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Semantics(
            container: true,
            button: true,
            enabled: tuned,
            // Always the invitation, not the live label: a reader that said
            // "Говори…" mid-press would be describing the finger, not the
            // control.
            label: t.radioPushToTalk,
            excludeSemantics: true,
            child: Listener(
              key: const ValueKey('radio-talk-button'),
              behavior: HitTestBehavior.opaque,
              onPointerDown: _down,
              onPointerUp: _up,
              onPointerCancel: _up,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeOutCubic,
                width: _size,
                height: _size,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: fill,
                  border: Border.all(color: edge, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic_rounded, size: 34, color: ink),
                    const SizedBox(height: 6),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
