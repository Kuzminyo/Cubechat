import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../core/widgets/glass_toast.dart';
import '../../../l10n/app_localizations.dart';
import '../data/area_controller.dart';
import '../domain/area_event.dart';
import '../domain/area_room.dart';
import 'area_cell_picker.dart';
import 'area_common.dart';

/// The notes on [cell] — a city, or a district when the map was close
/// enough to show its outline — and, in one's own city, "Leave a note".
Future<void> showAreaNotesSheet(
  BuildContext context, {
  required String cell,
}) =>
    showGlassSheet<void>(
      context: context,
      builder: (_) => _AreaNotesSheet(cell: cell),
    );

class _AreaNotesSheet extends ConsumerStatefulWidget {
  const _AreaNotesSheet({required this.cell});

  final String cell;

  @override
  ConsumerState<_AreaNotesSheet> createState() => _AreaNotesSheetState();
}

class _AreaNotesSheetState extends ConsumerState<_AreaNotesSheet>
    with AreaSessionHolder {
  final _text = TextEditingController();
  bool _composing = false;
  bool _sending = false;
  Duration _lifetime = kAreaNoteLifetimes[1];
  String? _pinned;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool _belongs(AreaNote n) =>
      widget.cell.length == 5 ? n.cell == widget.cell : n.g == widget.cell;

  Future<void> _pin() async {
    final place = ref.read(areaControllerProvider).place;
    if (place == null) return;
    final picked = await pickAreaDistrict(context, city: place.city);
    if (picked != null && mounted) setState(() => _pinned = picked);
  }

  Future<void> _leave() async {
    if (_sending || _text.text.trim().isEmpty) return;
    final t = AppLocalizations.of(context);
    setState(() => _sending = true);
    final result = await ref.read(areaControllerProvider.notifier).leaveNote(
          _text.text,
          lifetime: _lifetime,
          pinnedDistrict: _pinned,
        );
    if (!mounted) return;
    setState(() => _sending = false);
    switch (result) {
      case AreaSendResult.sent:
        _text.clear();
        setState(() {
          _composing = false;
          _pinned = null;
        });
        showGlassToast(context, t.areaNoteLeft, tone: ToastTone.success);
      case AreaSendResult.tooFast:
        showGlassToast(context, t.areaNotesLimit);
      case AreaSendResult.offline || AreaSendResult.noPlace:
        showGlassToast(context, t.areaOffline, tone: ToastTone.danger);
      case AreaSendResult.readOnly:
        showGlassToast(context, t.areaReadOnly);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = ref.watch(areaControllerProvider);
    final area = ref.read(areaControllerProvider.notifier);
    final own = state.place != null && widget.cell.startsWith(state.place!.city);
    final notes = area.allNotes().where(_belongs).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AreaPlaceName(
                  cell: widget.cell,
                  style: AppTypography.heading(
                    size: 19,
                    color: AppColors.textOnGlass,
                  ),
                ),
              ),
              Text(
                t.areaNotesCount(notes.length),
                style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (notes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                t.areaNoNotes,
                style: TextStyle(color: AppColors.textOnGlassDim),
              ),
            ),
          for (final n in notes)
            _NoteTile(
              note: n,
              own: area.isOwnNote(n.id),
              onDelete: () => unawaited(area.deleteNote(n.id)),
            ),
          if (own && !_composing)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FilledButton.icon(
                key: const ValueKey('area-leave-note'),
                onPressed: area.canLeaveNote()
                    ? () => setState(() => _composing = true)
                    : null,
                icon: const Icon(Icons.edit_note_rounded),
                label: Text(
                  area.canLeaveNote() ? t.areaLeaveNote : t.areaNotesLimit,
                ),
              ),
            ),
          if (own && _composing) ...[
            const SizedBox(height: 8),
            TextField(
              key: const ValueKey('area-note-text'),
              controller: _text,
              autofocus: true,
              maxLength: kAreaMaxTextChars,
              maxLines: 4,
              minLines: 2,
              cursorColor: AppColors.brandPrimary,
              style: TextStyle(color: AppColors.textOnGlass),
              decoration: InputDecoration(
                hintText: t.areaNoteHint,
                hintStyle: TextStyle(color: AppColors.textOnGlassFaint),
              ),
            ),
            Text(
              t.areaNoteLifetime,
              style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                for (final (life, label) in [
                  (kAreaNoteLifetimes[0], t.areaNote1h),
                  (kAreaNoteLifetimes[1], t.areaNote24h),
                  (kAreaNoteLifetimes[2], t.areaNote7d),
                ])
                  ChoiceChip(
                    label: Text(label),
                    selected: _lifetime == life,
                    onSelected: (_) => setState(() => _lifetime = life),
                  ),
              ],
            ),
            // Off until the person taps it: a note hangs on the city, and a
            // district is only ever one they chose on the map (spec, rule 2).
            SwitchListTile(
              key: const ValueKey('area-note-pin'),
              contentPadding: EdgeInsets.zero,
              value: _pinned != null,
              title: Text(
                t.areaPinToDistrict,
                style: TextStyle(color: AppColors.textOnGlass),
              ),
              subtitle: Text(
                _pinned == null ? t.areaPinHint : t.areaNotePinned,
                style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
              ),
              onChanged: (on) {
                if (on) {
                  unawaited(_pin());
                } else {
                  setState(() => _pinned = null);
                }
              },
            ),
            const SizedBox(height: 6),
            FilledButton(
              key: const ValueKey('area-note-send'),
              onPressed: _sending ? null : () => unawaited(_leave()),
              child: Text(t.areaNoteSend),
            ),
          ],
        ],
      ),
    );
  }
}

class _NoteTile extends StatelessWidget {
  const _NoteTile({
    required this.note,
    required this.own,
    required this.onDelete,
  });

  final AreaNote note;
  final bool own;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
      decoration: BoxDecoration(
        color: AppColors.glass(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.text, style: TextStyle(color: AppColors.textOnGlass)),
                if (own || note.cell != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      [
                        if (own) t.areaOwnNote,
                        if (note.cell != null) t.areaNotePinned,
                      ].join(' · '),
                      style: TextStyle(
                        color: AppColors.textOnGlassDim,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (own)
            IconButton(
              tooltip: t.areaNoteDelete,
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.danger,
              ),
            ),
        ],
      ),
    );
  }
}
