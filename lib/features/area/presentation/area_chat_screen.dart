import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/util/location_service.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/floating_glass.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../core/widgets/glass_toast.dart';
import '../../../l10n/app_localizations.dart';
import '../../moderation/data/filter_settings.dart';
import '../../moderation/domain/profanity.dart';
import '../../moderation/domain/report.dart';
import '../data/area_controller.dart';
import '../data/area_settings.dart';
import '../domain/area_event.dart';
import '../domain/area_level.dart';
import '../domain/area_room.dart';
import 'area_common.dart';
import 'area_notes_sheet.dart';

/// One chat of the area: the own district, city or region — or, read only, a
/// city or region picked on the map.
///
/// No notifications of any kind come from here, not even for a reply to
/// one's own message (spec, «Вход в интерфейсе»).
class AreaChatScreen extends ConsumerStatefulWidget {
  const AreaChatScreen.own(AreaLevel this.level, {super.key})
      : foreignCell = null;

  const AreaChatScreen.foreign(String this.foreignCell, {super.key})
      : level = null;

  final AreaLevel? level;
  final String? foreignCell;

  AreaRoomId get roomId => foreignCell != null
      ? AreaRoomId.foreign(foreignCell!)
      : AreaRoomId.own(level!);

  @override
  ConsumerState<AreaChatScreen> createState() => _AreaChatScreenState();
}

