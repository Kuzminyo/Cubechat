import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/crypto/signed_payload.dart';
import 'package:flutter_test/flutter_test.dart';

Future<({SimpleKeyPairData kp, Uint8List pub})> _newKey() async {
  final pair = await Ed25519().newKeyPair();
  final pub = await pair.extractPublicKey();
  final seed = await pair.extractPrivateKeyBytes();
  return (
    kp: SimpleKeyPairData(seed,
        publicKey: pub, type: KeyPairType.ed25519),
    pub: Uint8List.fromList(pub.bytes),
  );
}

void main() {
  group('SignedPayload', () {
    test('wrap/verify roundtrips an inner payload', () async {
      final sender = await _newKey();
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List.fromList(List.filled(8, 1)),
        destPubkeyHash: Uint8List.fromList(List.filled(8, 2)),
        msgId: Uint8List.fromList(List.generate(16, (i) => i)),
      );
      final inner = Uint8List.fromList([0x10, 72, 105]); // [text-tag]'Hi'
      final wire = await SignedPayload.wrap(
        inner: inner,
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      expect(wire[0], SignedPayload.markerByte);

      final verified = await SignedPayload.verify(
        wire: wire,
        context: ctx,
      );
      expect(verified.inner, equals(inner));
      expect(verified.senderEdPub, equals(sender.pub));
    });

    test('round-trips the signed timestamp', () async {
      final sender = await _newKey();
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      const ts = 1893456000000; // fixed wall-clock for determinism
      final wire = await SignedPayload.wrap(
        inner: Uint8List.fromList([0x10, 1]),
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
        timestampMs: ts,
      );
      final verified = await SignedPayload.verify(wire: wire, context: ctx);
      expect(verified.timestampMs, ts);
    });

    test('a tampered timestamp fails verification', () async {
      final sender = await _newKey();
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      final wire = await SignedPayload.wrap(
        inner: Uint8List.fromList([0x10, 1]),
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
        timestampMs: 1893456000000,
      );
      // Flip a byte inside the 8-byte timestamp region (right after the
      // marker + pub + sig header prefix).
      final tsOffset = 1 + SignedPayload.pubLen + SignedPayload.sigLen;
      final tampered = Uint8List.fromList(wire);
      tampered[tsOffset] ^= 0xFF;
      await expectLater(
        () => SignedPayload.verify(wire: tampered, context: ctx),
        throwsA(isA<SignatureVerificationException>()),
      );
    });

    test('strict expectedEdPub matches → passes', () async {
      final sender = await _newKey();
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      final inner = Uint8List.fromList([0x10, 1, 2, 3]);
      final wire = await SignedPayload.wrap(
        inner: inner,
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      final verified = await SignedPayload.verify(
        wire: wire,
        context: ctx,
        expectedEdPub: sender.pub,
      );
      expect(verified.inner, equals(inner));
    });

    test('strict expectedEdPub mismatch → throws', () async {
      final sender = await _newKey();
      final stranger = await _newKey();
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      final wire = await SignedPayload.wrap(
        inner: Uint8List.fromList([0x10, 1]),
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      await expectLater(
        () => SignedPayload.verify(
          wire: wire,
          context: ctx,
          expectedEdPub: stranger.pub,
        ),
        throwsA(isA<SignatureVerificationException>()),
      );
    });

    test('tampered inner bytes fail verification', () async {
      final sender = await _newKey();
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      final inner = Uint8List.fromList([0x10, 1, 2, 3]);
      final wire = await SignedPayload.wrap(
        inner: inner,
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      final tampered = Uint8List.fromList(wire);
      tampered[SignedPayload.headerLen + 1] ^= 0x40;
      await expectLater(
        () => SignedPayload.verify(wire: tampered, context: ctx),
        throwsA(isA<SignatureVerificationException>()),
      );
    });

    test('different context (different msgId) fails verification', () async {
      final sender = await _newKey();
      final ctxA = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List.fromList(List.generate(16, (i) => i)),
      );
      final ctxB = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List.fromList(List.generate(16, (i) => i + 1)),
      );
      final wire = await SignedPayload.wrap(
        inner: Uint8List.fromList([0x10, 7]),
        context: ctxA,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      await expectLater(
        () => SignedPayload.verify(wire: wire, context: ctxB),
        throwsA(isA<SignatureVerificationException>()),
      );
    });

    test('wrong marker byte throws FormatException', () async {
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      final bad = Uint8List(SignedPayload.headerLen + 4)..[0] = 0x10;
      await expectLater(
        () => SignedPayload.verify(wire: bad, context: ctx),
        throwsA(isA<FormatException>()),
      );
    });

    test('truncated wire throws FormatException', () async {
      final ctx = SignedPayload.contextBytes(
        originPubkeyHash: Uint8List(8),
        destPubkeyHash: Uint8List(8),
        msgId: Uint8List(16),
      );
      await expectLater(
        () => SignedPayload.verify(wire: Uint8List(10), context: ctx),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('SignedPayload.detachedProof', () {
    final ctx = SignedPayload.contextBytes(
      originPubkeyHash: Uint8List.fromList(List.filled(8, 1)),
      destPubkeyHash: Uint8List.fromList(List.filled(8, 2)),
      msgId: Uint8List.fromList(List.generate(16, (i) => i)),
    );
    final inner = Uint8List.fromList([0x10, 0, 2, 72, 105, 9, 9]);

    test('a full wrap becomes a proof anyone can check', () async {
      final sender = await _newKey();
      final wire = await SignedPayload.wrap(
        inner: inner,
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
        timestampMs: 1893456000000,
      );
      final proof = SignedPayload.detachedProof(
        wire: wire,
        context: ctx,
        senderEdPub: sender.pub,
      )!;
      expect(proof.length, 32 + 32 + 64 + 8 + inner.length);
      final checked = await SignedPayload.verifyDetachedProof(proof);
      expect(checked.senderEdPub, sender.pub);
      expect(checked.inner, inner);
      expect(checked.timestampMs, 1893456000000);
    });

    test('a compact wrap gives the same shape, with the key put back',
        () async {
      final sender = await _newKey();
      final wire = await SignedPayload.wrapCompact(
        inner: inner,
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      final proof = SignedPayload.detachedProof(
        wire: wire,
        context: ctx,
        senderEdPub: sender.pub,
      )!;
      final checked = await SignedPayload.verifyDetachedProof(proof);
      expect(checked.senderEdPub, sender.pub);
      expect(checked.inner, inner);
    });

    test('changing the text, the key or the context breaks the proof',
        () async {
      final sender = await _newKey();
      final other = await _newKey();
      final wire = await SignedPayload.wrap(
        inner: inner,
        context: ctx,
        signKeyPair: sender.kp,
        senderEdPub: sender.pub,
      );
      final proof = SignedPayload.detachedProof(
        wire: wire,
        context: ctx,
        senderEdPub: sender.pub,
      )!;
      for (final at in [0, 40, proof.length - 1]) {
        final bad = Uint8List.fromList(proof)..[at] ^= 1;
        await expectLater(
          SignedPayload.verifyDetachedProof(bad),
          throwsA(isA<SignatureVerificationException>()),
        );
      }
      // Somebody else's key spliced in is somebody else's claim.
      final swapped = Uint8List.fromList(proof)..setRange(32, 64, other.pub);
      await expectLater(
        SignedPayload.verifyDetachedProof(swapped),
        throwsA(isA<SignatureVerificationException>()),
      );
      await expectLater(
        SignedPayload.verifyDetachedProof(Uint8List(100)),
        throwsA(isA<FormatException>()),
      );
    });

    test('anything that is not a signed payload gives no proof', () async {
      final sender = await _newKey();
      expect(
        SignedPayload.detachedProof(
          wire: inner,
          context: ctx,
          senderEdPub: sender.pub,
        ),
        isNull,
      );
      expect(
        SignedPayload.detachedProof(
          wire: Uint8List.fromList([SignedPayload.markerByte, 1, 2]),
          context: ctx,
          senderEdPub: sender.pub,
        ),
        isNull,
      );
    });
  });
}
