import 'dart:async';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/crypto/identity_service.dart';
import '../core/crypto/prekey_service.dart';
import '../core/notifications/push_registration.dart';
import '../core/transport/chat_session_manager.dart';
import '../core/transport/key_rotation.dart';
import '../core/transport/messaging_service.dart';
import '../core/transport/nostr/nostr_signer.dart';
import '../core/util/debug_log.dart';
import '../features/cube_id/data/cube_id_controller.dart';
import '../features/devices/data/own_devices_controller.dart';

/// How a rotation went: how many contacts it reached before the old keys
/// were destroyed, of how many there are.
typedef KeyRotationResult = ({int sent, int total});

/// Give this account new keys and destroy the old ones
/// (docs/superpowers/specs/2026-11-01-key-rotation-design.md, stage 2).
///
/// The phone only — the owner's ruling: linking goes phone to computer, so a
/// phone that rotated links its computers again, and a computer that rotated
/// could not bring the phone back.
///
/// In this order, because each step needs what the next one destroys:
///   1. new X25519 and Ed25519 keys, the Nostr key derived from the new seed;
///   2. the rotation, signed by the old signing key and the new one, sealed
///      and sent to every contact under the old identity, and waited for
///      (30 s at most) — afterwards nothing this device signs is by the key
///      they have on file;
///   3. every other device of the account told to sign out; one that obeys
///      wipes itself, one that does not holds keys that open nothing new;
///   4. the push registration of the old Nostr key withdrawn;
///   5. the old keys replaced in the secure store, a fresh prekey, and the
///      transport rebuilt — the conversation and the contacts stay.
///
/// Takes [read] and [invalidate] rather than a `WidgetRef`, so a test can run
/// it on a bare container: a widget's `ref.read` and `ref.invalidate` fit.
Future<KeyRotationResult> rotateAccountKeys({
  required T Function<T>(ProviderListenable<T> provider) read,
  required void Function(ProviderOrFamily provider) invalidate,
}) async {
  final ref = (read: read, invalidate: invalidate);
  final old = await ref.read(identityProvider.future);

  final newX = await X25519().newKeyPair();
  final newXPriv = Uint8List.fromList(await newX.extractPrivateKeyBytes());
  final newXPub = Uint8List.fromList((await newX.extractPublicKey()).bytes);
  final newEd = await Ed25519().newKeyPair();
  final newEdSeed = Uint8List.fromList(await newEd.extractPrivateKeyBytes());
  final nostr = await Secp256k1NostrSigner.deriveFromSeed(newEdSeed);

  final rotation = await KeyRotation.sign(
    oldX: old.publicKey,
    oldSign: old.asSignKeyPair(),
    newX: newXPub,
    newSign: newEd,
    newNostr: _unhex(nostr.npubHex),
    atMs: DateTime.now().millisecondsSinceEpoch,
  );

  final messaging = ref.read(messagingServiceProvider);
  final result = await messaging
      .sendKeyRotationToContacts(rotation.encode())
      .timeout(
        const Duration(seconds: 30),
        onTimeout: () => (sent: 0, total: -1),
      );

  try {
    await ref.read(ownDevicesProvider).signOutOthers();
  } catch (e) {
    DebugLog.instance.log('KEYS', 'signing the other devices out failed: $e');
  }

  // The @name, while the key that owns it can still sign: handed to the new
  // Nostr key now, given the new card right after the switch.
  final cubeId = await ref
      .read(cubeIdControllerProvider.notifier)
      .rotateTo(nostr.npubHex);
  DebugLog.instance.log('KEYS', 'name handed over: $cubeId');

  final pushOn = ref.read(pushEnabledProvider);
  if (pushOn) {
    try {
      await ref.read(pushRegistrationProvider).disable();
    } catch (e) {
      DebugLog.instance.log('KEYS', 'withdrawing the old push failed: $e');
    }
  }

  // Sessions and held frames belong to the old key.
  final manager = ref.read(chatSessionManagerProvider.notifier);
  for (final peerId in ref.read(chatSessionManagerProvider).keys.toList()) {
    manager.drop(peerId);
  }
  messaging.clearRelayBuffer();

  await ref.read(prekeyServiceProvider).wipe();
  await ref
      .read(identityServiceProvider)
      .restorePrivateKeys(newXPriv, newEdSeed);
  ref.invalidate(identityProvider);
  ref.invalidate(prekeyServiceProvider);
  ref.invalidate(messagingServiceProvider);
  DebugLog.instance.log('KEYS', 'this account has new keys');

  // The new card, signed by the new key, onto the name it now owns.
  unawaited(ref.read(cubeIdControllerProvider.notifier).maintain());

  if (pushOn) {
    await ref.read(pushEnabledProvider.notifier).set(true);
  }
  return result;
}

Uint8List _unhex(String hex) {
  final out = Uint8List(hex.length ~/ 2);
  for (var i = 0; i < out.length; i++) {
    out[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
  }
  return out;
}
