import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/app/bindings.dart';
import 'package:cubechat/core/crypto/channel_crypto.dart';
import 'package:cubechat/core/crypto/identity_service.dart';
import 'package:cubechat/core/crypto/sealed_box.dart';
import 'package:cubechat/core/crypto/signed_payload.dart';
import 'package:cubechat/core/models/channel.dart';
import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/frame.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/peer_id.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hive_settle.dart';

/// Another phone: its own X25519 identity and Ed25519 signing key.
class TestPhone {
  TestPhone._(this.keyPair, this.pub, this.signKeyPair, this.signPub);

  final SimpleKeyPair keyPair;
  final Uint8List pub;
  final SimpleKeyPairData signKeyPair;
  final Uint8List signPub;

  String get pubHex => hexOf(pub);

  /// The 16-hex fingerprint a room's roster and its posts call this phone.
  String get authorId => hexOf(signPub).substring(0, 16);

  static Future<TestPhone> make() async {
    final x = await X25519().newKeyPair();
    final ed = await Ed25519().newKeyPair();
    return TestPhone._(
      x,
      Uint8List.fromList((await x.extractPublicKey()).bytes),
      await ed.extract(),
      Uint8List.fromList((await ed.extractPublicKey()).bytes),
    );
  }
}

String hexOf(Uint8List b) =>
    b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

/// No relays configured, so nothing reaches the internet.
class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// One phone's transport with the app's own bindings, a contact on file, and
/// frames from that contact built the way its phone would build them — signed,
/// sealed, enveloped — and handed in as if a Bluetooth link had delivered them.
///
/// This is what pins inbound behaviour from the outside: a test feeds bytes in
/// and reads controller state back, so it does not care where in the code the
/// payload is handled.
class InboundHarness {
  InboundHarness._(this.container, this.service, this.peer, this.myPub);

  final ProviderContainer container;
  final MessagingService service;
  final TestPhone peer;
  final Uint8List myPub;

  /// The BLE link the frames "arrive" on.
  static const linkId = 'link-a';

  static Future<InboundHarness> start({
    List<Override> overrides = const [],
  }) async {
    final container = ProviderContainer(
      overrides: [
        ...appBindings,
        relaySettingsProvider.overrideWith(_Offline.new),
        messagingServiceProvider.overrideWith((ref) {
          final service = MessagingService(ref);
          ref.onDispose(() => unawaited(service.dispose()));
          return service;
        }),
        ...overrides,
      ],
    );
    await container.read(messagesControllerProvider.notifier).loaded;
    final peer = await TestPhone.make();
    container.read(knownPeersControllerProvider.notifier).upsert(
          pubkeyHex: peer.pubHex,
          displayName: 'Alice',
          signPublicKey: peer.signPub,
        );
    final me = await container.read(identityProvider.future);
    return InboundHarness._(
      container,
      container.read(messagingServiceProvider),
      peer,
      Uint8List.fromList(me.publicKey),
    );
  }

  Future<void> dispose() async {
    container.dispose();
    await settleBackgroundStorage();
  }

  /// A 1:1 frame from [peer] carrying [type]/[body]. Returns its msgId, which
  /// is what a later edit, delete, pin or reaction names as its target.
  Future<Uint8List> direct(
    InnerPayloadType type,
    Uint8List body, {
    TestPhone? from,
  }) async {
    final sender = from ?? peer;
    final epoch = PeerId.epochAt(DateTime.now());
    final origin = await PeerId.derive(sender.pub, epoch);
    final dest = await PeerId.derive(myPub, epoch);
    final msgId = TransportEnvelope.newMsgId(initialTtl: 7);
    final signed = await SignedPayload.wrap(
      inner: packInnerPayload(type, body),
      context: SignedPayload.contextBytes(
        originPubkeyHash: origin,
        destPubkeyHash: dest,
        msgId: msgId,
      ),
      signKeyPair: sender.signKeyPair,
      senderEdPub: sender.signPub,
    );
    final sealed = await SealedBox.seal(signed, myPub);
    final env = TransportEnvelope(
      originPubkeyHash: origin,
      destPubkeyHash: dest,
      msgId: msgId,
      ttl: 7,
      body: Uint8List.fromList([0x01, ...sealed]),
    );
    await service.debugReceiveFrame(
      linkId,
      Frame(type: FrameType.transport, payload: env.encode()).encode(),
    );
    await drainEventQueue();
    return msgId;
  }

  /// A room frame from [peer] in [channel]. Returns its msgId.
  Future<Uint8List> room(
    Channel channel,
    InnerPayloadType type,
    Uint8List body, {
    TestPhone? from,
  }) async {
    final sender = from ?? peer;
    final epoch = PeerId.epochAt(DateTime.now());
    final origin = await PeerId.derive(sender.pub, epoch);
    final dest = Uint8List(TransportEnvelope.hashLen);
    final msgId = TransportEnvelope.newMsgId(initialTtl: 7);
    final signed = await SignedPayload.wrap(
      inner: packInnerPayload(type, body),
      context: SignedPayload.contextBytes(
        originPubkeyHash: origin,
        destPubkeyHash: dest,
        msgId: msgId,
      ),
      signKeyPair: sender.signKeyPair,
      senderEdPub: sender.signPub,
    );
    final blob = await ChannelCrypto.seal(channel.key, signed);
    final env = TransportEnvelope(
      originPubkeyHash: origin,
      destPubkeyHash: dest,
      msgId: msgId,
      // 0: nothing to forward, so the test sees only what this phone does
      // with the frame for itself.
      ttl: 0,
      body: Uint8List.fromList([0x03, ...channel.tag, ...blob]),
    );
    await service.debugReceiveFrame(
      linkId,
      Frame(type: FrameType.transport, payload: env.encode()).encode(),
    );
    await drainEventQueue();
    return msgId;
  }
}

/// The padded UTF-8 body a text payload carries.
Uint8List textBody(String text) =>
    padTextPayload(Uint8List.fromList(utf8.encode(text)));

/// A fresh temp directory for Hive, and its teardown.
Future<Directory> initTestHive(String prefix) async {
  // The notification path reads the locale, which reads preferences.
  SharedPreferences.setMockInitialValues({});
  final dir = await Directory.systemTemp.createTemp(prefix);
  Hive.init(dir.path);
  return dir;
}

Future<void> closeTestHive(Directory dir) async {
  await settleBackgroundStorage();
  try {
    await Hive.close();
  } on FileSystemException {
    // The service closes its own boxes on dispose, unawaited.
  }
  try {
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  } on FileSystemException {
    // A just-closed box can be held briefly.
  }
}

/// Lets the microtasks and zero-delay timers a frame set off run out.
/// Not `pumpEventQueue`, which `flutter_test` exports under the same name.
Future<void> drainEventQueue({int times = 20}) async {
  for (var i = 0; i < times; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}
