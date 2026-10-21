import 'dart:typed_data';

import 'package:cryptography/cryptography.dart'
    show SecretBoxAuthenticationError;
import 'package:cubechat/core/crypto/channel_crypto.dart';
import 'package:cubechat/core/crypto/radio_crypto.dart';
import 'package:cubechat/features/channels/models/channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RadioCrypto', () {
    test('same name and password give the same key', () async {
      final a = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      final b = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      expect(a, equals(b));
      expect(a.length, 32);
    });

    test('a different name or password gives a different key', () async {
      final base = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      expect(await RadioCrypto.deriveKey('#patrol', 'other'), isNot(base));
      expect(await RadioCrypto.deriveKey('#other', 'hunter2'), isNot(base));
    });

    test('the name a user typed is normalised before it reaches the key',
        () async {
      // RadioCrypto takes the already-normalised name, like ChannelCrypto;
      // the shared normaliser is what makes "#Patrol " and "patrol" one group.
      final a = await RadioCrypto.deriveKey(
        normalizeChannelName('#Patrol '),
        'x',
      );
      final b =
          await RadioCrypto.deriveKey(normalizeChannelName('patrol'), 'x');
      expect(a, equals(b));
    });

    test(
        'radio key differs from the channel key for the same name and '
        'password', () async {
      final radio = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      final channel = await ChannelCrypto.deriveKey('#patrol', 'hunter2');
      expect(radio, isNot(equals(channel)));
    });

    test('tag is 8 bytes, stable, and differs from the channel tag', () async {
      final radioKey = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      final t1 = await RadioCrypto.deriveTag(radioKey);
      final t2 = await RadioCrypto.deriveTag(radioKey);
      expect(t1.length, 8);
      expect(t1, equals(t2));

      // Even fed the very same key bytes the two domains must not agree, so
      // a radio tag can never be mistaken for a channel's selector.
      final channelTag = await ChannelCrypto.deriveTag(radioKey);
      expect(t1, isNot(equals(channelTag)));
      final channelKey = await ChannelCrypto.deriveKey('#patrol', 'hunter2');
      expect(
        await RadioCrypto.deriveTag(radioKey),
        isNot(equals(await ChannelCrypto.deriveTag(channelKey))),
      );
    });

    test('seal then open round-trips', () async {
      final key = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      final plain =
          Uint8List.fromList(List<int>.generate(300, (i) => i & 0xFF));
      final blob = await RadioCrypto.seal(key, plain);
      expect(blob.length, 12 + plain.length + 16);
      expect(await RadioCrypto.open(key, blob), plain);
    });

    test('open with a wrong password throws', () async {
      final key = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      final wrong = await RadioCrypto.deriveKey('#patrol', 'hunter3');
      final blob = await RadioCrypto.seal(key, Uint8List.fromList([1, 2, 3]));
      await expectLater(
        RadioCrypto.open(wrong, blob),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });

    test('tampered blob throws', () async {
      final key = await RadioCrypto.deriveKey('#patrol', 'hunter2');
      final blob = await RadioCrypto.seal(key, Uint8List.fromList([1, 2, 3]));
      for (final i in [0, 12, blob.length - 1]) {
        final bad = Uint8List.fromList(blob)..[i] ^= 0x01;
        await expectLater(
          RadioCrypto.open(key, bad),
          throwsA(isA<SecretBoxAuthenticationError>()),
          reason: 'flipped byte $i',
        );
      }
    });

    test('a blob shorter than nonce and mac throws FormatException', () async {
      final key = await RadioCrypto.deriveKey('#patrol', '');
      await expectLater(
        RadioCrypto.open(key, Uint8List(27)),
        throwsFormatException,
      );
    });
  });
}
