import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

import '../domain/area_level.dart';
import '../domain/geohash.dart';

/// A cell's name — "Поділ", "Київ", "Київська область" — from the system
/// geocoder, asked about the **centre of the cell**, never about the fix.
/// bitchat sent exact coordinates to Nominatim (L5); here the geocoder learns
/// nothing finer than what the cell already says.
final areaPlaceNameProvider =
    FutureProvider.autoDispose.family<String?, (String, String)>(
  (ref, key) async {
    final (cell, localeTag) = key;
    final level = AreaLevel.ofPrecision(cell.length);
    if (level == null || !Geohash.isValid(cell)) return null;
    final (lat, lon) = Geohash.bounds(cell).center;
    try {
      final places = await Geocoding(locale: Locale(localeTag))
          .placemarkFromCoordinates(lat, lon);
      if (places.isEmpty) return null;
      final p = places.first;
      String? clean(String? v) =>
          v == null || v.trim().isEmpty ? null : v.trim();
      return switch (level) {
        AreaLevel.district => clean(p.subLocality) ??
            clean(p.locality) ??
            clean(p.subAdministrativeArea),
        AreaLevel.city => clean(p.locality) ?? clean(p.subAdministrativeArea),
        AreaLevel.region =>
          clean(p.administrativeArea) ?? clean(p.country),
      };
    } catch (_) {
      return null;
    }
  },
);
