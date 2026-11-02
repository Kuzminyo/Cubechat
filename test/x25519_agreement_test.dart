import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/crypto/identity_keys.dart';
import 'package:cubechat/core/crypto/noise/noise_session.dart';
import 'package:cubechat/core/crypto/radio_crypto.dart';
import 'package:cubechat/core/crypto/sealed_box.dart';
import 'package:cubechat/core/crypto/x25519_agreement.dart';
import 'package:flutter_test/flutter_test.dart';

/// u = 0 (order 2) and u = 1 (order 4) are both of small order: X25519 with
/// either gives zero whatever the private key, because every clamped scalar is
/// a multiple of 8.
final Uint8List _uZero = Uint8List(32);
final Uint8List _uOne = Uint8List(32)..[0] = 1;

SimplePublicKey _pub(Uint8List b) =>
    SimplePublicKey(b, type: KeyPairType.x25519);

Future<IdentityKeys> _mintIdentity() async {
  final pair = await X25519().newKeyPair();
  final pub = await pair.extractPublicKey();
  final edPair = await Ed25519().newKeyPair();
  final edPub = await edPair.extractPublicKey();
  return IdentityKeys(
    publicKey: Uint8List.fromList(pub.bytes),
    privateKey: Uint8List.fromList(await pair.extractPrivateKeyBytes()),
    signPublicKey: Uint8List.fromList(edPub.bytes),
    signPrivateKey: Uint8List.fromList(await edPair.extractPrivateKeyBytes()),
  );
}

void main() {
  group('contributorySharedSecret', () {
    test('the library alone really does return zero for a low-order key',
        () async {
      // The reason the guard exists; if a future package:cryptography starts
      // refusing these itself, this is the test that says so.
      final kp = await X25519().newKeyPair();
      final shared = await X25519()
          .sharedSecretKey(keyPair: kp, remotePublicKey: _pub(_uZero));
      expect(await shared.extractBytes(), everyElement(0));
    });

    for (final (name, key) in [('u = 0', _uZero), ('u = 1', _uOne)]) {
      test('refuses $name', () async {
        final kp = await X25519().newKeyPair();
        await expectLater(
          contributorySharedSecret(
            X25519(),
            keyPair: kp,
            remotePublicKey: _pub(key),
          ),
          throwsA(isA<FormatException>()),
        );
      });
    }

    test('agrees with the plain call for an ordinary key', () async {
      final a = await X25519().newKeyPair();
      final b = await X25519().newKeyPair();
      final bPub = await b.extractPublicKey();
      final plain =
          await X25519().sharedSecretKey(keyPair: a, remotePublicKey: bPub);
      final guarded = await contributorySharedSecret(
        X25519(),
        keyPair: a,
        remotePublicKey: bPub,
      );
      expect(await guarded.extractBytes(), await plain.extractBytes());
    });
  });

  group('callers refuse a low-order key', () {
    test('SealedBox.open with an all-zero ephemeral', () async {
      final kp = await X25519().newKeyPair();
      final pub = Uint8List.fromList((await kp.extractPublicKey()).bytes);
      final data = await kp.extract();
      final wire = Uint8List(SealedBox.overhead + 4); // ephemeral = zeros
      await expectLater(
        SealedBox.open(wire, recipientKeyPair: data, recipientPubkey: pub),
        throwsA(isA<FormatException>()),
      );
    });

    test('Noise XX responder given an all-zero ephemeral', () async {
      final bob = await NoiseSession.respond(await _mintIdentity());
      await bob.readHandshake(Uint8List(32));
      // ee happens on the responder's write.
      await expectLater(bob.writeHandshake(), throwsA(isA<FormatException>()));
      expect(bob.established, isFalse);
    });

    test('a radio pair key with a low-order contact key', () async {
      final kp = await X25519().newKeyPair();
      final pub = Uint8List.fromList((await kp.extractPublicKey()).bytes);
      await expectLater(
        RadioCrypto.derivePairKey(mine: kp, myPub: pub, theirPub: _uOne),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
