import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'ble_constants.dart';

/// The few radio calls [BleScanner] makes, behind a seam so the order of
/// starts and stops can be tested off-device. Production uses this class as
/// it is; tests subclass it.
class BleScanPlatform {
  const BleScanPlatform();

  Stream<BluetoothAdapterState> get adapterState =>
      FlutterBluePlus.adapterState;

  bool get isOn => FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on;

  bool get isScanning => FlutterBluePlus.isScanningNow;

  Future<void> startScan({
    required Duration timeout,
    required AndroidScanMode mode,
    required bool continuousUpdates,
  }) =>
      FlutterBluePlus.startScan(
        withServices: [Guid(BleConstants.serviceUuid)],
        // Android only: the long-range (LE Coded) set a peer advertises
        // carries our UUID as service data and not in its UUID list, so the
        // filter above alone never matches it — see BleScanner._isCodedOnly
        // for why it is left out of the list. Filters are OR'ed. iOS gets
        // nothing here: CoreBluetooth filters by service UUID only, and a
        // background scan without that filter returns nothing at all.
        withServiceData: defaultTargetPlatform == TargetPlatform.android
            ? [ServiceDataFilter(Guid(BleConstants.serviceUuid))]
            : const [],
        // Android only, for the same reason: an iPhone with cubechat in the
        // background advertises our UUID as a bit in Apple's overflow area,
        // not in its UUID list. See BleConstants.iosOverflowBit.
        withMsd: defaultTargetPlatform == TargetPlatform.android
            ? [appleOverflowFilter(BleConstants.iosOverflowBit)]
            : const [],
        timeout: timeout,
        androidScanMode: mode,
        continuousUpdates: continuousUpdates,
      );

  Future<void> stopScan() => FlutterBluePlus.stopScan();

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}

/// The scan filter for Apple overflow-area advertisements carrying [bit].
///
/// With the bit unknown it matches every overflow advertisement, so the
/// scanner can log what it hears for the one-off measurement — a rare thing to
/// hear, since only an app advertising from the background makes one. Never
/// Apple's other advertisements (Nearby Info, Find My, AirDrop), which every
/// iPhone sends constantly: those start with a different type byte.
MsdFilter appleOverflowFilter(int? bit) {
  if (bit == null) {
    return MsdFilter(
      BleConstants.appleCompanyId,
      data: const [BleConstants.appleOverflowType],
      mask: const [0xFF],
    );
  }
  final data = List<int>.filled(1 + BleConstants.appleOverflowMaskLen, 0);
  final mask = List<int>.filled(1 + BleConstants.appleOverflowMaskLen, 0);
  data[0] = BleConstants.appleOverflowType;
  mask[0] = 0xFF;
  data[1 + (bit >> 3)] = 0x80 >> (bit & 7);
  mask[1 + (bit >> 3)] = 0x80 >> (bit & 7);
  return MsdFilter(BleConstants.appleCompanyId, data: data, mask: mask);
}

/// Android stops returning scan results — silently, no error — after five
/// `startScan` calls inside 30 s. This remembers when scans were started and
/// says how long the next start should wait to stay at four, one short of the
/// limit.
///
/// 1109's proximity window restarted every 10.3 s (about three starts per
/// 30 s on its own) and restarted again on every arrival on the AirDrop page,
/// so switching tabs a couple of times was enough to blind the scan.
class ScanStartBudget {
  ScanStartBudget({this.maxStarts = 4, this.per = const Duration(seconds: 30)});

  final int maxStarts;
  final Duration per;

  /// A little past the moment the oldest start ages out, so the platform's
  /// clock and ours need not agree to the millisecond.
  static const Duration _slack = Duration(milliseconds: 250);

  final List<DateTime> _starts = [];

  void record(DateTime at) {
    _prune(at);
    _starts.add(at);
  }

  /// Starts recorded in the [per] before [now].
  int startsIn(DateTime now) {
    _prune(now);
    return _starts.length;
  }

  /// Zero when a start now keeps within the budget.
  Duration waitBefore(DateTime now) {
    _prune(now);
    if (_starts.length < maxStarts) return Duration.zero;
    final oldest = _starts[_starts.length - maxStarts];
    final wait = oldest.add(per).add(_slack).difference(now);
    return wait.isNegative ? Duration.zero : wait;
  }

  void _prune(DateTime now) =>
      _starts.removeWhere((t) => now.difference(t) >= per);
}
