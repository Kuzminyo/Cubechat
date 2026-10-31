import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/crypto/radio_crypto.dart';
import 'package:cubechat/core/transport/envelope.dart';
import 'package:cubechat/core/transport/frame.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/nostr/radio_relay_link.dart';
import 'package:cubechat/core/transport/peer_id.dart';
import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:cubechat/features/radio/data/radio_inbound.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// Just enough of strfry for an ephemeral kind: each socket's REQ says which
/// `#y` tags it wants, and every EVENT is handed at once to every socket that
/// wants its tag — the sender's too, as a real relay does — and stored
/// nowhere.
class _RadioRelay {
  _RadioRelay._(this._server);

  final HttpServer _server;
  final Map<WebSocket, Set<String>> _wants = {};
  final List<Map<String, dynamic>> events = [];
  int connections = 0;

  String get url => 'ws://localhost:${_server.port}';

  static Future<_RadioRelay> start() async {
    final server = await HttpServer.bind('localhost', 0);
    final relay = _RadioRelay._(server);
    server.listen((req) async {
      final ws = await WebSocketTransformer.upgrade(req);
      relay.connections++;
      relay._wants[ws] = {};
      ws.listen(
        (data) {
          final msg = jsonDecode(data as String) as List<dynamic>;
          switch (msg[0]) {
            case 'REQ':
              final filter = msg[2] as Map<String, dynamic>;
              relay._wants[ws] =
                  (filter['#y'] as List<dynamic>).cast<String>().toSet();
            case 'EVENT':
              final event = (msg[1] as Map).cast<String, dynamic>();
              relay.events.add(event);
              ws.add(jsonEncode(['OK', event['id'], true, '']));
              final tag = ((event['tags'] as List<dynamic>).first as List)[1];
              for (final MapEntry(key: other, value: tags)
                  in relay._wants.entries) {
                if (tags.contains(tag)) {
                  other.add(jsonEncode(['EVENT', 'radio', event]));
                }
              }
          }
        },
        onDone: () => relay._wants.remove(ws),
      );
    });
    return relay;
  }

  /// Sockets whose REQ has arrived — not merely connected. Counting a socket
  /// from its upgrade let a test publish before the listener had subscribed,
  /// which the CI runner was slow enough to hit (2026-10-31).
  int get listening => _wants.values.where((t) => t.isNotEmpty).length;

  Future<void> stop() => _server.close(force: true);
}

