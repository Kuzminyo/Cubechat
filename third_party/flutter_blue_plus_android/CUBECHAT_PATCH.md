# CubeChat patches to flutter_blue_plus_android 7.0.4

Copied from the pub cache's `flutter_blue_plus_android-7.0.4` and wired in as a
path override in the app's `pubspec.yaml`. An upgrade means copying the new
version here and reapplying what is below. `flutter_blue_plus` itself (the Dart
package) is not vendored; only this Android half is.

## Connect on 1M and LE Coded (2026-11-20)

Since 2026-11-20 an Android phone whose chipset supports LE Coded advertises a
second, long-range set on Coded PHY next to its ordinary one
(`CubechatBlePeripheralPlugin.startCodedSet`). To connect to a phone heard only
on that set, the central has to *initiate* on Coded too: the initiator listens
for the advertiser on the PHYs it was told to, and the plugin's

    device.connectGatt(context, autoConnect, mGattCallback, BluetoothDevice.TRANSPORT_LE)

is the overload that initiates on 1M alone. Without this patch the Coded set is
heard by the scanner and every connection to it times out.

The patch, in `FlutterBluePlusPlugin.java`'s `connect` handler, uses the
five-argument overload on API 26+ when the adapter reports
`isLeCodedPhySupported()`:

    device.connectGatt(context, autoConnect, mGattCallback,
        BluetoothDevice.TRANSPORT_LE,
        BluetoothDevice.PHY_LE_1M_MASK | BluetoothDevice.PHY_LE_CODED_MASK);

Everything else falls through to the original code. A peer advertising on 1M is
still connected on 1M; the mask only adds Coded to what the initiator listens
on. A link that does come up on Coded is moved to 1M/2M by `BleGattClient` once
its signal is strong enough, because Coded is eight times slower.

Search for `CUBECHAT PATCH` to find it.
