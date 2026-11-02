import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

import 'x25519_agreement.dart';

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

  static final _x25519 = X25519();

  static const _pairKeyDomain = 'cubechat-radio-pair-v1';
  static const _pairTagDomain = 'cubechat-radio-pair-tag-v1';

  /// The 32-byte key two contacts talk 1:1 over the radio with.
  ///
  /// Static-static X25519 between our identity key pair [mine] (public half
  /// [myPub]) and the contact's identity key [theirPub] - the same statics the
  /// Noise handshakes authenticate, so no new key exists anywhere - then
  /// BLAKE2s over `domain, NUL, shared, lowPub, highPub`, the same shape as
  /// [deriveKey]. The two public keys are sorted, so both phones put the same
  /// bytes in the hash and get the same key; naming them pins the key to this
  /// pair even though the shared secret alone would already.
  ///
  /// Why a shared key at all, and not a frame sealed to the contact: a 1:1
  /// chunk travels as a broadcast exactly like a group's, because a phone that
  /// relays a frame *addressed* to somebody keeps a copy for them in its
  /// store-and-forward cache - and three chunks a second of somebody's voice
  /// pushed out the mail it was carrying for them inside fifteen seconds.
  /// Nothing holds a broadcast. Not forward-secret, as a group is not.
  static Future<Uint8List> derivePairKey({
    required SimpleKeyPair mine,
    required Uint8List myPub,
    required Uint8List theirPub,
  }) async {
    if (myPub.length != 32 || theirPub.length != 32) {
      throw ArgumentError('X25519 public keys must be 32 bytes');
    }
    final shared = await contributorySharedSecret(
      _x25519,
      keyPair: mine,
      remotePublicKey: SimplePublicKey(theirPub, type: KeyPairType.x25519),
    );
    final sharedBytes = await shared.extractBytes();
    final mineFirst = _compare(myPub, theirPub) <= 0;
    final material = <int>[
      ...utf8.encode(_pairKeyDomain),
      0,
      ...sharedBytes,
      ...(mineFirst ? myPub : theirPub),
      ...(mineFirst ? theirPub : myPub),
    ];
    final digest = await _blake.hash(material);
    return Uint8List.fromList(digest.bytes);
  }

  /// Public 8-byte selector for a pair in one hour-long [epoch] (unix millis
  /// ~/ 1 h, the rotating peer id's epoch - `PeerId.epochAt`).
  ///
  /// Rotates, unlike a group's tag: a group is a name that anybody in it may
  /// tell anybody, while a pair tag that never changed would be a label on
  /// two particular people that a listener could follow for as long as they
  /// knew each other. The receiver tries the previous, current and next
  /// epoch, as it does for peer ids.
  static Future<Uint8List> derivePairTag(Uint8List pairKey, int epoch) async {
    final epochBytes = Uint8List(8);
    ByteData.sublistView(epochBytes).setInt64(0, epoch);
    final material = <int>[
      ...utf8.encode(_pairTagDomain),
      ...pairKey,
      ...epochBytes,
    ];
    final digest = await _blake.hash(material);
    return Uint8List.fromList(digest.bytes.sublist(0, tagLen));
  }

  static int _compare(Uint8List a, Uint8List b) {
    for (var i = 0; i < a.length && i < b.length; i++) {
      if (a[i] != b[i]) return a[i] - b[i];
    }
    return a.length - b.length;
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
