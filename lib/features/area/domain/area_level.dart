import 'geohash.dart';

/// The three places the area chat has, by how many geohash characters name
/// them. Sizes are at Kyiv's latitude, width by height.
///
/// The block (6, ~1.2 × 0.6 km) is not here on purpose: people a few hundred
/// metres away are Bluetooth, and a kilometre in every message is the very
/// leak bitchat's H7 was (spec, «Уровни»).
enum AreaLevel {
  /// ~4.9 × 4.9 km. Chat only; never presence, never a note's cell by GPS.
  district(5),

  /// ~39 × 19.5 km — the finest thing the relay ever indexes.
  city(4),

  /// ~156 × 156 km.
  region(3);

  const AreaLevel(this.precision);

  final int precision;

  /// Whether presence and the "≈N here" count exist at this level.
  bool get coarse => this != AreaLevel.district;

  static AreaLevel? ofPrecision(int length) => switch (length) {
        5 => AreaLevel.district,
        4 => AreaLevel.city,
        3 => AreaLevel.region,
        _ => null,
      };
}

/// The one function a location fix becomes a cell in.
///
/// Five characters and no more, here and only here: everything downstream
/// sees the district, and the latitude and longitude end with this call — they
/// are neither returned nor kept (spec, rule 3).
String coarsenToDistrict(double latitude, double longitude) =>
    Geohash.encode(latitude, longitude, AreaLevel.district.precision);

/// Where the phone itself is, as cells: the district its own fix gave, and the
/// city and region that hold it.
class AreaPlace {
  AreaPlace(this.district)
      : assert(Geohash.isValid(district, length: 5), 'a district is 5 chars');

  final String district;

  String get city => district.substring(0, 4);
  String get region => district.substring(0, 3);

  String cellOf(AreaLevel level) => district.substring(0, level.precision);

  /// The district view: this district and its eight neighbours, filtered on
  /// the phone, so a border fifty metres away does not cut a street in half.
  List<String> get viewDistricts => Geohash.withNeighbours(district);

  /// What the subscription asks the relay for: the cities those nine
  /// districts lie in (one to four of them) and the region. Never finer than
  /// four characters (spec, rule 1).
  Set<String> get subscription => {
        for (final d in viewDistricts) d.substring(0, 4),
        region,
      };

  @override
  bool operator ==(Object other) =>
      other is AreaPlace && other.district == district;

  @override
  int get hashCode => district.hashCode;
}

/// A chat the phone may open: its own district, city or region — or, read
/// only, a city or region somebody picked on the map.
class AreaRoomId {
  const AreaRoomId.own(this.level)
      : foreignCell = null;

  const AreaRoomId.foreign(String cell)
      : foreignCell = cell,
        level = null;

  final AreaLevel? level;

  /// A city (4) or region (3) somebody is only reading.
  final String? foreignCell;

  bool get readOnly => foreignCell != null;

  /// The level this room is at, for a foreign one by the length of its cell.
  AreaLevel get effectiveLevel =>
      level ?? AreaLevel.ofPrecision(foreignCell!.length)!;

  @override
  bool operator ==(Object other) =>
      other is AreaRoomId &&
      other.level == level &&
      other.foreignCell == foreignCell;

  @override
  int get hashCode => Object.hash(level, foreignCell);

  @override
  String toString() =>
      readOnly ? 'AreaRoomId.foreign($foreignCell)' : 'AreaRoomId.own($level)';
}
