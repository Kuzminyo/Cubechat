import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import '../../../core/transport/envelope.dart';
import '../../../core/transport/inner_payload.dart';
import '../../../core/transport/messaging_service.dart';
import '../../../core/transport/own_device_notice.dart';
import '../../../core/util/debug_log.dart';
import '../../chat/models/message.dart';

/// A contact's keys, as one device of an account tells another — see
/// [OwnDeviceKind.contact].
class SyncedContact {
  const SyncedContact({
    required this.pubkey,
    required this.signPub,
    required this.name,
    this.prekey,
    this.nostr,
  });

  final Uint8List pubkey;
  final Uint8List signPub;
  final Uint8List? prekey;
  final Uint8List? nostr;
  final String name;
}

/// What [DeviceSync] does to this device's own state. One method per thing a
/// mirror can say, so the sync logic can be driven without the app.
abstract class DeviceSyncTarget {
  /// A chat this device can file into: a known contact, or a channel it is in.
  bool hasChat(String chatId);

  void fileMine(String chatId, Message message);
  void editMine(String chatId, String wireId, String text);
  void deleteMine(String chatId, String wireId);
  void reactMine(String chatId, String wireId, String emoji, {required bool add});
  Future<void> pin(String chatId, String wireId, {required bool pinned});
  Future<void> clearUpTo(String chatId, DateTime upTo);
  Future<void> markRead(String chatId, DateTime at);

  /// The keys of [chatId], to tell the other devices about — null for a
  /// channel, or a contact whose signing key is not on file yet.
  SyncedContact? contactFor(String chatId);
  void addContact(SyncedContact contact);
}

/// Keeps the conversation one across the devices of an account
/// (`docs/superpowers/specs/2026-11-01-device-sync-design.md`).
///
/// Three roads, all through the relay to our own key:
///   * what this device sends a contact goes to the others as a
///     [OwnDeviceKind.mirror], which they file as their own outgoing;
///   * a chat read here goes as [OwnDeviceKind.read];
///   * a frame heard over Bluetooth alone is published again, as it is, when
///     relays are on — the others open it with their copy of our key.
///
/// Before the first mirror into a contact's chat in a run, that contact's keys
/// go as [OwnDeviceKind.contact], so the other device has somewhere to file
/// it. A mirror that still arrives first is held for [holdFor].
class DeviceSync {
  DeviceSync({
    required Stream<OwnDeviceNotice> inbound,
    required Stream<SentToPeer> sent,
    required Stream<Uint8List> heard,
    required Future<bool> Function(OwnDeviceNotice notice) send,
    required Future<void> Function(Uint8List frame) passOn,
    required Future<Uint8List> Function() deviceId,
    required bool Function() othersExist,
    required bool Function() relaysOn,
    required DeviceSyncTarget target,
    DateTime Function()? clock,
  })  : _send = send,
        _passOn = passOn,
        _othersExist = othersExist,
        _relaysOn = relaysOn,
        _target = target,
        _clock = clock ?? DateTime.now {
    _ready = deviceId().then((id) => _myId = id);
    _subs = [
      inbound.listen((n) => unawaited(_receive(n))),
      sent.listen((s) => unawaited(_mirror(s))),
      heard.listen(_heard),
    ];
  }

  final Future<bool> Function(OwnDeviceNotice notice) _send;
  final Future<void> Function(Uint8List frame) _passOn;
  final bool Function() _othersExist;
  final bool Function() _relaysOn;
  final DeviceSyncTarget _target;
  final DateTime Function() _clock;

  /// How long a mirror waits for the contact it belongs to.
  static const Duration holdFor = Duration(minutes: 10);

  /// Held mirrors, at most, across all chats: a bound on what a burst for
  /// chats this device will never know can make it keep.
  static const int maxHeld = 200;

  late final Future<void> _ready;
  Uint8List? _myId;
  late final List<StreamSubscription<Object?>> _subs;
  bool _disposed = false;

