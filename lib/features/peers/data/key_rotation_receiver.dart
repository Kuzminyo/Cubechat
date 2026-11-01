import 'dart:async';
import 'dart:typed_data';

import '../../../core/transport/key_rotation.dart';
import '../../../core/transport/messaging_service.dart';
import '../../../core/util/debug_log.dart';

/// What [KeyRotationReceiver] reads and changes, behind one seam so the rules
/// are tested without the app.
abstract class KeyRotationTarget {
  /// The signing key we hold for the contact [pubkeyHex], or null for
  /// somebody who is not a contact.
  Uint8List? signKeyOf(String pubkeyHex);

  /// The key [oldHex] was already moved to, if it was.
  String? rotatedTo(String oldHex);

  /// Move everything kept under [oldHex] to [newHex] and remember the move.
  Future<void> migrate({
    required String oldHex,
    required String newHex,
    required Uint8List newSignPub,
    required Uint8List newNostr,
  });
}

/// A contact says their account has new keys — [KeyRotation] — and this
/// moves them, by the rules in
/// docs/superpowers/specs/2026-11-01-key-rotation-design.md:
///
///   * believed only when the old key it names is the sender's, signed by the
///     signing key we have on file for them, and countersigned by the new one;
///   * moved once: the same rotation again changes nothing, and a *different*
///     one from the same old key — which is what a thief holding that key
///     would send — is refused, with the contact left where the first one put
///     them and the warning standing;
///   * moved with "verified" dropped, the owner's ruling: the chat follows,
///     the amber "key changed" shows until they check the keys again.
class KeyRotationReceiver {
  KeyRotationReceiver({
    required Stream<ReceivedKeyRotation> inbound,
    required KeyRotationTarget target,
  }) : _target = target {
    _sub = inbound.listen((r) => unawaited(_queue = _queue.then((_) => _receive(r))));
  }

  final KeyRotationTarget _target;
  late final StreamSubscription<ReceivedKeyRotation> _sub;

  /// One at a time, in arrival order: two copies of a rotation racing each
  /// other must not both migrate.
  Future<void> _queue = Future<void>.value();

  /// Settles once every rotation received so far is handled. For tests.
  Future<void> get idle => _queue;

  Future<void> _receive(ReceivedKeyRotation received) async {
    final KeyRotation rotation;
    try {
      rotation = KeyRotation.decode(received.body);
    } on FormatException catch (e) {
      DebugLog.instance.log('KEYS', 'drop key rotation: $e');
      return;
    }
    final senderHex = _hex(received.senderPub);
    if (_hex(rotation.oldX) != senderHex) {
      DebugLog.instance.log('KEYS', 'drop key rotation: names another account');
      return;
    }
    final onFile = _target.signKeyOf(senderHex);
    if (onFile == null) {
      DebugLog.instance.log('KEYS', 'drop key rotation: not a contact');
      return;
    }
    if (!_same(onFile, received.senderEdPub) ||
        !await rotation.verify(onFile)) {
      DebugLog.instance.log('KEYS', 'drop key rotation: signatures do not hold');
      return;
    }
    final newHex = _hex(rotation.newX);
    final already = _target.rotatedTo(senderHex);
    if (already != null) {
      if (already != newHex) {
        DebugLog.instance.log(
          'KEYS',
          'REFUSED a second, different rotation of ${senderHex.substring(0, 8)}'
              ' (to ${newHex.substring(0, 8)}, already at '
              '${already.substring(0, 8)}) — the old key is in two hands',
        );
      }
      return;
    }
    await _target.migrate(
      oldHex: senderHex,
      newHex: newHex,
      newSignPub: rotation.newEd,
      newNostr: rotation.newNostr,
    );
    DebugLog.instance.log(
      'KEYS',
      '${senderHex.substring(0, 8)} moved to new keys '
          '${newHex.substring(0, 8)}; asked to re-verify',
    );
  }

  Future<void> dispose() => _sub.cancel();

  static String _hex(Uint8List b) =>
      b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

  static bool _same(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