class _AreaChatScreenState extends ConsumerState<AreaChatScreen>
    with AreaSessionHolder {
  late final AreaController _controller;
  final _text = TextEditingController();
  final Set<String> _unfolded = {};
  AreaPost? _replyTo;
  bool _sending = false;

  AreaRoomId get _id => widget.roomId;

  bool _opened = false;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(areaControllerProvider.notifier);
  }

  @override
  void onAreaSessionStart() {
    final foreign = widget.foreignCell;
    if (foreign != null) _controller.openForeign(foreign);
    _controller.setPresenceRoom(_id);
    _opened = true;
  }

  @override
  void dispose() {
    if (_opened) {
      _controller.setPresenceRoom(null);
      // After the unmount: closing changes the controller's state, which
      // this element still listens to while it is being taken down.
      final foreign = widget.foreignCell;
      if (foreign != null) {
        final controller = _controller;
        scheduleMicrotask(() => controller.closeForeign(only: foreign));
      }
    }
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_sending || _text.text.trim().isEmpty) return;
    final t = AppLocalizations.of(context);
    setState(() => _sending = true);
    final result = await _controller.send(
      _id,
      _text.text,
      replyTo: _replyTo?.id,
    );
    if (!mounted) return;
    setState(() => _sending = false);
    switch (result) {
      case AreaSendResult.sent:
        _text.clear();
        setState(() => _replyTo = null);
      case AreaSendResult.tooFast:
        showGlassToast(context, t.areaWaitALittle);
      case AreaSendResult.offline || AreaSendResult.noPlace:
        showGlassToast(context, t.areaOffline, tone: ToastTone.danger);
      case AreaSendResult.readOnly:
        showGlassToast(context, t.areaReadOnly);
    }
  }

  Future<void> _setName() async {
    final t = AppLocalizations.of(context);
    final level = _id.level;
    if (level == null) return;
    final field = TextEditingController(
      text: _controller.identity(level)?.customName ?? '',
    );
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.areaSetName),
        content: TextField(
          controller: field,
          autofocus: true,
          maxLength: kAreaMaxNameChars,
          decoration: InputDecoration(helperText: t.areaNameHint),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(field.text),
            child: Text(t.areaSetName),
          ),
        ],
      ),
    );
    field.dispose();
    if (name == null) return;
    final clash = await _controller.setCustomName(level, name);
    if (clash && mounted) {
      showGlassToast(context, t.areaNameSameWarning, tone: ToastTone.danger);
    }
  }

  Future<void> _actions(AreaPost post) async {
    final t = AppLocalizations.of(context);
    final link = RegExp(r'https?://\S+').firstMatch(post.text)?.group(0);
    final choice = await showGlassSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_id.readOnly)
            ListTile(
              leading: const Icon(Icons.reply_rounded),
              title: Text(t.areaReply),
              onTap: () => Navigator.of(context).pop('reply'),
            ),
          if (link != null)
            ListTile(
              leading: const Icon(Icons.link_rounded),
              title: Text(t.areaOpenLink),
              onTap: () => Navigator.of(context).pop('link'),
            ),
          if (!post.mine) ...[
            ListTile(
              leading: const Icon(Icons.visibility_off_rounded),
              title: Text(t.areaHide),
              onTap: () => Navigator.of(context).pop('hide'),
            ),
            ListTile(
              leading: const Icon(Icons.block_rounded),
              title: Text(t.areaBlock),
              onTap: () => Navigator.of(context).pop('block'),
            ),
            ListTile(
              leading: const Icon(Icons.flag_rounded, color: AppColors.danger),
              title: Text(
                t.areaReport,
                style: const TextStyle(color: AppColors.danger),
              ),
              onTap: () => Navigator.of(context).pop('report'),
            ),
          ],
        ],
      ),
    );
    if (!mounted) return;
    switch (choice) {
      case 'reply':
        setState(() => _replyTo = post);
      case 'link':
        // Links are text until the person says otherwise: a stranger's URL is
        // never one tap from opening.
        if (link == null) return;
        final ok = await confirmAction(
          context,
          title: t.areaOpenLinkConfirm(link),
          confirmLabel: t.areaOpen,
          destructive: false,
        );
        final uri = Uri.tryParse(link);
        if (ok && uri != null) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      case 'hide':
        _controller.hidePost(post.id);
        showGlassToast(context, t.areaHidden);
      case 'block':
        await _controller.blockAuthor(post.pubkey);
        if (mounted) showGlassToast(context, t.areaBlocked);
      case 'report':
        await _report(post);
    }
  }

  Future<void> _report(AreaPost post) async {
    final g = _controller.geohashOf(_id);
    if (g == null) return;
    final reason = await showGlassSheet<ReportReason>(
      context: context,
      builder: (_) => const _ReasonSheet(),
    );
    if (reason == null || !mounted) return;
    final t = AppLocalizations.of(context);
    final sent = await _controller.report(post, g, reason: reason);
    if (!mounted) return;
    showGlassToast(
      context,
      sent ? '${t.reportSent} ${t.areaBlocked}' : t.reportFailed,
      icon: Icons.flag_rounded,
      tone: sent ? ToastTone.success : ToastTone.danger,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = ref.watch(areaControllerProvider);
    final settings = ref.watch(areaSettingsProvider);
    final filter = ref.watch(filterEnabledProvider);
    final place = state.place;
    final cell = areaCellOf(_id, place);
    final room = _controller.room(_id);
    final posts = [
      for (final p in room.posts)
        if (!_controller.isHidden(p) &&
            // Everybody here is a stranger, so the filter takes all of it.
            !(filter && !p.mine && containsProfanity(p.text)))
          p,
    ];
    final level = _id.effectiveLevel;
    final showsPresence = !_id.readOnly && level.coarse;
    final identity = _id.level == null ? null : _controller.identity(_id.level!);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
              child: FloatingGlass(
                borderRadius: 22,
                padding: const EdgeInsets.fromLTRB(4, 6, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BackButton(color: AppColors.textOnGlass),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AreaPlaceName(
                                cell: cell,
                                style: AppTypography.heading(
                                  size: 17,
                                  color: AppColors.textOnGlass,
                                ),
                              ),
                              Text(
                                [
                                  areaLevelLabel(t, level),
                                  if (showsPresence)
                                    areaCountLabel(
                                          t,
                                          _controller.presentCount(_id),
                                        ) ??
                                        '',
                                  if (level == AreaLevel.district) '?',
                                ].where((s) => s.isNotEmpty).join(' · '),
                                style: TextStyle(
                                  color: AppColors.textOnGlassDim,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: t.areaNotes,
                          onPressed: cell == null
                              ? null
                              : () => unawaited(
                                    showAreaNotesSheet(
                                      context,
                                      cell: cell.length == 5
                                          ? cell.substring(0, 4)
                                          : cell,
                                    ),
                                  ),
                          icon: Icon(
                            Icons.sticky_note_2_rounded,
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ],
                    ),
                    if (identity != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => unawaited(_setName()),
                                child: Text(
                                  t.areaYouAre(
                                    areaDisplayName(
                                      t,
                                      identity.pubkey,
                                      identity.customName,
                                    ),
                                    _hoursLeft(identity.notAfter),
                                  ),
                                  style: TextStyle(
                                    color: AppColors.authorTint(identity.pubkey),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              key: const ValueKey('area-new-name'),
                              onPressed: () => unawaited(
                                _controller.renewIdentity(_id.level!),
                              ),
                              child: Text(t.areaNewName),
                            ),
                          ],
                        ),
                      ),
                    if (showsPresence)
                      SwitchListTile(
                        key: const ValueKey('area-presence'),
                        dense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        value: settings.showPresence,
                        title: Text(
                          t.areaShowPresence,
                          style: TextStyle(color: AppColors.textOnGlass),
                        ),
                        subtitle: settings.showPresence
                            ? null
                            : Text(
                                t.areaPresenceOffHint,
                                style: TextStyle(
                                  color: AppColors.textOnGlassDim,
                                  fontSize: 12,
                                ),
                              ),
                        onChanged: (on) => unawaited(
                          ref
                              .read(areaSettingsProvider.notifier)
                              .setShowPresence(on),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(child: _list(t, state, posts, room)),
            _composer(t, state),
          ],
        ),
      ),
    );
  }

  int _hoursLeft(DateTime notAfter) {
    final minutes = notAfter.difference(DateTime.now()).inMinutes;
    return minutes <= 0 ? 0 : (minutes + 59) ~/ 60;
  }

  Widget _list(
    AppLocalizations t,
    AreaState state,
    List<AreaPost> posts,
    AreaRoom room,
  ) {
    if (!_id.readOnly && state.place == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            state.locationFailure == LocationFailure.denied
                ? t.areaLocationDenied
                : state.locating
                    ? t.areaLocating
                    : t.areaNoPlace,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textOnGlassDim),
          ),
        ),
      );
    }
    if (posts.isEmpty) {
      return Center(
        child: Text(
          state.connected ? t.areaEmpty : t.areaOffline,
          style: TextStyle(color: AppColors.textOnGlassDim),
        ),
      );
    }
    // Flood folds by author: a run of one key's flood posts is one row until
    // someone asks to see it.
    final rows = <Widget>[];
    var i = 0;
    while (i < posts.length) {
      final p = posts[i];
      if (p.flood && !_unfolded.contains(p.pubkey)) {
        var j = i;
        while (j < posts.length &&
            posts[j].pubkey == p.pubkey &&
            posts[j].flood) {
          j++;
        }
        rows.add(
          TextButton(
            onPressed: () => setState(() => _unfolded.add(p.pubkey)),
            child: Text(t.areaFlood(j - i)),
          ),
        );
        i = j;
        continue;
      }
      rows.add(
        _PostBubble(
          post: p,
          quoted: p.replyTo == null ? null : room.postById(p.replyTo!),
          onLongPress: () => unawaited(_actions(p)),
        ),
      );
      i++;
    }
    return ListView(
      reverse: true,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      children: rows.reversed.toList(),
    );
  }

  Widget _composer(AppLocalizations t, AreaState state) {
    if (_id.readOnly) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
        child: Text(
          t.areaReadOnly,
          key: const ValueKey('area-read-only'),
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textOnGlassDim),
        ),
      );
    }
    final reply = _replyTo;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
      child: FloatingGlass(
        borderRadius: 22,
        padding: const EdgeInsets.fromLTRB(14, 4, 4, 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (reply != null)
              Row(
                children: [
                  Icon(Icons.reply_rounded,
                      size: 16, color: AppColors.textOnGlassDim,),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      reply.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.textOnGlassDim),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _replyTo = null),
                    icon: const Icon(Icons.close_rounded, size: 18),
                  ),
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const ValueKey('area-composer'),
                    controller: _text,
                    enabled: state.place != null,
                    maxLength: kAreaMaxTextChars,
                    minLines: 1,
                    maxLines: 4,
                    cursorColor: AppColors.brandPrimary,
                    style: TextStyle(color: AppColors.textOnGlass),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      hintText: t.areaComposerHint,
                      hintStyle: TextStyle(color: AppColors.textOnGlassFaint),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: t.areaSend,
                  onPressed: _sending ? null : () => unawaited(_send()),
                  icon: Icon(Icons.send_rounded, color: AppColors.brandPrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostBubble extends StatelessWidget {
  const _PostBubble({
    required this.post,
    required this.quoted,
    required this.onLongPress,
  });

  final AreaPost post;
  final AreaPost? quoted;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final time = DateTime.fromMillisecondsSinceEpoch(post.createdAt * 1000);
    final hh = time.hour.toString().padLeft(2, '0');
    final mm = time.minute.toString().padLeft(2, '0');
    return Align(
      alignment: post.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.8,
          ),
          margin: const EdgeInsets.symmetric(vertical: 3),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            color: post.mine
                ? AppColors.brandPrimary.withValues(alpha: 0.22)
                : AppColors.glass(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                areaDisplayName(t, post.pubkey, post.name),
                style: TextStyle(
                  color: AppColors.authorTint(post.pubkey),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (quoted != null)
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 2),
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppColors.brandSecondary, width: 2),
                    ),
                  ),
                  child: Text(
                    quoted!.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textOnGlassDim,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 2),
              // Plain text: no markup, and a link is not a link until the
              // long-press menu is asked to open it.
              Text(post.text, style: TextStyle(color: AppColors.textOnGlass)),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '$hh:$mm',
                  style: TextStyle(
                    color: AppColors.textOnGlassFaint,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReasonSheet extends StatelessWidget {
  const _ReasonSheet();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final labels = <ReportReason, String>{
      ReportReason.spam: t.reportReasonSpam,
      ReportReason.abuse: t.reportReasonAbuse,
      ReportReason.violence: t.reportReasonViolence,
      ReportReason.sexual: t.reportReasonSexual,
      ReportReason.other: t.reportReasonOther,
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
          child: Text(
            t.reportTitle,
            style: AppTypography.heading(size: 19, color: AppColors.textOnGlass),
          ),
        ),
        for (final reason in ReportReason.values)
          ListTile(
            key: ValueKey('area-report-${reason.name}'),
            title: Text(labels[reason]!),
            onTap: () => Navigator.of(context).pop(reason),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
