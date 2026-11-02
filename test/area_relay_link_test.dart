import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/transport/nostr/area_relay_link.dart';
import 'package:cubechat/core/transport/nostr/nostr_event.dart';
import 'package:cubechat/features/area/data/area_ban_list.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _until(bool Function() check, String what) async {
  final deadline = DateTime.now().add(const Duration(seconds: 5));
  while (!check()) {
    if (DateTime.now().isAfter(deadline)) fail('timed out waiting for $what');
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
}

void main() {
  group('AreaRelayLink', () {
    late HttpServer server;
    final sockets = <WebSocket>[];
    final received = <List<dynamic>>[];
    var connections = 0;

    setUp(() async {
      sockets.clear();
      received.clear();
      connections = 0;
      server = await HttpServer.bind('localhost', 0);
      server.listen((req) async {
        final ws = await WebSocketTransformer.upgrade(req);
        connections++;
        sockets.add(ws);
        ws.listen((data) {
          final msg = jsonDecode(data as String) as List<dynamic>;
          received.add(msg);
          if (msg[0] == 'EVENT') {
            final id = (msg[1] as Map)['id'];
            ws.add(jsonEncode(['OK', id, id != 'refuse-me', 'blocked: no']));
          }
        });
      });
    });
    tearDown(() => server.close(force: true));

    AreaRelayLink link(List<NostrEvent> into) => AreaRelayLink(
          url: Uri.parse('ws://localhost:${server.port}'),
          onEvent: into.add,
        );

    test('asks for the filters it is given, and hands events up once', () async {
      final events = <NostrEvent>[];
      final l = link(events);
      addTearDown(l.dispose);
      l.setFilters([
        {
          'kinds': [1060],
          '#g': ['u8vx'],
        },
      ]);
      await _until(() => received.isNotEmpty, 'the REQ');
      expect(received.first[0], 'REQ');
      expect((received.first[2] as Map)['#g'], ['u8vx']);
      final event = {
        'id': 'a' * 64,
        'pubkey': 'b' * 64,
        'created_at': 1,
        'kind': 1060,
        'tags': <dynamic>[],
        'content': '',
        'sig': 'c' * 128,
      };
      sockets.single
        ..add(jsonEncode(['EVENT', 'area', event]))
        ..add(jsonEncode(['EVENT', 'area', event]));
      await _until(() => events.isNotEmpty, 'the event');
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(events, hasLength(1));
    });

    test("a publish waits for the relay's OK", () async {
      final l = link([]);
      addTearDown(l.dispose);
      l.setFilters([
        {
          'kinds': [1060],
          '#g': ['u8vx'],
        },
      ]);
      await _until(() => l.connected, 'the socket');
      NostrEvent event(String id) => NostrEvent(
            id: id,
            pubkey: 'b' * 64,
            createdAt: 1,
            kind: 1060,
            tags: const [],
            content: '',
            sig: 'c' * 128,
          );
      expect(await l.publish(event('ok-me')), AreaPublishOutcome.accepted);
      expect(await l.publish(event('refuse-me')), AreaPublishOutcome.refused);
    });

    test('a frame over 64 KiB ends the socket', () async {
      final l = link([]);
      addTearDown(l.dispose);
      l.setFilters([
        {
          'kinds': [1060],
          '#g': ['u8vx'],
        },
      ]);
      await _until(() => l.connected, 'the socket');
      sockets.single.add('x' * (AreaRelayLink.maxFrameChars + 1));
      await _until(() => !l.connected, 'the hang-up');
    });

    test('no filters, no socket', () async {
      final l = link([]);
      addTearDown(l.dispose);
      l.setFilters(const []);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(connections, 0);
      expect(
        await l.publish(
          NostrEvent(
            id: 'x',
            pubkey: 'b' * 64,
            createdAt: 1,
            kind: 1060,
            tags: const [],
            content: '',
          ),
        ),
        AreaPublishOutcome.offline,
      );
    });
  });

  group('verifyAreaBanList', () {
    test('accepts its own signature over the canonical body, nothing else',
        () async {
      final ed = Ed25519();
      final pair = await ed.newKeyPair();
      final publicHex = (await pair.extractPublicKey())
          .bytes
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();
      final body = <String, dynamic>{
        'v': 1,
        'updatedAt': 5,
        'events': ['e' * 64],
        'keys': ['f' * 64],
      };
      final sig = await ed.sign(
        utf8.encode(canonicalAreaBanBody(body)),
        keyPair: pair,
      );
      body['sig'] =
          sig.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      final list = await verifyAreaBanList(body, publicKeyHex: publicHex);
      expect(list!.keys, {'f' * 64});
      expect(list.events, {'e' * 64});

      final forged = Map<String, dynamic>.of(body)
        ..['keys'] = ['0' * 64];
      expect(await verifyAreaBanList(forged, publicKeyHex: publicHex), isNull);
      // And the default key, which did not sign it.
      expect(await verifyAreaBanList(body), isNull);
    });
  });
}
