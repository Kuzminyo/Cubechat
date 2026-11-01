import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';
import '../../../core/transport/messaging_service.dart';
import '../../../core/util/debug_log.dart';
import '../../chat/data/messages_controller.dart';
import '../../chat/data/pinned_controller.dart';
import '../../chats/data/archived_chats_controller.dart';
import '../../chats/data/favorites_controller.dart';
import '../../chats/data/hidden_chats_controller.dart';
import '../../chats/data/pinned_chats_controller.dart';
import '../../chats/data/read_markers_controller.dart';
import 'contact_aliases_controller.dart';
import 'contact_tags_controller.dart';
import 'key_rotation_receiver.dart';
import 'known_peers_controller.dart';
import 'removed_contacts_controller.dart';

/// Old key -> the key it was moved to, in the encrypted settings box: the
/// memory that refuses a second, different rotation of the same old key.
const _rotatedKey = 'keys.rotatedTo';

/// Contacts' key rotations, received and acted on — see
/// [KeyRotationReceiver]. Rebuilt with the messaging service and kept alive
/// from `app.dart`.
final keyRotationReceiverProvider = Provider<KeyRotationReceiver>((ref) {
  final messaging = ref.watch(messagingServiceProvider);
  final target = _AppRotationTarget(ref);
  unawaited(target.load());
  final receiver = KeyRotationReceiver(
    inbound: messaging.keyRotations,
    target: target,
  );
  ref.onDispose(() => unawaited(receiver.dispose()));
  return receiver;
});

class _AppRotationTarget implements KeyRotationTarget {
  _AppRotationTarget(this._ref);

  final Ref _ref;
  Map<String, String> _rotated = {};
  late final Future<void> _loaded = _read();

  Future<void> load() => _loaded;

  Future<void> _read() async {
    try {
      final box =
          await hiveCipherProvider.openEncryptedBox<dynamic>(HiveBoxes.settings);
      final raw = box.get(_rotatedKey);
      if (raw is String) {
        _rotated = Map<String, String>.from(jsonDecode(raw) as Map);
      }
    } catch (e) {
      DebugLog.instance.log('KEYS', 'reading past rotations failed: $e');
    }
  }

  @override
  Uint8List? signKeyOf(String pubkeyHex) =>
      _ref.read(knownPeersControllerProvider)[pubkeyHex]?.signPublicKey;

  @override
  String? rotatedTo(String oldHex) => _rotated[oldHex];

  @override
  Future<void> migrate({
    required String oldHex,
    required String newHex,
    required Uint8List newSignPub,
    required Uint8List newNostr,
  }) async {
    await _loaded;
    // Remembered first: whatever fails below, a second rotation of this key
    // must still be refused.
    _rotated = {..._rotated, oldHex: newHex};
    try {
      final box =
          await hiveCipherProvider.openEncryptedBox<dynamic>(HiveBoxes.settings);
      await box.put(_rotatedKey, jsonEncode(_rotated));
    } catch (e) {
      DebugLog.instance.log('KEYS', 'saving the rotation failed: $e');
    }

    final ref = _ref;
    await ref.read(knownPeersControllerProvider.notifier).rekey(
          oldHex,
          newHex,
          signPublicKey: newSignPub,
          nostrPubkey: newNostr,
        );
    await ref.read(messagesControllerProvider.notifier).rekeyChat(oldHex, newHex);

    final reads = ref.read(readMarkersControllerProvider.notifier);
    final readAt = reads.lastReadAt(oldHex);
    if (readAt != null) await reads.markRead(newHex, at: readAt);
    await reads.forget(oldHex);

    final acks = ref.read(ackMarkersControllerProvider.notifier);
    final ackedAt = acks.ackedUpTo(oldHex);
    if (ackedAt != null) await acks.markAcked(newHex, ackedAt);
    await acks.forget(oldHex);

    final aliases = ref.read(contactAliasesControllerProvider.notifier);
    final alias = aliases.forPeer(oldHex);
    if (alias != null) {
      await aliases.setAlias(newHex, alias);
      await aliases.clearAlias(oldHex);
    }

    final tags = ref.read(contactTagsControllerProvider.notifier);
    final tag = tags.tagFor(oldHex);
    if (tag != null) {
      await tags.setTag(newHex, tag);
      await tags.setTag(oldHex, null);
    }

    final pinnedChats = ref.read(pinnedChatsControllerProvider.notifier);
    if (pinnedChats.isPinned(oldHex)) {
      await pinnedChats.pin(newHex);
      await pinnedChats.unpin(oldHex);
    }

    final favorites = ref.read(favoritesControllerProvider.notifier);
    if (favorites.isFavorite(oldHex)) {
      if (!favorites.isFavorite(newHex)) await favorites.toggle(newHex);
      await favorites.forget(oldHex);
    }

    final archived = ref.read(archivedChatsControllerProvider.notifier);
    if (archived.isArchived(oldHex)) {
      await archived.archive(newHex);
      await archived.unarchive(oldHex);
    }

    final hidden = ref.read(hiddenChatsControllerProvider.notifier);
    if (hidden.isHidden(oldHex)) {
      await hidden.hide(newHex);
      await hidden.unhide(oldHex);
    }

    final pins = ref.read(pinnedControllerProvider.notifier);
    final pin = pins.pinnedIn(oldHex);
    if (pin != null) {
      await pins.pin(newHex, pin.wireId, at: pin.pinnedAt);
      await pins.forget(oldHex);
    }

    // The old key will not make a chat again: anything still arriving under
    // it is late mail, or the thief.
    await ref.read(removedContactsControllerProvider.notifier).remember(oldHex);
  }
}
