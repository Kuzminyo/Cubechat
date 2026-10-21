import 'dart:typed_data';

import 'package:cryptography/cryptography.dart'
    show SecretBoxAuthenticationError, SimpleKeyPair, X25519;
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

  group('RadioCrypto pair', () {
    Future<(SimpleKeyPair, Uint8List)> identity() async {
      final kp = await X25519().newKeyPair();
      return (kp, Uint8List.fromList((await kp.extractPublicKey()).bytes));
    }

    test('both sides derive the same pair key', () async {
      final (a, aPub) = await identity();
      final (b, bPub) = await identity();
      final fromA =
          await RadioCrypto.derivePairKey(mine: a, myPub: aPub, theirPub: bPub);
      final fromB =
          await RadioCrypto.derivePairKey(mine: b, myPub: bPub, theirPub: aPub);
      expect(fromA, equals(fromB));
      expect(fromA.length, RadioCrypto.keyLen);
    });

    test("a third party's pair key differs", () async {
      final (a, aPub) = await identity();
      final (_, bPub) = await identity();
      final (c, cPub) = await identity();
      final ab =
          await RadioCrypto.derivePairKey(mine: a, myPub: aPub, theirPub: bPub);
      final cb =
          await RadioCrypto.derivePairKey(mine: c, myPub: cPub, theirPub: bPub);
      final ca =
          await RadioCrypto.derivePairKey(mine: c, myPub: cPub, theirPub: aPub);
      expect(cb, isNot(equals(ab)));
      expect(ca, isNot(equals(ab)));
    });

    test('a pair key is not a group key, nor its tag a group tag', () async {
      final (a, aPub) = await identity();
      final (_, bPub) = await identity();
      final pair =
          await RadioCrypto.derivePairKey(mine: a, myPub: aPub, theirPub: bPub);
      final group = await RadioCrypto.deriveKey('', '');
      expect(pair, isNot(equals(group)));
      // Fed the very same key bytes, the pair tag and the group tag still do
      // not agree: the domains keep the two selectors apart.
      expect(
        await RadioCrypto.derivePairTag(pair, 0),
        isNot(equals(await RadioCrypto.deriveTag(pair))),
      );
    });

    test('the pair tag is 8 bytes, stable within an epoch, new each epoch',
        () async {
      final (a, aPub) = await identity();
      final (_, bPub) = await identity();
      final key =
          await RadioCrypto.derivePairKey(mine: a, myPub: aPub, theirPub: bPub);
      final t = await RadioCrypto.derivePairTag(key, 493000);
      expect(t.length, RadioCrypto.tagLen);
      expect(await RadioCrypto.derivePairTag(key, 493000), equals(t));
      expect(await RadioCrypto.derivePairTag(key, 493001), isNot(equals(t)));
    });
  });
}
