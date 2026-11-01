import 'dart:async';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/transport/key_rotation.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/features/peers/data/key_rotation_receiver.dart';
import 'package:flutter_test/flutter_test.dart';

String _hex(List<int> b) =>
    b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

class _Account {
  _Account(this.x, this.ed, this.edPub);

  final Uint8List x;
  final SimpleKeyPair ed;
  final Uint8List edPub;

  static Future<_Account> make() async {
    final xPair = await X25519().newKeyPair();
    final ed = await Ed25519().newKeyPair();
    return _Account(
      Uint8List.fromList((await xPair.extractPublicKey()).bytes),
      ed,
      Uint8List.fromList((await ed.extractPublicKey()).bytes),
    );
  }
}

Future<KeyRotation> _rotate(_Account from, _Account to, {int at = 1000}) =>
    KeyRotation.sign(
      oldX: from.x,
      oldSign: from.ed,
      newX: to.x,
      newSign: to.ed,
      newNostr: Uint8List.fromList(List.filled(32, 7)),
      atMs: at,
    );

class _Target implements KeyRotationTarget {
  final signKeys = <String, Uint8List>{};
  final rotated = <String, String>{};
  final migrations = <String>[];

  @override
  Uint8List? signKeyOf(String pubkeyHex) => signKeys[pubkeyHex];

  @override
  String? rotatedTo(String oldHex) => rotated[oldHex];

  @override
  Future<void> migrate({
    required String oldHex,
    required String newHex,
    required Uint8List newSignPub,
    required Uint8List newNostr,
  }) async {
    rotated[oldHex] = newHex;
    migrations.add('$oldHex>$newHex');
  }
}

void main() {
  group('KeyRotation', () {
    test('signs, encodes and verifies', () async {
      final a = await _Account.make();
      final b = await _Account.make();
      final r = KeyRotation.decode((await _rotate(a, b, at: 1_700_000_000_123)).encode());
      expect(r.oldX, a.x);
      expect(r.newX, b.x);
      expect(r.newEd, b.edPub);
      expect(r.atMs, 1_700_000_000_123);
      expect(await r.verify(a.edPub), isTrue);
    });

    test('any changed field breaks it', () async {
      final a = await _Account.make();
      final b = await _Account.make();
      final bytes = (await _rotate(a, b)).encode();
      // One byte in each field: old, new, new signing and Nostr keys, the
      // time, and both signatures.
      for (final at in [1, 40, 70, 100, 130, 140, 200, 264]) {
        final bent = Uint8List.fromList(bytes)..[at] ^= 0x01;
        final KeyRotation r;
        try {
          r = KeyRotation.decode(bent);
        } on FormatException {
          continue;
        }
        expect(await r.verify(a.edPub), isFalse, reason: 'byte $at flipped');
      }
    });

    test('the wrong old signing key does not verify', () async {
      final a = await _Account.make();
      final b = await _Account.make();
      final r = await _rotate(a, b);
      expect(await r.verify(b.edPub), isFalse);
    });

    test('truncated or unknown version is refused', () async {
      final a = await _Account.make();
      final bytes = (await _rotate(a, await _Account.make())).encode();
      expect(
        () => KeyRotation.decode(Uint8List.sublistView(bytes, 0, 100)),
        throwsFormatException,
      );
      expect(
        () => KeyRotation.decode(Uint8List.fromList(bytes)..[0] = 2),
        throwsFormatException,
      );
    });
  });

  group('KeyRotationReceiver', () {
    late StreamController<ReceivedKeyRotation> inbound;
    late _Target target;
    late KeyRotationReceiver receiver;

    setUp(() {
      inbound = StreamController<ReceivedKeyRotation>();
      target = _Target();
      receiver = KeyRotationReceiver(inbound: inbound.stream, target: target);
    });

    tearDown(() => receiver.dispose());

    Future<void> deliver(_Account sender, KeyRotation r) async {
      inbound.add(
        ReceivedKeyRotation(
          senderPub: sender.x,
          senderEdPub: sender.edPub,
          body: r.encode(),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      await receiver.idle;
    }

    test('a contact\'s rotation moves them, once', () async {
      final bob = await _Account.make();
      final bob2 = await _Account.make();
      target.signKeys[_hex(bob.x)] = bob.edPub;
      final r = await _rotate(bob, bob2);
      await deliver(bob, r);
      await deliver(bob, r);
      expect(target.migrations, ['${_hex(bob.x)}>${_hex(bob2.x)}']);
    });

    test('a second, different rotation of the same key is refused',
        () async {
      final bob = await _Account.make();
      final bob2 = await _Account.make();
      final thief = await _Account.make();
      target.signKeys[_hex(bob.x)] = bob.edPub;
      await deliver(bob, await _rotate(bob, bob2));
      await deliver(bob, await _rotate(bob, thief));
      expect(target.migrations, hasLength(1));
      expect(target.rotated[_hex(bob.x)], _hex(bob2.x));
    });

    test('not a contact, or naming another account, is dropped', () async {
      final bob = await _Account.make();
      final carol = await _Account.make();
      final next = await _Account.make();
      await deliver(bob, await _rotate(bob, next));
      expect(target.migrations, isEmpty, reason: 'bob is not a contact');

      target.signKeys[_hex(carol.x)] = carol.edPub;
      target.signKeys[_hex(bob.x)] = bob.edPub;
      await deliver(bob, await _rotate(carol, next));
      expect(target.migrations, isEmpty, reason: 'bob speaking for carol');
    });

    test('a frame signed by another key than the one on file is dropped',
        () async {
      final bob = await _Account.make();
      final next = await _Account.make();
      final other = await _Account.make();
      target.signKeys[_hex(bob.x)] = other.edPub;
      await deliver(bob, await _rotate(bob, next));
      expect(target.migrations, isEmpty);
    });
  });
}
