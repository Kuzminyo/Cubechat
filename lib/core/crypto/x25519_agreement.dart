import 'package:cryptography/cryptography.dart';

/// X25519 that refuses a key agreement which came out all zeros.
///
/// A public key of small order (the identity, or one of the few points of
/// order 2, 4 or 8) makes the agreement equal zero whatever our private key
/// is, so the "shared" secret is one the sender knows without knowing
/// anything of ours. `package:cryptography`'s pure-Dart X25519 — the one this
/// app runs on every platform — returns that zero without complaint (checked
/// in 2.9.0). Every key fed here comes off the air or out of a relay, from a
/// handshake, an announcement, a manifest or a sealed frame.
///
/// RFC 7748 §6.1 allows the check; Noise §12.1 allows it as long as it is the
/// all-zero output that is refused, which is what this does. bitchat's own
/// review of its Android app flagged the same gap (M1, July 2026).
///
/// Throws [FormatException], the error every decoder here raises on bad remote
/// input, so callers that already drop a malformed frame drop this one too.
Future<SecretKey> contributorySharedSecret(
  X25519 x25519, {
  required KeyPair keyPair,
  required PublicKey remotePublicKey,
}) async {
  final shared = await x25519.sharedSecretKey(
    keyPair: keyPair,
    remotePublicKey: remotePublicKey,
  );
  final bytes = await shared.extractBytes();
  // OR every byte rather than return early: whether the secret is zero is
  // the only thing this may reveal, not where it first differs.
  var acc = 0;
  for (final b in bytes) {
    acc |= b;
  }
  if (acc == 0) {
    throw const FormatException(
      'X25519 agreement is all zeros: low-order public key',
    );
  }
  return SecretKeyData(bytes);
}
