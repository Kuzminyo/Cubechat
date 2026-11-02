/// Geohash, the cell grid the area chat speaks in.
///
/// Each character halves the cell five times, alternating longitude and
/// latitude, so a prefix is always the larger cell that holds it — which is
/// what lets the relay index a city (4) while the phone filters districts (5)
/// itself. Only what the area chat needs: encode a point, a cell's bounds and
/// centre, and its eight neighbours.
class Geohash {
  Geohash._();

  static const String alphabet = '0123456789bcdefghjkmnpqrstuvwxyz';

  static final Map<String, int> _index = {
    for (var i = 0; i < alphabet.length; i++) alphabet[i]: i,
  };

  static bool isValid(String hash, {int? length}) {
    if (hash.isEmpty || hash.length > 12) return false;
    if (length != null && hash.length != length) return false;
    for (var i = 0; i < hash.length; i++) {
      if (!_index.containsKey(hash[i])) return false;
    }
    return true;
  }

  /// The cell of [precision] characters holding ([latitude], [longitude]).
  static String encode(double latitude, double longitude, int precision) {
    if (precision < 1 || precision > 12) {
      throw ArgumentError.value(precision, 'precision', 'must be 1..12');
    }
    if (!latitude.isFinite || !longitude.isFinite) {
      throw ArgumentError('not a point: $latitude, $longitude');
    }
    var latLo = -90.0, latHi = 90.0;
    var lonLo = -180.0, lonHi = 180.0;
    final lat = latitude.clamp(-90.0, 90.0);
    final lon = _wrapLongitude(longitude);
    final out = StringBuffer();
    var even = true;
    var bit = 0;
    var ch = 0;
    while (out.length < precision) {
      if (even) {
        final mid = (lonLo + lonHi) / 2;
        if (lon >= mid) {
          ch = (ch << 1) | 1;
          lonLo = mid;
        } else {
          ch = ch << 1;
          lonHi = mid;
        }
      } else {
        final mid = (latLo + latHi) / 2;
        if (lat >= mid) {
          ch = (ch << 1) | 1;
          latLo = mid;
        } else {
          ch = ch << 1;
          latHi = mid;
        }
      }
      even = !even;
      if (++bit == 5) {
        out.write(alphabet[ch]);
        bit = 0;
        ch = 0;
      }
    }
    return out.toString();
  }

  /// South, west, north, east of [hash].
  static GeohashBounds bounds(String hash) {
    if (!isValid(hash)) throw FormatException('not a geohash: $hash');
    var latLo = -90.0, latHi = 90.0;
    var lonLo = -180.0, lonHi = 180.0;
    var even = true;
    for (var i = 0; i < hash.length; i++) {
      final v = _index[hash[i]]!;
      for (var b = 4; b >= 0; b--) {
        final on = (v >> b) & 1 == 1;
        if (even) {
          final mid = (lonLo + lonHi) / 2;
          if (on) {
            lonLo = mid;
          } else {
            lonHi = mid;
          }
        } else {
          final mid = (latLo + latHi) / 2;
          if (on) {
            latLo = mid;
          } else {
            latHi = mid;
          }
        }
        even = !even;
      }
    }
    return GeohashBounds(south: latLo, west: lonLo, north: latHi, east: lonHi);
  }

  /// The cell's own [hash] and the eight around it, at the same length.
  ///
  /// By stepping from the centre by one cell's size rather than by the
  /// classic neighbour tables: the same answer, and the antimeridian falls out
  /// of [_wrapLongitude]. Rows past a pole are left out — there is nothing
  /// north of the top row to stand in.
  static List<String> withNeighbours(String hash) {
    final b = bounds(hash);
    final height = b.north - b.south;
    final width = b.east - b.west;
    final (lat, lon) = b.center;
    final out = <String>[hash];
    for (final dy in const [-1, 0, 1]) {
      for (final dx in const [-1, 0, 1]) {
        if (dx == 0 && dy == 0) continue;
        final y = lat + dy * height;
        if (y < -90 || y > 90) continue;
        final cell = encode(y, _wrapLongitude(lon + dx * width), hash.length);
        if (!out.contains(cell)) out.add(cell);
      }
    }
    return out;
  }

  static double _wrapLongitude(double lon) {
    var x = lon;
    while (x < -180) {
      x += 360;
    }
    while (x >= 180) {
      x -= 360;
    }
    return x;
  }
}

class GeohashBounds {
  const GeohashBounds({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  final double south;
  final double west;
  final double north;
  final double east;

  (double, double) get center => ((south + north) / 2, (west + east) / 2);

  bool contains(double latitude, double longitude) =>
      latitude >= south &&
      latitude < north &&
      longitude >= west &&
      longitude < east;
}
