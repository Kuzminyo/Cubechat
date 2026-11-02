import 'package:cubechat/features/area/domain/area_level.dart';
import 'package:cubechat/features/area/domain/geohash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Geohash.encode', () {
    test('matches the reference vectors', () {
      // The Wikipedia example, and three more checked against an independent
      // implementation.
      expect(Geohash.encode(57.64911, 10.40744, 11), 'u4pruydqqvj');
      expect(Geohash.encode(42.6, -5.6, 5), 'ezs42');
      expect(Geohash.encode(50.4501, 30.5234, 5), 'u8vxn');
      expect(Geohash.encode(-25.38262, -49.26561, 8), '6gkzwgjz');
    });

    test('a prefix is the larger cell holding the point', () {
      final fine = Geohash.encode(50.4501, 30.5234, 9);
      for (var p = 1; p < 9; p++) {
        expect(Geohash.encode(50.4501, 30.5234, p), fine.substring(0, p));
      }
    });

    test('bounds hold the point, and the centre encodes back to the cell', () {
      const lat = 50.4501, lon = 30.5234;
      for (var p = 3; p <= 6; p++) {
        final hash = Geohash.encode(lat, lon, p);
        final b = Geohash.bounds(hash);
        expect(b.contains(lat, lon), isTrue, reason: hash);
        final (cLat, cLon) = b.center;
        expect(Geohash.encode(cLat, cLon, p), hash);
      }
    });

    test('rejects what is not a geohash', () {
      expect(Geohash.isValid('u8vxn'), isTrue);
      expect(Geohash.isValid('u8vxa'), isFalse); // `a` is not in the alphabet
      expect(Geohash.isValid('U8VXN'), isFalse);
      expect(Geohash.isValid(''), isFalse);
      expect(Geohash.isValid('u8vx', length: 5), isFalse);
      expect(() => Geohash.bounds('ilo'), throwsFormatException);
    });
  });

  group('Geohash.withNeighbours', () {
    test('nine distinct cells around one, all touching it', () {
      final cells = Geohash.withNeighbours('u8vxn');
      expect(cells.first, 'u8vxn');
      expect(cells.toSet(), hasLength(9));
      final mine = Geohash.bounds('u8vxn');
      const eps = 1e-9;
      for (final c in cells.skip(1)) {
        final b = Geohash.bounds(c);
        final touchesLat = b.north >= mine.south - eps && b.south <= mine.north + eps;
        final touchesLon = b.east >= mine.west - eps && b.west <= mine.east + eps;
        expect(touchesLat && touchesLon, isTrue, reason: c);
      }
    });

    test('wraps across the antimeridian', () {
      final east = Geohash.encode(0.1, 179.99, 5);
      final west = Geohash.encode(0.1, -179.99, 5);
      expect(east, 'xbpbx');
      expect(west, '80008');
      expect(Geohash.withNeighbours(east), contains(west));
      expect(Geohash.withNeighbours(west), contains(east));
    });

    test('a polar row leaves out what is past the pole', () {
      final top = Geohash.encode(89.99, 10, 3);
      final cells = Geohash.withNeighbours(top);
      expect(cells.length, lessThan(9));
      expect(cells.toSet(), hasLength(cells.length));
    });
  });

  group('AreaPlace', () {
    test('a fix becomes five characters and no more', () {
      final district = coarsenToDistrict(50.45012345, 30.52345678);
      expect(district, 'u8vxn');
      expect(district, hasLength(5));
    });

    test('city and region are prefixes, the subscription is never finer '
        'than a city', () {
      final place = AreaPlace('u8vxn');
      expect(place.city, 'u8vx');
      expect(place.region, 'u8v');
      expect(place.viewDistricts, hasLength(9));
      expect(place.subscription, contains('u8vx'));
      expect(place.subscription, contains('u8v'));
      for (final g in place.subscription) {
        expect(g.length, lessThanOrEqualTo(4), reason: g);
      }
      // One to four cities for the nine districts, plus the region.
      expect(place.subscription.length, inInclusiveRange(2, 5));
    });
  });
}
