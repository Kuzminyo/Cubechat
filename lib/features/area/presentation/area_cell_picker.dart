import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/util/platform_capabilities.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/geohash.dart';

/// Whether the picker draws Google's map; tests and computers get a grid of
/// the same cells.
final areaPickerNativeMapProvider = Provider<bool>(
  (ref) => ref.watch(platformCapabilitiesProvider).googleMaps,
);

/// The 32 districts a city's cell splits into.
List<String> districtsOf(String city) => [
      for (final ch in Geohash.alphabet.split('')) '$city$ch',
    ];

/// "Pin to a district": the person puts a finger on the map inside their own
/// city, and the pin snaps to that district's cell. Null if they went back.
///
/// A choice, not a measurement: it need not be where they stand, and nothing
/// of the fix is involved (spec, rule 2).
Future<String?> pickAreaDistrict(
  BuildContext context, {
  required String city,
}) =>
    showGlassSheet<String>(
      context: context,
      // Opened from the notes sheet, usually mid-note with the keyboard up,
      // which then goes as this sheet takes focus. Lifted for it, the sheet
      // would open a keyboard short and grow back, and a texture-layer map
      // that grows leaves the new strip unpainted — the band the map tab had.
      // There is nothing to type here, so it ignores the keyboard.
      avoidKeyboard: false,
      builder: (_) => _AreaCellPicker(city: city),
    );

class _AreaCellPicker extends ConsumerStatefulWidget {
  const _AreaCellPicker({required this.city});

  final String city;

  @override
  ConsumerState<_AreaCellPicker> createState() => _AreaCellPickerState();
}

class _AreaCellPickerState extends ConsumerState<_AreaCellPicker> {
  String? _picked;

  void _tapAt(double lat, double lon) {
    final cityBounds = Geohash.bounds(widget.city);
    if (!cityBounds.contains(lat, lon)) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).areaPinOutside)),
      );
      return;
    }
    setState(() => _picked = Geohash.encode(lat, lon, 5));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final native = ref.watch(areaPickerNativeMapProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.areaPinToDistrict,
            style: AppTypography.heading(size: 19, color: AppColors.textOnGlass),
          ),
          const SizedBox(height: 4),
          Text(
            t.areaPinHint,
            style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 12),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 300,
              child: native ? _nativeMap() : _grid(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            key: const ValueKey('area-pin-done'),
            onPressed: _picked == null
                ? null
                : () => Navigator.of(context).pop(_picked),
            child: Text(t.areaPinToDistrict),
          ),
        ],
      ),
    );
  }

  Widget _nativeMap() {
    final b = Geohash.bounds(widget.city);
    final (lat, lon) = b.center;
    return gm.GoogleMap(
      initialCameraPosition: gm.CameraPosition(
        target: gm.LatLng(lat, lon),
        zoom: 9,
      ),
      minMaxZoomPreference: const gm.MinMaxZoomPreference(7, 14),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      buildingsEnabled: false,
      // The same reason as the map tab: the app's drag-anywhere back gesture
      // would otherwise take the pan from the platform view.
      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
      },
      polygons: {
        _polygon('city', widget.city, AppColors.brandSecondary, 0.0, 2),
        if (_picked != null)
          _polygon('pick', _picked!, AppColors.brandPrimary, 0.35, 2),
      },
      onTap: (p) => _tapAt(p.latitude, p.longitude),
    );
  }

  gm.Polygon _polygon(
    String id,
    String cell,
    Color color,
    double fill,
    int width,
  ) {
    final b = Geohash.bounds(cell);
    return gm.Polygon(
      polygonId: gm.PolygonId(id),
      points: [
        gm.LatLng(b.south, b.west),
        gm.LatLng(b.south, b.east),
        gm.LatLng(b.north, b.east),
        gm.LatLng(b.north, b.west),
      ],
      strokeColor: color,
      strokeWidth: width,
      fillColor: color.withValues(alpha: fill),
    );
  }

  /// The city's 32 districts laid out by their own bounds: 8 across, 4 down.
  Widget _grid() {
    final city = Geohash.bounds(widget.city);
    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth, h = box.maxHeight;
        double x(double lon) => (lon - city.west) / (city.east - city.west) * w;
        double y(double lat) =>
            (city.north - lat) / (city.north - city.south) * h;
        return Stack(
          children: [
            for (final d in districtsOf(widget.city))
              () {
                final b = Geohash.bounds(d);
                return Positioned(
                  left: x(b.west),
                  top: y(b.north),
                  width: x(b.east) - x(b.west),
                  height: y(b.south) - y(b.north),
                  child: GestureDetector(
                    key: ValueKey('area-pick-$d'),
                    onTap: () => setState(() => _picked = d),
                    child: Container(
                      decoration: BoxDecoration(
                        color: d == _picked
                            ? AppColors.brandPrimary.withValues(alpha: 0.4)
                            : AppColors.glass(0.05),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                    ),
                  ),
                );
              }(),
          ],
        );
      },
    );
  }
}
