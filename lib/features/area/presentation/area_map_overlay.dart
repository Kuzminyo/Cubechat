import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;

import '../../../core/theme/colors.dart';
import '../domain/area_room.dart';
import '../domain/geohash.dart';

/// Notes on the friends map: a cell's outline with the number of notes in it
/// (spec, «Вход в интерфейсе»). Notes without a district hang on the city's
/// outline while the map is out at city scale; notes pinned to a district on
/// that district's outline once the map is closer.
///
/// Only what the area chat already holds in memory — this asks the relay for
/// nothing, so the map tab never opens the area socket by itself.
class AreaMapOverlay {
  AreaMapOverlay({required this.onIconsChanged});

  /// Called when a count's bitmap finishes drawing, so the map can rebuild.
  final VoidCallback onIconsChanged;

  /// Closer than this, districts; farther, cities.
  static const double districtZoom = 11;

  final Map<int, gm.BitmapDescriptor> _icons = {};
  final Set<int> _drawing = {};

  /// Cell → how many notes, for what this zoom shows.
  static Map<String, int> countsAt(List<AreaNote> notes, double zoom) {
    final out = <String, int>{};
    for (final n in notes) {
      final cell = zoom >= districtZoom ? n.cell : (n.cell == null ? n.g : null);
      if (cell == null) continue;
      out[cell] = (out[cell] ?? 0) + 1;
    }
    return out;
  }

  Set<gm.Polygon> polygons(
    List<AreaNote> notes,
    double zoom,
    void Function(String cell) onTap,
  ) =>
      {
        for (final MapEntry(key: cell, value: _) in countsAt(notes, zoom).entries)
          gm.Polygon(
            polygonId: gm.PolygonId('area-$cell'),
            points: _corners(cell),
            strokeColor: AppColors.brandSecondary,
            strokeWidth: 2,
            fillColor: AppColors.brandPrimary.withValues(alpha: 0.08),
            consumeTapEvents: true,
            onTap: () => onTap(cell),
          ),
      };

  Set<gm.Marker> markers(
    List<AreaNote> notes,
    double zoom,
    void Function(String cell) onTap,
  ) {
    final out = <gm.Marker>{};
    for (final MapEntry(key: cell, value: count) in countsAt(notes, zoom).entries) {
      final icon = _icon(count);
      if (icon == null) continue;
      final (lat, lon) = Geohash.bounds(cell).center;
      out.add(
        gm.Marker(
          markerId: gm.MarkerId('area-$cell'),
          position: gm.LatLng(lat, lon),
          icon: icon,
          anchor: const Offset(0.5, 0.5),
          zIndexInt: -1,
          onTap: () => onTap(cell),
        ),
      );
    }
    return out;
  }

  static List<gm.LatLng> _corners(String cell) {
    final b = Geohash.bounds(cell);
    return [
      gm.LatLng(b.south, b.west),
      gm.LatLng(b.south, b.east),
      gm.LatLng(b.north, b.east),
      gm.LatLng(b.north, b.west),
    ];
  }

  gm.BitmapDescriptor? _icon(int count) {
    final key = count > 99 ? 100 : count;
    final ready = _icons[key];
    if (ready != null) return ready;
    if (_drawing.add(key)) {
      unawaited(
        _draw(key).then((icon) {
          _icons[key] = icon;
          _drawing.remove(key);
          onIconsChanged();
        }),
      );
    }
    return null;
  }

  /// A round badge with the count, drawn once per number.
  Future<gm.BitmapDescriptor> _draw(int count) async {
    const size = 64.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 2 - 2,
      Paint()..color = AppColors.bgTop,
    );
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 2 - 3,
      Paint()
        ..color = AppColors.brandPrimary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );
    final painter = TextPainter(
      text: TextSpan(
        text: count >= 100 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      Offset((size - painter.width) / 2, (size - painter.height) / 2),
    );
    final image =
        await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return gm.BitmapDescriptor.bytes(
      bytes!.buffer.asUint8List(),
      width: 32,
      height: 32,
    );
  }
}
