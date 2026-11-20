import 'package:cubechat/core/ble/ble_constants.dart';
import 'package:cubechat/core/ble/ble_scan_platform.dart';
import 'package:cubechat/core/ble/ble_scanner.dart';
import 'package:cubechat/features/peers/models/discovered_peer.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_test/flutter_test.dart';

// An iPhone with cubechat in the background advertises no name and no UUID
// list — only Apple manufacturer data: type 0x01 and a 128-bit mask with one
// bit per advertised service UUID. The Android scanner lists it when the bit
// is ours, and only then.

const _mac = 'AA:BB:CC:DD:EE:FF';

/// Overflow advertisement with [bits] set, in iosOverflowBit's numbering.
ScanResult _overflow(String mac, List<int> bits) {
  final mask = List<int>.filled(BleConstants.appleOverflowMaskLen, 0);
  for (final bit in bits) {
    mask[bit >> 3] |= 0x80 >> (bit & 7);
  }
  return ScanResult(
    device: BluetoothDevice(remoteId: DeviceIdentifier(mac)),
    advertisementData: AdvertisementData(
      advName: '',
      txPowerLevel: null,
      appearance: null,
      connectable: true,
      manufacturerData: {
        BleConstants.appleCompanyId: [BleConstants.appleOverflowType, ...mask],
      },
      serviceData: const {},
      serviceUuids: const [],
    ),
    rssi: -80,
    timeStamp: DateTime.now(),
  );
}

List<DiscoveredPeer> _scan(int? bit, List<ScanResult> results) {
  late List<DiscoveredPeer> last;
  fakeAsync((async) {
    final scanner = BleScanner(isIOS: false, iosOverflowBit: bit);
    last = const [];
    scanner.peers.listen((p) => last = p);
    scanner.debugOnResults(results);
    async.flushMicrotasks();
  });
  return last;
}

void main() {
  test('bits are counted from the most significant bit of the first byte', () {
    final mask = List<int>.filled(16, 0)
      ..[0] = 0x80
      ..[1] = 0x01
      ..[15] = 0x01;
    expect(BleConstants.overflowBits(mask), [0, 15, 127]);
    expect(BleConstants.overflowHasBit(mask, 15), isTrue);
    expect(BleConstants.overflowHasBit(mask, 14), isFalse);
    expect(BleConstants.overflowHasBit(mask, 128), isFalse);
  });

  test('the scan filter asks for exactly the measured bit', () {
    final filter = appleOverflowFilter(13);
    expect(filter.manufacturerId, 0x004C);
    expect(filter.data, hasLength(17));
    expect(filter.mask, hasLength(17));
    expect(filter.data[0], 0x01);
    expect(filter.mask[0], 0xFF);
    // Bit 13 is byte 1 of the mask, 0x80 >> 5.
    expect(filter.data[2], 0x04);
    expect(filter.mask[2], 0x04);
    expect(filter.mask.where((b) => b != 0), hasLength(2));
  });

  test('with no bit measured the filter takes any overflow advertisement', () {
    final filter = appleOverflowFilter(null);
    expect(filter.data, [0x01]);
    expect(filter.mask, [0xFF]);
  });

  test('with no bit measured a background iPhone is only logged', () {
    expect(_scan(null, [_overflow(_mac, [42])]), isEmpty);
  });

  test('a background iPhone carrying our bit is listed by its address', () {
    final peers = _scan(42, [_overflow(_mac, [7, 42])]);
    expect(peers, hasLength(1));
    expect(peers.single.id, _mac);
    expect(peers.single.rotatingId, isNull);
  });

  test("another app's bit is not one of ours", () {
    expect(_scan(42, [_overflow(_mac, [7, 43])]), isEmpty);
  });
}
