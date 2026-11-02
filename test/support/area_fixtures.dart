import 'dart:typed_data';

import 'package:cubechat/core/crypto/secp256k1.dart';
import 'package:cubechat/core/transport/nostr/nostr_event.dart';
import 'package:cubechat/core/transport/nostr/nostr_pow.dart';
import 'package:cubechat/core/transport/nostr/nostr_signer.dart';
import 'package:cubechat/features/area/domain/area_event.dart';

/// A signer from a fixed seed, so a test's keys are the same every run.
Future<Secp256k1NostrSigner> areaTestSigner(int n) =>
    Secp256k1NostrSigner.deriveFromSeed(
      Uint8List.fromList(List<int>.generate(32, (i) => (i * 7 + n) & 0xff)),
    );

Uint8List _unhex(String s) => Uint8List.fromList([
      for (var i = 0; i < s.length; i += 2)
        int.parse(s.substring(i, i + 2), radix: 16),
    ]);

/// The real BIP-340 check, on this isolate — what [SignatureWorker] does
/// elsewhere.
Future<bool> areaRealSignatureCheck(NostrEvent e) => Secp256k1.verify(
      publicKey: _unhex(e.pubkey),
      message: _unhex(e.id!),
      signature: _unhex(e.sig!),
    );

/// Mines and signs [unsigned] the way the app does.
Future<NostrEvent> areaSign(
  Secp256k1NostrSigner signer,
  NostrEvent unsigned,
) async {
  final bits = areaPowBits(unsigned.kind);
  final mined = bits == 0 ? unsigned : mineNonce(unsigned, bits);
  return signer.sign(mined);
}

Future<NostrEvent> areaSignedMessage(
  Secp256k1NostrSigner signer, {
  required DateTime now,
  String g = 'u8vx',
  String text = 'привіт',
  String? cell,
  String? name,
}) =>
    areaSign(
      signer,
      areaMessageEvent(
        pubkey: signer.npubHex,
        g: g,
        text: text,
        cell: cell,
        name: name,
        now: now,
      ),
    );
