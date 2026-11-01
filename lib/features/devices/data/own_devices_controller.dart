import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/identity/avatar_controller.dart';
import '../../../core/identity/nickname_controller.dart';
import '../../../core/identity/own_profile_edits.dart';
import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';
import '../../../core/transport/messaging_service.dart';
import '../../../core/util/debug_log.dart';
import '../../channels/data/channel_controller.dart';
import '../../chat/data/messages_controller.dart';
import '../../chat/data/pinned_controller.dart';
import '../../chat/models/message.dart';
import '../../chats/data/read_markers_controller.dart';
import '../../peers/data/known_peers_controller.dart';
import '../../profile/data/relay_settings_controller.dart';
import 'device_identity.dart';
import 'device_sync.dart';
import 'own_devices.dart';
import 'own_profile_sync.dart';

/// This device's id and name. A provider so the wipe can forget them and a
/// test can stand in for the secure store.
final deviceIdentityStoreProvider =
    Provider<DeviceIdentityStore>((_) => SecureDeviceIdentityStore());

const _knownKey = 'devices.known';

/// The devices of this account. Rebuilt with the messaging service — a wipe
/// replaces that, and with it the stream of notices this listens to.
final ownDevicesProvider = ChangeNotifierProvider<OwnDevicesService>((ref) {
  final messaging = ref.watch(messagingServiceProvider);
  final platform = currentDevicePlatform;
  return OwnDevicesService(
    send: (notice) async {
      final delivery = await messaging.sendOwnDeviceNotice(notice);
      DebugLog.instance.log('DEVICES', 'sent ${notice.kind.name}: $delivery');
    },
    inbound: messaging.ownDeviceNotices,
    store: ref.read(deviceIdentityStoreProvider),
    // In the encrypted settings box. It travels with a backup, which is fine:
    // it is the account's list, and the copy's own id is not in it.
    load: () async {
      try {
        final box = await hiveCipherProvider
            .openEncryptedBox<dynamic>(HiveBoxes.settings);
        final raw = box.get(_knownKey);
        if (raw is! String) return const [];
        final list = jsonDecode(raw);
        if (list is! List) return const [];
        return [
          for (final item in list)
            if (OwnDevice.fromJson(item) case final device?) device,
        ];
      } catch (e) {
        DebugLog.instance.log('DEVICES', 'reading the list failed: $e');
        return const [];
      }
    },
    save: (devices) async {
      try {
        final box = await hiveCipherProvider
            .openEncryptedBox<dynamic>(HiveBoxes.settings);
        await box.put(
          _knownKey,
          jsonEncode([for (final d in devices) d.toJson()]),
        );
      } catch (e) {
        DebugLog.instance.log('DEVICES', 'saving the list failed: $e');
      }
    },
    platform: platform,
    defaultName: defaultDeviceName(platform),
  );
});

const _profileAtKey = 'devices.profileAt';

/// The account's nickname and avatar, kept the same on all of its devices —
/// see [OwnProfileSync]. Rebuilt with the messaging service, like
/// [ownDevicesProvider], and kept alive from `app.dart`.
final ownProfileSyncProvider = Provider<OwnProfileSync>((ref) {
  final messaging = ref.watch(messagingServiceProvider);
  final sync = OwnProfileSync(
    send: (notice) async {
      final delivery = await messaging.sendOwnDeviceNotice(notice);
      return !delivery.isNotSent;
    },
    inbound: messaging.ownDeviceNotices,
    deviceId: ref.read(deviceIdentityStoreProvider).id,
    current: () async {
      await ref.read(nicknameControllerProvider.notifier).loaded;
      await ref.read(avatarProvider.notifier).loaded;
      return OwnProfile(
        nickname: ref.read(nicknameControllerProvider),
        avatar: ref.read(avatarProvider),
      );
    },
    apply: (profile) async {
      await ref
          .read(nicknameControllerProvider.notifier)
          .setFromAnotherDevice(profile.nickname);
      final avatar = ref.read(avatarProvider.notifier);
      final picture = profile.avatar;
      if (picture == null) {
        await avatar.clearFromAnotherDevice();
      } else {
        await avatar.setFromAnotherDevice(picture);
      }
    },
    // In the settings box with the name and the picture, so a backup or a
    // desktop sign-in carries the moment along with what it dates.
    loadStamp: () async {
      try {
        final box = await hiveCipherProvider
            .openEncryptedBox<dynamic>(HiveBoxes.settings);
        final raw = box.get(_profileAtKey);
        return raw is int ? raw : 0;
      } catch (e) {
        DebugLog.instance.log('DEVICES', 'reading the profile moment: $e');
        return 0;
      }
    },
    saveStamp: (stamp) async {
      try {
        final box = await hiveCipherProvider
            .openEncryptedBox<dynamic>(HiveBoxes.settings);
        await box.put(_profileAtKey, stamp);
      } catch (e) {
        DebugLog.instance.log('DEVICES', 'saving the profile moment: $e');
      }
    },
  );
  ref.listen<int>(ownProfileEditsProvider, (_, __) {
    unawaited(sync.edited());
  });
  ref.onDispose(sync.dispose);
  unawaited(sync.start());
  return sync;
});

