import 'package:cubechat/core/radio_spike.dart';
import 'package:cubechat/core/util/debug_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('cubechat/radio_spike');

  setUp(() {
    DebugLog.install();
    DebugLog.instance.clear();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('a native log call lands in DebugLog under RADIO-SPIKE', () async {
    // Touch the singleton so it installs its handler on the channel.
    RadioSpike.instance;
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
      'cubechat/radio_spike',
      const StandardMethodCodec().encodeMethodCall(
        const MethodCall('log', 'didActivate: activated, played'),
      ),
      (_) {},
    );
    expect(
      DebugLog.instance.entries.map((e) => e.line),
      contains('[RADIO-SPIKE] didActivate: activated, played'),
    );
  });

  test('incoming sends the method with the name and logs the answer', () async {
    final calls = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return 'ok';
    });

    final answer = await RadioSpike.instance.incoming('x');

    expect(answer, 'ok');
    expect(calls.single.method, 'incoming');
    expect(calls.single.arguments, 'x');
    expect(
      DebugLog.instance.entries.map((e) => e.line),
      contains('[RADIO-SPIKE] incoming -> ok'),
    );
  });
}
