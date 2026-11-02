import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/util/location_service.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../l10n/app_localizations.dart';
import '../data/area_controller.dart';
import '../domain/area_level.dart';
import 'area_common.dart';
import 'area_notes_sheet.dart';

/// "Nearby chat" from the map: District · City · Region, each with its name,
/// its last line and — for the person who shows themselves — "≈N here"; the
/// block below goes over Bluetooth, on the Nearby tab.
Future<void> showAreaNearbySheet(BuildContext context, WidgetRef ref) async {
  if (!await ensureAreaConsent(context, ref)) return;
  if (!context.mounted) return;
  await showGlassSheet<void>(
    context: context,
    builder: (_) => const _AreaNearbySheet(),
  );
}

class _AreaNearbySheet extends ConsumerStatefulWidget {
  const _AreaNearbySheet();

  @override
  ConsumerState<_AreaNearbySheet> createState() => _AreaNearbySheetState();
}

class _AreaNearbySheetState extends ConsumerState<_AreaNearbySheet>
    with AreaSessionHolder {
  void _open(AreaLevel level) {
    Navigator.of(context).pop();
    unawaited(context.push('/area?level=${level.name}'));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = ref.watch(areaControllerProvider);
    final area = ref.read(areaControllerProvider.notifier);
    final place = state.place;
    final notes = area.allNotes().length;

    Widget status() {
      final String? text = state.locationFailure == LocationFailure.denied
          ? t.areaLocationDenied
          : place == null
              ? (state.locating ? t.areaLocating : t.areaNoPlace)
              : !state.connected
                  ? t.areaOffline
                  : null;
      if (text == null) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12.5),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.areaNearby,
                  style: AppTypography.heading(
                    size: 19,
                    color: AppColors.textOnGlass,
                  ),
                ),
              ),
              Text(
                t.areaPublicBadge,
                style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 11.5),
              ),
            ],
          ),
          const SizedBox(height: 12),
          status(),
          for (final level in AreaLevel.values)
            _LevelRow(
              key: ValueKey('area-level-${level.name}'),
              level: level,
              place: place,
              onTap: place == null ? null : () => _open(level),
            ),
          ListTile(
            key: const ValueKey('area-notes-row'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: Icon(Icons.sticky_note_2_rounded, color: AppColors.brandPrimary),
            title: Text(t.areaNotes, style: TextStyle(color: AppColors.textOnGlass)),
            subtitle: Text(
              t.areaNotesCount(notes),
              style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
            ),
            onTap: place == null
                ? null
                : () => unawaited(
                      showAreaNotesSheet(
                        context,
                        cell: place.city,
                      ),
                    ),
          ),
          Divider(color: AppColors.glassBorder, height: 18),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: Icon(Icons.bluetooth_rounded, color: AppColors.textOnGlassDim),
            title: Text(
              t.areaBlockViaBluetooth,
              style: TextStyle(color: AppColors.textOnGlassDim),
            ),
            trailing: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/peers');
              },
              child: Text(t.areaOpenNearbyTab),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelRow extends ConsumerWidget {
  const _LevelRow({
    super.key,
    required this.level,
    required this.place,
    required this.onTap,
  });

  final AreaLevel level;
  final AreaPlace? place;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    ref.watch(areaControllerProvider.select((s) => s.revision));
    final area = ref.read(areaControllerProvider.notifier);
    final id = AreaRoomId.own(level);
    final room = area.room(id);
    final last = room.posts.reversed
        .where((p) => !area.isHidden(p))
        .firstOrNull;
    // "?" in a district: presence never goes there, so nobody is counted.
    final count = level.coarse
        ? areaCountLabel(t, area.presentCount(id))
        : '?';
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      onTap: onTap,
      leading: Icon(
        switch (level) {
          AreaLevel.district => Icons.holiday_village_rounded,
          AreaLevel.city => Icons.location_city_rounded,
          AreaLevel.region => Icons.terrain_rounded,
        },
        color: AppColors.brandPrimary,
      ),
      title: Row(
        children: [
          Text(
            '${areaLevelLabel(t, level)} · ',
            style: TextStyle(
              color: AppColors.textOnGlassDim,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: AreaPlaceName(
              cell: place?.cellOf(level),
              style: TextStyle(
                color: AppColors.textOnGlass,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (count != null)
            Text(
              count,
              style: TextStyle(color: AppColors.brandSecondary, fontSize: 12),
            ),
        ],
      ),
      subtitle: last == null
          ? null
          : Text(
              '${areaDisplayName(t, last.pubkey, last.name)}: ${last.text}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12.5),
            ),
    );
  }
}