Future<void> _until(bool Function() check, {required String reason}) async {
  final deadline = DateTime.now().add(const Duration(seconds: 5));
  while (!check()) {
    if (DateTime.now().isAfter(deadline)) fail('timed out waiting for $reason');
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
}

Uint8List _bytes(int n, int fill) =>
    Uint8List.fromList(List<int>.filled(n, fill));

RadioChunk _chunk(int seq) => RadioChunk(
      transmissionId: Uint8List.fromList(List<int>.generate(16, (i) => i)),
      seq: seq,
      isLast: false,
      startedAtMs: DateTime.now().millisecondsSinceEpoch,
      frames: [_bytes(20, seq & 0xFF)],
    );

String _hex(Uint8List b) =>
    b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RadioRelayCodec', () {
    test('round-trips one to eight frames', () {
      for (final n in [1, 3, 8]) {
        final frames = [for (var i = 0; i < n; i++) _bytes(100 + i, i)];
        final back = RadioRelayCodec.decode(RadioRelayCodec.encode(frames));
        expect(back, hasLength(n));
        for (var i = 0; i < n; i++) {
          expect(back[i], frames[i]);
        }
      }
    });

    test('refuses what it did not write', () {
      final good = RadioRelayCodec.encode([_bytes(10, 1), _bytes(10, 2)]);
      final raw = base64Url.decode(
        base64Url.normalize(good.substring(RadioRelayCodec.scheme.length)),
      );
      String wrap(List<int> b) =>
          '${RadioRelayCodec.scheme}${base64Url.encode(b)}';

      void refused(String content, String why) => expect(
            () => RadioRelayCodec.decode(content),
            throwsFormatException,
            reason: why,
          );

      refused('cc1:${good.substring(4)}', 'a mail frame is not a radio batch');
      refused('cr1:***', 'not base64url');
      refused(wrap([0]), 'zero frames');
      refused(wrap([9, 0, 1, 0]), 'more frames than are ever sent');
      refused(wrap(raw.sublist(0, raw.length - 1)), 'cut short');
      refused(wrap([...raw, 0]), 'trailing byte');
      refused(wrap([1, 0, 0]), 'an empty frame');
      expect(
        () => RadioRelayCodec.decode('cr1:${'A' * 30000}'),
        throwsFormatException,
        reason: 'larger than any batch',
      );
    });
  });

  group('RadioRelayLink', () {
    late _RadioRelay relay;

    setUp(() async => relay = await _RadioRelay.start());
    tearDown(() => relay.stop());

    test('three chunks go as one event and arrive in order, not back to us',
        () async {
      final heardA = <Uint8List>[];
      final heardB = <Uint8List>[];
      final a = RadioRelayLink(url: Uri.parse(relay.url), onFrame: heardA.add);
      final b = RadioRelayLink(url: Uri.parse(relay.url), onFrame: heardB.add);
      addTearDown(a.dispose);
      addTearDown(b.dispose);
      a.setTags({'aa' * 8});
      b.setTags({'aa' * 8});
      await _until(() => a.connected && b.connected, reason: 'both up');
      await _until(() => relay.listening == 2, reason: 'both subscribed');

      for (var i = 0; i < 3; i++) {
        expect(a.publish('aa' * 8, _bytes(50, i)), isTrue);
      }
      await _until(() => heardB.length == 3, reason: 'three chunks at b');
      expect(relay.events, hasLength(1), reason: 'one signature for three');
      expect([for (final f in heardB) f.first], [0, 1, 2]);
      expect(heardA, isEmpty, reason: 'our own voice is not played to us');
      expect(relay.events.single['tags'], [
        ['y', 'aa' * 8],
      ]);
      expect(
        (relay.events.single['tags'] as List).any((t) => (t as List)[0] == 'p'),
        isFalse,
        reason: 'nobody named as the recipient',
      );
    });

    test('a lone chunk goes after the batch wait', () async {
      final heard = <Uint8List>[];
      final a = RadioRelayLink(url: Uri.parse(relay.url), onFrame: (_) {});
      final b = RadioRelayLink(url: Uri.parse(relay.url), onFrame: heard.add);
      addTearDown(a.dispose);
      addTearDown(b.dispose);
      a.setTags({'bb' * 8});
      b.setTags({'bb' * 8});
      await _until(() => relay.listening == 2, reason: 'both subscribed');

      final sw = Stopwatch()..start();
      a.publish('bb' * 8, _bytes(10, 7));
      await _until(() => heard.length == 1, reason: 'the lone chunk');
      expect(
        sw.elapsed,
        greaterThanOrEqualTo(
          RadioRelayLink.batchWait - const Duration(milliseconds: 50),
        ),
      );
    });

    test('a tag not tuned is neither sent nor heard, and empty closes',
        () async {
      final heard = <Uint8List>[];
      final a = RadioRelayLink(url: Uri.parse(relay.url), onFrame: (_) {});
      final b = RadioRelayLink(url: Uri.parse(relay.url), onFrame: heard.add);
      addTearDown(a.dispose);
      addTearDown(b.dispose);
      a.setTags({'cc' * 8, 'dd' * 8});
      b.setTags({'dd' * 8});
      await _until(() => relay.listening == 2, reason: 'both subscribed');

      expect(a.publish('ee' * 8, _bytes(10, 1)), isFalse);
      for (var i = 0; i < 3; i++) {
        a.publish('cc' * 8, _bytes(10, i));
      }
      await _until(() => relay.events.length == 1, reason: 'sent');
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(heard, isEmpty, reason: 'b is tuned to another tag');

      b.setTags(const {});
      expect(b.connected, isFalse);
      await _until(() => relay.listening == 1, reason: 'b let go');
    });

    test('a chunk with the socket down is dropped, not queued', () {
      final a = RadioRelayLink(url: Uri.parse(relay.url), onFrame: (_) {});
      addTearDown(a.dispose);
      a.setTags({'aa' * 8});
      expect(a.publish('aa' * 8, _bytes(10, 1)), isFalse);
    });
  });

  group('MessagingService over the radio relay', () {
    late Directory tempDir;
    late _RadioRelay relay;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('cubechat_radio_net_');
      Hive.init(tempDir.path);
      relay = await _RadioRelay.start();
    });

    tearDown(() async {
      await relay.stop();
      await settleBackgroundStorage();
      try {
        await Hive.close();
      } on FileSystemException {
        // The service closes its own boxes on dispose, unawaited.
      }
      try {
        if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
      } on FileSystemException {
        // Windows holds a just-closed box briefly.
      }
    });

    Future<(ProviderContainer, MessagingService)> start() async {
      final container = ProviderContainer(
        overrides: [
          relaySettingsProvider.overrideWith(_Offline.new),
          messagingServiceProvider.overrideWith((ref) {
            final service = MessagingService(ref)
              ..debugRadioRelayUrl = Uri.parse(relay.url);
            ref.onDispose(() => unawaited(service.dispose()));
            return service;
          }),
        ],
      );
      addTearDown(container.dispose);
      await container.read(messagesControllerProvider.notifier).loaded;
      return (container, container.read(messagingServiceProvider));
    }

    /// A group frame from a stranger's phone, as it would be on the air.
    Future<Uint8List> strangerFrame(Uint8List key, Uint8List tag, int seq) async {
      final x = await X25519().newKeyPair();
      final ed = await Ed25519().newKeyPair();
      final pub = Uint8List.fromList((await x.extractPublicKey()).bytes);
      final env = await MessagingService.radioEnvelope(
        key: key,
        tag: tag,
        chunk: _chunk(seq),
        originHash: await PeerId.derive(pub, PeerId.epochAt(DateTime.now())),
        msgId: TransportEnvelope.newMsgId(initialTtl: 3),
        ttl: 3,
        signKeyPair: await ed.extract(),
        senderEdPub: Uint8List.fromList((await ed.extractPublicKey()).bytes),
      );
      return Frame(type: FrameType.transport, payload: env.encode()).encode();
    }

    test('a group chunk from the relay is heard once, however often it comes',
        () async {
      final (container, service) = await start();
      final key = await RadioCrypto.deriveKey('patrol', '');
      final tag = await RadioCrypto.deriveTag(key);
      container.read(radioGroupKeysProvider.notifier).state = {
        _hex(tag): key,
      };
      final got = <RadioInbound>[];
      final sub = container.read(radioInboundProvider).listen(got.add);
      addTearDown(sub.cancel);

      service.setRadioInternetTags({_hex(tag)});
      final far = RadioRelayLink(url: Uri.parse(relay.url), onFrame: (_) {});
      addTearDown(far.dispose);
      far.setTags({_hex(tag)});
      await _until(() => relay.listening == 2, reason: 'both subscribed');

      final frame = await strangerFrame(key, tag, 0);
      far
        ..publish(_hex(tag), frame)
        ..publish(_hex(tag), frame)
        ..publish(_hex(tag), await strangerFrame(key, tag, 1));
      await _until(() => got.length == 2, reason: 'two distinct chunks');
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(got, hasLength(2), reason: 'the duplicate played once');
      expect(got.map((g) => g.chunk.seq), [0, 1]);
    });

    test('with no Bluetooth link a chunk still goes out through the relay',
        () async {
      final (_, service) = await start();
      final key = await RadioCrypto.deriveKey('patrol', '');
      final tag = await RadioCrypto.deriveTag(key);
      final heard = <Uint8List>[];
      final far = RadioRelayLink(url: Uri.parse(relay.url), onFrame: heard.add);
      addTearDown(far.dispose);
      far.setTags({_hex(tag)});

      expect(
        await service.sendRadioToGroup(key, tag, _chunk(0)),
        0,
        reason: 'not tuned on the internet: nowhere to go',
      );

      service.setRadioInternetTags({_hex(tag)});
      await _until(() => relay.listening == 2, reason: 'both subscribed');
      for (var i = 0; i < 3; i++) {
        expect(await service.sendRadioToGroup(key, tag, _chunk(i)), 1);
      }
      await _until(() => heard.length == 3, reason: 'three chunks across');
      final env = TransportEnvelope.decode(Frame.decode(heard.first).payload);
      expect(env.body.first, 0x05, reason: 'the very frame Bluetooth carries');

      service.setRadioInternetTags(const {});
      await _until(() => relay.listening == 1, reason: 'the service let go');
    });
  });
}
