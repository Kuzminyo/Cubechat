import 'dart:typed_data';

import 'package:cubechat/core/audio/radio_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const channel = MethodChannel('cubechat/radio_audio');
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return null;
    });
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('write sends pcm bytes in order and start passes the silent flag',
      () async {
    final audio = PlatformRadioAudio();
    await audio.start(playInSilentMode: true);
    await audio.write(Int16List.fromList([1, -2, 256]));
    await audio.write(Int16List.fromList([-32768, 32767]));
    await audio.stop();

    expect(calls.map((c) => c.method), ['start', 'write', 'write', 'stop']);
    expect(calls[0].arguments, {'sampleRate': 48000, 'playInSilentMode': true});
    // Little-endian PCM16: 1 -> 01 00, -2 -> FE FF, 256 -> 00 01.
    expect(
      calls[1].arguments,
      Uint8List.fromList([0x01, 0x00, 0xFE, 0xFF, 0x00, 0x01]),
    );
    expect(
      calls[2].arguments,
      Uint8List.fromList([0x00, 0x80, 0xFF, 0x7F]),
    );
  });

  test('start passes playInSilentMode false through', () async {
    final audio = PlatformRadioAudio();
    await audio.start(playInSilentMode: false);
    expect(calls.single.arguments['playInSilentMode'], false);
  });

  test('write before start is not sent', () async {
    final audio = PlatformRadioAudio();
    await audio.write(Int16List.fromList([1, 2, 3]));
    expect(calls, isEmpty);
  });

  test('write after stop is not sent', () async {
    final audio = PlatformRadioAudio();
    await audio.start(playInSilentMode: false);
    await audio.stop();
    calls.clear();
    await audio.write(Int16List.fromList([1]));
    expect(calls, isEmpty);
  });

  test('stop after stop is harmless', () async {
    final audio = PlatformRadioAudio();
    await audio.start(playInSilentMode: false);
    await audio.stop();
    await audio.stop();
    // The second stop must neither throw nor reach the platform: stopping a
    // player that is not running has nothing to tell it.
    expect(calls.map((c) => c.method), ['start', 'stop']);
  });

  test('a platform error never reaches the caller', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'audio');
    });
    final audio = PlatformRadioAudio();
    await audio.start(playInSilentMode: false);
    await audio.write(Int16List.fromList([1]));
    await audio.stop();
  });
}
