import 'package:cubechat/core/ble/ble_constants.dart';
import 'package:cubechat/core/ble/ble_scanner.dart';
import 'package:cubechat/features/peers/models/discovered_peer.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_test/flutter_test.dart';

// An Android phone that supports LE Coded advertises twice: its ordinary set
// (service UUID listed, rotating id as service data) and a long-range set
// with the rotating id alone, under a different address. The scanner must
// keep one entry, dialling the ordinary address while it is heard.

final _uuid = Guid(BleConstants.serviceUuid);
const _rotatingId = [1, 2, 3, 4, 5, 6, 7, 8];
const _legacyMac = 'AA:AA:AA:AA:AA:AA';
const _codedMac = 'CC:CC:CC:CC:CC:CC';

ScanResult _result(String mac, {required bool coded, int rssi = -70}) =>
    ScanResult(
      device: BluetoothDevice(remoteId: DeviceIdentifier(mac)),
      advertisementData: AdvertisementData(
        advName: '',
        txPowerLevel: null,
        appearance: null,
        connectable: true,
        manufacturerData: const {},
        serviceData: {_uuid: _rotatingId},
        serviceUuids: coded ? const [] : [_uuid],
      ),
      rssi: rssi,
      timeStamp: DateTime.now(),
    );

void main() {
  test('the Coded address does not take over while the ordinary one is heard',
      () {
    fakeAsync((async) {
      final scanner = BleScanner(isIOS: false);
      final snapshots = <List<DiscoveredPeer>>[];
      scanner.peers.listen(snapshots.add);

      scanner.debugOnResults([_result(_legacyMac, coded: false)]);
      async.flushMicrotasks();
      scanner.debugOnResults([_result(_codedMac, coded: true, rssi: -95)]);
      async.flushMicrotasks();

      final peer = snapshots.last.single;
      expect(peer.id, _legacyMac);
      expect(peer.rssi, -70);
    });
  });

  test('a phone heard only over Coded is listed under its Coded address', () {
    fakeAsync((async) {
      final scanner = BleScanner(isIOS: false);
      final snapshots = <List<DiscoveredPeer>>[];
      scanner.peers.listen(snapshots.add);

      scanner.debugOnResults([_result(_codedMac, coded: true, rssi: -98)]);
      async.flushMicrotasks();

      final peer = snapshots.last.single;
      expect(peer.id, _codedMac);
      expect(peer.rotatingId, '0102030405060708');
    });
  });

  test('the ordinary address takes back over from the Coded one', () {
    fakeAsync((async) {
      final scanner = BleScanner(isIOS: false);
      final snapshots = <List<DiscoveredPeer>>[];
      scanner.peers.listen(snapshots.add);

      scanner.debugOnResults([_result(_codedMac, coded: true, rssi: -98)]);
      async.flushMicrotasks();
      scanner.debugOnResults([_result(_legacyMac, coded: false, rssi: -80)]);
      async.flushMicrotasks();

      expect(snapshots.last.single.id, _legacyMac);
    });
  });
}
