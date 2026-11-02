import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../l10n/app_localizations.dart';
import '../data/area_controller.dart';
import '../data/area_settings.dart';
import '../domain/area_level.dart';
import '../domain/geohash.dart';
import 'area_common.dart';

/// A long press on the map: "Read here" for the city or the region under the
/// finger. Reading only — nothing leaves the phone for that place but the
/// subscription, which tells the relay which place is being read (said in
/// the sheet and in the privacy policy).
Future<void> showAreaReadHereSheet(
  BuildContext context,
  WidgetRef ref, {
  required double latitude,
  required double longitude,
}) async {
  final settings = ref.read(areaSettingsProvider);
  if (!settings.enabled) return;
  // The point becomes cells here and nowhere finer than a city.
  final city = Geohash.encode(latitude, longitude, AreaLevel.city.precision);
  final region = city.substring(0, AreaLevel.region.precision);
  await showGlassSheet<void>(
    context: context,
    builder: (sheet) => _ReadHere(city: city, region: region),
  );
}

class _ReadHere extends ConsumerWidget {
  const _ReadHere({required this.city, required this.region});

  final String city;
  final String region;

  Future<void> _open(BuildContext context, WidgetRef ref, String cell) async {
    if (!await ensureAreaConsent(context, ref)) return;
    if (!context.mounted) return;
    final place = ref.read(areaControllerProvider).place;
    Navigator.of(context).pop();
    // One's own city or region opens its own chat, where writing is allowed.
    final route = cell == place?.city
        ? '/area?level=city'
        : cell == place?.region
            ? '/area?level=region'
            : '/area?cell=$cell';
    unawaited(context.push(route));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    Widget row(String cell, AreaLevel level) => ListTile(
          key: ValueKey('area-read-${level.name}'),
          leading: Icon(
            level == AreaLevel.city
                ? Icons.location_city_rounded
                : Icons.terrain_rounded,
            color: AppColors.brandPrimary,
          ),
          title: AreaPlaceName(
            cell: cell,
            style: TextStyle(color: AppColors.textOnGlass),
          ),
          subtitle: Text(
            areaLevelLabel(t, level),
            style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
          ),
          trailing: Text(
            t.areaReadHere,
            style: TextStyle(color: AppColors.brandPrimary),
          ),
          onTap: () => unawaited(_open(context, ref, cell)),
        );
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          row(city, AreaLevel.city),
          row(region, AreaLevel.region),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            child: Text(
              t.areaReadHereHint,
              style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
