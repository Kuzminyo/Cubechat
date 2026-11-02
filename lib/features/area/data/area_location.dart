import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/util/debug_log.dart';
import '../../../core/util/location_service.dart';
import '../domain/area_level.dart';

/// Which district the phone is in, asked once — or why not.
///
/// Returns the five-character cell and nothing finer: the fix is turned into
/// it by [coarsenToDistrict] inside this call and dropped (spec, rule 3).
typedef AreaDistrictReader = Future<(String?, LocationFailure?)> Function();

/// The approximate location is enough: on Android `ACCESS_COARSE_LOCATION`
/// (a ~2 km grid), on iOS reduced accuracy. Asked only while "Nearby" is on
/// screen — never in the background, and never for "Always".
///
/// If the person already gave the precise permission for the friends map the
/// fix may be precise; it is coarsened to five characters all the same.
Future<(String?, LocationFailure?)> readAreaDistrict() async {
  try {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return (null, LocationFailure.serviceOff);
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return (null, LocationFailure.denied);
    }
    // What the OS already knows is fine here: a district is five kilometres,
    // and a ten-minute-old fix from another app is in it.
    try {
      final last = await Geolocator.getLastKnownPosition();
      if (last != null &&
          DateTime.now().difference(last.timestamp) <
              const Duration(minutes: 10) &&
          last.accuracy.isFinite &&
          last.accuracy <= 3000) {
        return (coarsenToDistrict(last.latitude, last.longitude), null);
      }
    } catch (_) {}
    // Low: cell towers and Wi-Fi, no satellites held up for a five-kilometre
    // answer.
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
        timeLimit: Duration(seconds: 20),
      ),
    );
    return (coarsenToDistrict(position.latitude, position.longitude), null);
  } catch (e) {
    DebugLog.instance.log('AREA', 'no district: $e');
    return (null, LocationFailure.unavailable);
  }
}

final areaDistrictReaderProvider =
    Provider<AreaDistrictReader>((ref) => readAreaDistrict);

/// Hysteresis on a cell border: a new district is believed only when two
/// fixes in a row agree on it. Otherwise somebody standing on a border would
/// change district, key and subscription every five minutes.
class AreaCellTracker {
  String? _current;
  String? _candidate;

  String? get current => _current;

  /// The district to use after a fix that fell in [cell].
  String accept(String cell) {
    final current = _current;
    if (current == null || cell == current) {
      _current = cell;
      _candidate = null;
      return cell;
    }
    if (_candidate == cell) {
      _current = cell;
      _candidate = null;
      return cell;
    }
    _candidate = cell;
    return current;
  }

  void reset() {
    _current = null;
    _candidate = null;
  }
}
