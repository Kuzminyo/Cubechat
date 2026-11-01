import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// "This account now has these keys" — [InnerPayloadType.keyRotation] (0xED).
///
/// ```
///   [version=0x01][oldX:32][newX:32][newEd:32][newNostr:32][atMs:8]
///   [sigOld:64][sigNew:64]
/// ```
///
/// Both signatures cover [_domain] and every field before them. [sigOld] is
/// by the old Ed25519 key, the one the contact has on file: it says the
/// account's holder sent this. [sigNew] is by the new one: it says whoever
/// sent it holds the new key, so nobody can point an account at somebody
/// else's.
///
/// Neither says it was the *owner* — whoever stole the old key can sign one
/// too — which is why a contact moves the chat but drops "verified" (see
/// docs/superpowers/specs/2026-11-01-key-rotation-design.md).
class KeyRotation {
  const KeyRotation({
    required this.oldX,
    required this.newX,
    required this.newEd,
    required this.newNostr,
    required this.atMs,
    required this.sigOld,
    required this.sigNew,
  });

  static const int version = 0x01;
  static const int keyLen = 32;
  static const int sigLen = 64;
  static const int encodedLen = 1 + 4 * keyLen + 8 + 2 * sigLen;
  static const String _domain = 'cubechat-key-rotation-v1';

  final Uint8List oldX;
  final Uint8List newX;
  final Uint8List newEd;
  final Uint8List newNostr;
  final int atMs;
  final Uint8List sigOld;
  final Uint8List sigNew;

  static final _ed25519 = Ed25519();

  /// Sign a rotation from the old keys to the new ones. [oldSign] and
  /// [newSign] are the Ed25519 key pairs; the X25519 and Nostr keys are
  /// public ones.
  static Future<KeyRotation> sign({
    required Uint8List oldX,
    required SimpleKeyPair oldSign,
    required Uint8List newX,
    required SimpleKeyPair newSign,
    required Uint8List newNostr,
    required int atMs,
  }) async {
    final newEd = Uint8List.fromList((await newSign.extractPublicKey()).bytes);
    final message = _signed(oldX, newX, newEd, newNostr, atMs);
    final sigOld = await _ed25519.sign(message, keyPair: oldSign);
    final sigNew = await _ed25519.sign(message, keyPair: newSign);
    return KeyRotation(
      oldX: oldX,
      newX: newX,
      newEd: newEd,
      newNostr: newNostr,
      atMs: atMs,
      sigOld: Uint8List.fromList(sigOld.bytes),
      sigNew: Uint8List.fromList(sigNew.bytes),
    );
  }

  /// True when [sigOld] is by [oldEd] — the signing key the contact has on
  /// file for [oldX] — and [sigNew] by [newEd].
  Future<bool> verify(Uint8List oldEd) async {
    if (oldEd.length != keyLen) return false;
    final message = _signed(oldX, newX, newEd, newNostr, atMs);
    try {
      final byOld = await _ed25519.verify(
        message,
        signature: Signature(
          sigOld,
          publicKey: SimplePublicKey(oldEd, type: KeyPairType.ed25519),
        ),
      );
      if (!byOld) return false;
      return await _ed25519.verify(
        message,
        signature: Signature(
          sigNew,
          publicKey: SimplePublicKey(newEd, type: KeyPairType.ed25519),
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Uint8List encode() {
    for (final key in [oldX, newX, newEd, newNostr]) {
      if (key.length != keyLen) {
        throw const FormatException('a rotation key is 32 bytes');
      }
    }
    if (sigOld.length != sigLen || sigNew.length != sigLen) {
      throw const FormatException('a rotation signature is 64 bytes');
    }
    return (BytesBuilder(copy: false)
          ..add(_signed(oldX, newX, newEd, newNostr, atMs, withDomain: false))
          ..add(sigOld)
          ..add(sigNew))
        .takeBytes();
  }

  static KeyRotation decode(Uint8List bytes) {
    if (bytes.length != encodedLen) {
      throw FormatException('a key rotation is $encodedLen bytes');
    }
    if (bytes[0] != version) {
      throw FormatException('unknown key rotation version ${bytes[0]}');
    }
    Uint8List at(int from, int len) =>
        Uint8List.fromList(bytes.sublist(from, from + len));
    const keysAt = 1;
    const timeAt = keysAt + 4 * keyLen;
    const sigAt = timeAt + 8;
    final view = ByteData.sublistView(bytes, timeAt, sigAt);
    return KeyRotation(
      oldX: at(keysAt, keyLen),
      newX: at(keysAt + keyLen, keyLen),
      newEd: at(keysAt + 2 * keyLen, keyLen),
      newNostr: at(keysAt + 3 * keyLen, keyLen),
      atMs: view.getUint32(0) * 0x100000000 + view.getUint32(4),
      sigOld: at(sigAt, sigLen),
      sigNew: at(sigAt + sigLen, sigLen),
    );
  }

  /// What the signatures cover — with the domain — and, without it, the head
  /// of the encoding.
  static Uint8List _signed(
    Uint8List oldX,
    Uint8List newX,
    Uint8List newEd,
    Uint8List newNostr,
    int atMs, {
    bool withDomain = true,
  }) {
    final time = ByteData(8)
      // Cut in two arithmetically: on the web an int is a double.
      ..setUint32(0, atMs ~/ 0x100000000)
      ..setUint32(4, atMs % 0x100000000);
    return (BytesBuilder(copy: false)
          ..add(withDomain ? utf8.encode(_domain) : const <int>[])
          ..addByte(version)
          ..add(oldX)
          ..add(newX)
          ..add(newEd)
          ..add(newNostr)
          ..add(time.buffer.asUint8List()))
        .takeBytes();
  }
}