/// The conversation kept one across the devices of this account — see
/// [DeviceSync]. Rebuilt with the messaging service, like
/// [ownDevicesProvider], and kept alive from `app.dart`.
final deviceSyncProvider = Provider<DeviceSync>((ref) {
  final messaging = ref.watch(messagingServiceProvider);
  final sync = DeviceSync(
    inbound: messaging.ownDeviceNotices,
    sent: messaging.sentToPeers,
    heard: messaging.heardOverBluetooth,
    send: (notice) async {
      final delivery = await messaging.sendOwnDeviceNotice(notice);
      return !delivery.isNotSent;
    },
    passOn: (frame) async {
      await messaging.publishToOwnDevices(frame);
    },
    deviceId: ref.read(deviceIdentityStoreProvider).id,
    // Nobody to tell is nothing to send: a phone with no other device pays
    // for none of this.
    othersExist: () => ref.read(ownDevicesProvider).others.isNotEmpty,
    // The owner's ruling: what came over the air reaches the internet only
    // when the relays are on.
    relaysOn: () => ref.read(relaySettingsProvider).enabled,
    target: _AppSyncTarget(ref),
  );
  ref.listen<Map<String, DateTime>>(readMarkersControllerProvider, (
    previous,
    next,
  ) {
    for (final entry in next.entries) {
      final before = previous?[entry.key];
      if (before == null || entry.value.isAfter(before)) {
        unawaited(sync.noteRead(entry.key, entry.value));
      }
    }
  });
  ref.onDispose(() => unawaited(sync.dispose()));
  return sync;
});

/// [DeviceSyncTarget] on the app's own controllers — the same calls the
/// device makes when the user does these things here, minus the send.
class _AppSyncTarget implements DeviceSyncTarget {
  _AppSyncTarget(this._ref);

  final Ref _ref;

  MessagesController get _messages =>
      _ref.read(messagesControllerProvider.notifier);

  @override
  bool hasChat(String chatId) => chatId.startsWith('#')
      ? _ref.read(channelControllerProvider.notifier).byName(chatId) != null
      : _ref.read(knownPeersControllerProvider)[chatId] != null;

  @override
  void fileMine(String chatId, Message message) =>
      _messages.append(chatId, message);

  @override
  void editMine(String chatId, String wireId, String text) =>
      _messages.editMine(chatId, wireId, text);

  @override
  void deleteMine(String chatId, String wireId) =>
      _messages.deleteMineByWireId(chatId, wireId);

  @override
  void reactMine(
    String chatId,
    String wireId,
    String emoji, {
    required bool add,
  }) =>
      _messages.applyReaction(
        chatId,
        targetWireId: wireId,
        emoji: emoji,
        reactorId: 'me',
        add: add,
      );

  @override
  Future<void> pin(String chatId, String wireId, {required bool pinned}) {
    final pins = _ref.read(pinnedControllerProvider.notifier);
    return pinned ? pins.pin(chatId, wireId) : pins.unpin(chatId, wireId: wireId);
  }

  @override
  Future<void> clearUpTo(String chatId, DateTime upTo) =>
      _messages.clearForChatUpTo(chatId, upTo);

  @override
  Future<void> markRead(String chatId, DateTime at) =>
      _ref.read(readMarkersControllerProvider.notifier).markRead(chatId, at: at);

  @override
  SyncedContact? contactFor(String chatId) {
    final peer = _ref.read(knownPeersControllerProvider)[chatId];
    final sign = peer?.signPublicKey;
    if (peer == null || sign == null || sign.length != 32) return null;
    final pub = _hexBytes(peer.pubkeyHex);
    if (pub == null) return null;
    return SyncedContact(
      pubkey: pub,
      signPub: sign,
      prekey: peer.signedPrekeyPub?.length == 32 ? peer.signedPrekeyPub : null,
      nostr: peer.nostrPubkey?.length == 32 ? peer.nostrPubkey : null,
      name: peer.displayName,
    );
  }

  @override
  void addContact(SyncedContact contact) {
    final hex = _hex(contact.pubkey);
    _ref.read(knownPeersControllerProvider.notifier).upsert(
          pubkeyHex: hex,
          displayName: contact.name,
          signPublicKey: contact.signPub,
          signedPrekeyPub: contact.prekey,
          nostrPubkey: contact.nostr,
        );
  }

  static String _hex(Uint8List b) =>
      b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

  static Uint8List? _hexBytes(String hex) {
    if (hex.length != 64) return null;
    final out = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      final v = int.tryParse(hex.substring(i * 2, i * 2 + 2), radix: 16);
      if (v == null) return null;
      out[i] = v;
    }
    return out;
  }
}
