import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Symmetric crypto for a walkie-talkie group.
///
/// Built like `ChannelCrypto` - one 32-byte key from (name, password), an
/// 8-byte one-way tag to pick the group without trial decryption, and
/// ChaCha20-Poly1305 over the payload - but on its own domains, so that a
/// radio group and a text channel typed with the same name and password never
/// share a key. That is the point of the separate class: a member of `#patrol`
/// the text channel must not be able to listen to `#patrol` the radio group,
/// nor the other way round, and a tag seen on the air must not name a text
/// channel.
///
/// [deriveKey] takes the name **already normalised**, exactly as
/// `ChannelCrypto.deriveKey` does; the caller runs `normalizeChannelName`
/// first (one function for both, so "#Patrol " and "patrol" are the same
/// group). Doing it in here would hide a second normalisation rule inside the
/// crypto, where a change to it would silently change every key.
///
/// Not forward-secret, for the same reason a channel is not: a shared
/// symmetric key cannot be ratcheted without a group key-agreement protocol.
/// Voice that is gone 300 ms later has little to protect in hindsight.
class RadioCrypto {
  RadioCrypto._();

  static const int keyLen = 32;
  static const int tagLen = 8;
  static const int nonceLen = 12;
  static const int macLen = 16;

  static final _aead = Chacha20.poly1305Aead();
  static final _blake = Blake2s();

  static const _keyDomain = 'cubechat-radio-key-v1';
  static const _tagDomain = 'cubechat-radio-tag-v1';

  /// The 32-byte group key from an already-normalised [name] and a (possibly
  /// empty) [password]. Same material layout as the channel key - domain, NUL,
  /// name, NUL, password - with the radio domain.
  static Future<Uint8List> deriveKey(String name, String password) async {
    final material = <int>[
      ...utf8.encode(_keyDomain),
      0,
      ...utf8.encode(name),
      0,
      ...utf8.encode(password),
    ];
    final digest = await _blake.hash(material);
    return Uint8List.fromList(digest.bytes);
  }

  /// Public 8-byte selector for a group, one-way from its [key].
  static Future<Uint8List> deriveTag(Uint8List key) async {
    final material = <int>[...utf8.encode(_tagDomain), ...key];
    final digest = await _blake.hash(material);
    return Uint8List.fromList(digest.bytes.sublist(0, tagLen));
  }

  /// Encrypt [plain] under [key]; returns `[nonce:12][ciphertext][mac:16]`.
  ///
  /// The framing is the same as a channel's by design but written out here on
  /// purpose: it is deliberately independent of `ChannelCrypto`, so changing
  /// one can never change what the other puts on the wire.
  static Future<Uint8List> seal(Uint8List key, Uint8List plain) async {
    final nonce = _aead.newNonce();
    final box = await _aead.encrypt(
      plain,
      secretKey: SecretKey(key),
      nonce: nonce,
    );
    final out = Uint8List(nonceLen + box.cipherText.length + macLen);
    var c = 0;
    out.setRange(c, c += nonceLen, nonce);
    out.setRange(c, c += box.cipherText.length, box.cipherText);
    out.setRange(c, out.length, box.mac.bytes);
    return out;
  }

  /// Decrypt a `[nonce][ciphertext][mac]` [blob]. Throws on a wrong key, on
  /// tampering, and (as a [FormatException]) on a blob too short to hold a
  /// nonce and a mac.
  static Future<Uint8List> open(Uint8List key, Uint8List blob) async {
    if (blob.length < nonceLen + macLen) {
      throw const FormatException('radio blob shorter than nonce + mac');
    }
    final nonce = blob.sublist(0, nonceLen);
    final ctEnd = blob.length - macLen;
    final clear = await _aead.decrypt(
      SecretBox(
        blob.sublist(nonceLen, ctEnd),
        nonce: nonce,
        mac: Mac(blob.sublist(ctEnd)),
      ),
      secretKey: SecretKey(key),
    );
    return Uint8List.fromList(clear);
  }
}