  /// Chats whose contact this run has already told the others about.
  final _announced = <String>{};

  /// Mirrors for chats this device does not know yet, oldest first.
  final _held = <(OwnDeviceNotice, DateTime)>[];

  /// True while a read from another device is being applied, so the marker
  /// it moves is not sent straight back.
  bool _applyingRead = false;

  /// A chat was read on this device up to [at]. Called by the provider on
  /// every forward move of a read marker.
  Future<void> noteRead(String chatId, DateTime at) async {
    if (_disposed || _applyingRead || !_othersExist()) return;
    await _ready;
    final id = _myId;
    if (id == null) return;
    await _send(
      OwnDeviceNotice.read(
        deviceId: id,
        sentAtMs: _clock().millisecondsSinceEpoch,
        chatId: chatId,
        upToMs: at.millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> dispose() async {
    _disposed = true;
    for (final s in _subs) {
      await s.cancel();
    }
  }

  // ------------------------------------------------------------- outgoing

  Future<void> _mirror(SentToPeer sent) async {
    if (_disposed || !_othersExist()) return;
    await _ready;
    final id = _myId;
    if (id == null) return;
    final now = _clock().millisecondsSinceEpoch;
    if (!sent.chatId.startsWith('#') && _announced.add(sent.chatId)) {
      final contact = _target.contactFor(sent.chatId);
      if (contact != null) {
        await _send(
          OwnDeviceNotice.contact(
            deviceId: id,
            sentAtMs: now,
            pubkey: contact.pubkey,
            signPub: contact.signPub,
            prekey: contact.prekey,
            nostr: contact.nostr,
            name: contact.name,
          ),
        );
      }
    }
    final OwnDeviceNotice notice;
    try {
      notice = OwnDeviceNotice.mirror(
        deviceId: id,
        sentAtMs: sent.at.millisecondsSinceEpoch,
        chatId: sent.chatId,
        innerType: sent.type.tag,
        msgId: sent.msgId,
        inner: sent.body,
      );
      // Encoded here so a payload past the cap fails on this device, quietly,
      // rather than in the send.
      notice.encode();
    } on FormatException catch (e) {
      DebugLog.instance.log('SYNC', 'not mirrored (${sent.type.name}): $e');
      return;
    }
    await _send(notice);
  }

  void _heard(Uint8List frame) {
    if (_disposed || !_relaysOn() || !_othersExist()) return;
    unawaited(_passOn(frame));
  }

  // ------------------------------------------------------------- incoming

  Future<void> _receive(OwnDeviceNotice notice) async {
    if (_disposed) return;
    switch (notice.kind) {
      case OwnDeviceKind.mirror:
      case OwnDeviceKind.read:
      case OwnDeviceKind.contact:
        break;
      default:
        return; // the device list's and the profile's, not ours
    }
    await _ready;
    final id = _myId;
    if (id != null && _sameBytes(notice.deviceId, id)) return; // our own echo
    switch (notice.kind) {
      case OwnDeviceKind.mirror:
        final chat = notice.chatId!;
        if (!_target.hasChat(chat)) {
          _hold(notice);
          return;
        }
        await _apply(notice);
      case OwnDeviceKind.read:
        _applyingRead = true;
        try {
          await _target.markRead(
            notice.chatId!,
            DateTime.fromMillisecondsSinceEpoch(notice.upToMs),
          );
        } finally {
          _applyingRead = false;
        }
      case OwnDeviceKind.contact:
        final contact = SyncedContact(
          pubkey: notice.contactPub!,
          signPub: notice.contactSignPub!,
          prekey: notice.contactPrekey,
          nostr: notice.contactNostr,
          name: notice.name ?? '',
        );
        _target.addContact(contact);
        await _releaseHeld();
      default:
        break;
    }
  }

  void _hold(OwnDeviceNotice notice) {
    _expireHeld();
    if (_held.length >= maxHeld) _held.removeAt(0);
    _held.add((notice, _clock()));
  }

  void _expireHeld() {
    final cutoff = _clock().subtract(holdFor);
    final before = _held.length;
    _held.removeWhere((h) => h.$2.isBefore(cutoff));
    final dropped = before - _held.length;
    if (dropped > 0) {
      DebugLog.instance.log(
        'SYNC',
        'dropped $dropped mirror(s) for chats this device never learned',
      );
    }
  }

  Future<void> _releaseHeld() async {
    _expireHeld();
    final ready = [
      for (final h in _held)
        if (_target.hasChat(h.$1.chatId!)) h,
    ];
    for (final h in ready) {
      _held.remove(h);
      await _apply(h.$1);
    }
  }

  /// File one mirror as this device's own outgoing. Malformed bodies are
  /// dropped with a line: they came from our own key, so a bad one is a bug
  /// on the other device, not an attack, and worth seeing in the log.
  Future<void> _apply(OwnDeviceNotice notice) async {
    final chat = notice.chatId!;
    final type = InnerPayloadType.fromByte(notice.innerType);
    final body = notice.inner!;
    final sentAt = DateTime.fromMillisecondsSinceEpoch(notice.sentAtMs);
    try {
      switch (type) {
        case InnerPayloadType.text:
          _target.fileMine(
            chat,
            _mine(
              chat,
              utf8.decode(unpadTextPayload(body), allowMalformed: true),
              sentAt,
              notice.msgId!,
            ),
          );
        case InnerPayloadType.textReply:
          final reply = unpackTextReply(body);
          _target.fileMine(
            chat,
            _mine(
              chat,
              utf8.decode(
                unpadTextPayload(reply.paddedText),
                allowMalformed: true,
              ),
              sentAt,
              notice.msgId!,
              replyTo: TransportEnvelope.hashHex(reply.targetMsgId),
            ),
          );
        case InnerPayloadType.edit:
          final edit = MessageEdit.decode(body);
          _target.editMine(
            chat,
            TransportEnvelope.hashHex(edit.targetMsgId),
            edit.text,
          );
        case InnerPayloadType.delete:
          final delete = MessageDelete.decode(body);
          _target.deleteMine(
            chat,
            TransportEnvelope.hashHex(delete.targetMsgId),
          );
        case InnerPayloadType.reaction:
          final reaction = Reaction.decode(body);
          _target.reactMine(
            chat,
            TransportEnvelope.hashHex(reaction.targetMsgId),
            reaction.emoji,
            add: reaction.op == ReactionOp.add,
          );
        case InnerPayloadType.pin:
          final pin = MessagePin.decode(body);
          await _target.pin(
            chat,
            TransportEnvelope.hashHex(pin.targetMsgId),
            pinned: pin.op == PinOp.pin,
          );
        case InnerPayloadType.conversationClear:
          final now = _clock();
          await _target.clearUpTo(chat, sentAt.isAfter(now) ? now : sentAt);
        default:
          DebugLog.instance.log(
            'SYNC',
            'mirror of 0x${notice.innerType.toRadixString(16)} not filed',
          );
      }
    } on FormatException catch (e) {
      DebugLog.instance.log('SYNC', 'malformed mirror dropped: $e');
    }
  }

  static Message _mine(
    String chat,
    String text,
    DateTime sentAt,
    Uint8List msgId, {
    String? replyTo,
  }) =>
      Message(
        id: 'm${sentAt.microsecondsSinceEpoch}',
        chatId: chat,
        text: text,
        sentAt: sentAt,
        isMine: true,
        // Sent by the other device; whether it arrived is that device's to
        // know. Delivered is the honest floor: the contact's read receipt,
        // which reaches every device of ours, moves it on.
        status: MessageStatus.delivered,
        wireId: TransportEnvelope.hashHex(msgId),
        replyToWireId: replyTo,
      );

  static bool _sameBytes(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
