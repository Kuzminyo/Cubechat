import 'dart:convert';

import 'package:cubechat/core/transport/nostr/nostr_event.dart';
import 'package:cubechat/core/transport/nostr/nostr_pow.dart';
import 'package:cubechat/features/area/domain/area_event.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/area_fixtures.dart';

void main() {
  final now = DateTime.utc(2026, 11, 2, 12, 34, 56);
  final nowSeconds = now.millisecondsSinceEpoch ~/ 1000;

  group('AreaContent', () {
    test('round-trips, and leaves out what is absent', () {
      const c = AreaContent(text: 'hi', cell: 'u8vxn');
      expect(c.encode(), '{"v":1,"text":"hi","cell":"u8vxn"}');
      final back = AreaContent.decode(c.encode());
      expect(back.text, 'hi');
      expect(back.cell, 'u8vxn');
      expect(back.name, isNull);
    });

    test('refuses anything but the schema', () {
      for (final bad in [
        'nope',
        '[]',
        '{"v":2,"text":"hi"}',
        '{"v":1}',
        '{"v":1,"text":"   "}',
        '{"v":1,"text":"hi","n":"bob"}',
        '{"v":1,"text":"hi","cell":"u8vx"}',
        '{"v":1,"text":"hi","cell":"u8vxnn"}',
        '{"v":1,"text":"hi","name":""}',
        '{"v":1,"text":"${'x' * 501}"}',
      ]) {
        expect(() => AreaContent.decode(bad), throwsFormatException, reason: bad);
      }
    });

    test('control characters and lone surrogates are dropped', () {
      expect(cleanAreaText(' a\u0001b\nc\u0007 '), 'ab\nc');
      expect(cleanAreaText('x\uD800y'), 'xy');
      expect(cleanAreaText('🙂'), '🙂');
      expect(clipAreaText('ab🙂', 3), 'ab');
    });
  });

  group('ceilings on everything outgoing', () {
    test('a district message: g is the city, the district only in content',
        () {
      final e = mineNonce(
        areaMessageEvent(
          pubkey: 'a' * 64,
          g: 'u8vx',
          cell: 'u8vxn',
          text: 'hi',
          now: now,
        ),
        kAreaMessagePowBits,
      );
      checkAreaCeilings(e);
      expect(e.firstTagValue('g'), 'u8vx');
      expect(e.tags.any((t) => t.contains('u8vxn')), isFalse);
    });

    test('a g finer than a city never goes out', () {
      for (final g in ['u8vxn', 'u8vxnq', 'u8']) {
        final e = areaMessageEvent(pubkey: 'a' * 64, g: g, text: 'x', now: now);
        expect(
          () => checkAreaCeilings(e),
          throwsA(isA<AreaCeilingError>()),
          reason: g,
        );
      }
    });

    test('presence never at the district level, and never with content', () {
      expect(
        () => checkAreaCeilings(
          areaPresenceEvent(pubkey: 'a' * 64, g: 'u8vxn', now: now),
        ),
        throwsA(isA<AreaCeilingError>()),
      );
      checkAreaCeilings(areaPresenceEvent(pubkey: 'a' * 64, g: 'u8vx', now: now));
      checkAreaCeilings(areaPresenceEvent(pubkey: 'a' * 64, g: 'u8v', now: now));
    });

    test('a cell outside g, or a tag we never send, is refused', () {
      final outside = areaMessageEvent(
        pubkey: 'a' * 64,
        g: 'u8vx',
        cell: 'u9bbb',
        text: 'x',
        now: now,
      );
      expect(() => checkAreaCeilings(outside), throwsA(isA<AreaCeilingError>()));
      final named = areaMessageEvent(pubkey: 'a' * 64, g: 'u8vx', text: 'x', now: now)
          .copyWith(
        tags: [
          ['g', 'u8vx'],
          ['n', 'bob'],
        ],
      );
      expect(() => checkAreaCeilings(named), throwsA(isA<AreaCeilingError>()));
    });

    test('a deletion names no place', () {
      checkAreaCeilings(
        areaDeletionEvent(pubkey: 'a' * 64, noteId: 'b' * 64, now: now),
      );
    });

    test('the subscription is never finer than a city', () {
      final filters = areaSubscriptionFilters({'u8vx', 'u8v'}, nowSeconds: nowSeconds);
      for (final f in filters) {
        for (final g in f['#g']! as List<String>) {
          expect(g.length, lessThanOrEqualTo(4));
        }
      }
      expect(
        () => areaSubscriptionFilters({'u8vxn'}, nowSeconds: nowSeconds),
        throwsA(isA<AreaCeilingError>()),
      );
    });

    test('a note without a hand-picked district has no cell, and its time '
        'is rounded to ten minutes', () {
      final e = areaNoteEvent(
        pubkey: 'a' * 64,
        g: 'u8vx',
        text: 'кава тут смачна',
        lifetime: const Duration(hours: 24),
        now: now,
      );
      expect(AreaContent.decode(e.content).cell, isNull);
      expect(e.createdAt % kAreaNoteTimeBucketSeconds, 0);
      expect(e.createdAt, lessThanOrEqualTo(nowSeconds));
      expect(
        int.parse(e.firstTagValue('expiration')!),
        e.createdAt + const Duration(hours: 24).inSeconds,
      );
      expect(
        () => areaNoteEvent(
          pubkey: 'a' * 64,
          g: 'u8vx',
          text: 'x',
          lifetime: const Duration(days: 30),
          now: now,
        ),
        throwsArgumentError,
      );
    });
  });

  group('verifyAreaEvent', () {
    late NostrEvent good;
    var signatureCalls = 0;
    Future<bool> counting(NostrEvent e) {
      signatureCalls++;
      return areaRealSignatureCheck(e);
    }

    setUpAll(() async {
      final signer = await areaTestSigner(1);
      good = await areaSignedMessage(signer, now: now, cell: 'u8vxn');
    });
    setUp(() => signatureCalls = 0);

    Future<AreaRefusal?> refusal(NostrEvent e) async =>
        (await verifyAreaEvent(e, nowSeconds: nowSeconds, signature: counting)).$2;

    test('a good event passes all five steps', () async {
      final (inbound, why) =
          await verifyAreaEvent(good, nowSeconds: nowSeconds, signature: counting);
      expect(why, isNull);
      expect(inbound!.content!.cell, 'u8vxn');
      expect(inbound.g, 'u8vx');
      expect(signatureCalls, 1);
    });

    test('1: another kind, or too large', () async {
      expect(await refusal(good.copyWith(kind: 1)), AreaRefusal.kindOrSize);
      expect(
        await refusal(good.copyWith(content: 'x' * (kAreaMaxEventBytes + 1))),
        AreaRefusal.kindOrSize,
      );
      expect(signatureCalls, 0);
    });

    test('2: an id that is not the hash of the fields', () async {
      final tampered = good.copyWith(
        content: const AreaContent(text: 'інше', cell: 'u8vxn').encode(),
      );
      expect(await refusal(tampered), AreaRefusal.id);
      expect(await refusal(good.copyWith(id: 'zz')), AreaRefusal.id);
      expect(signatureCalls, 0);
    });

    test('3: without the proof of work Schnorr is never asked', () async {
      final signer = await areaTestSigner(2);
      // Signed honestly, but with no nonce mined: an id with (almost surely)
      // fewer than twelve leading zero bits.
      var lazy = await signer.sign(
        areaMessageEvent(pubkey: signer.npubHex, g: 'u8vx', text: 'x', now: now),
      );
      for (var i = 0; leadingZeroBits(_bytes(lazy.id!)) >= 12; i++) {
        lazy = await signer.sign(
          areaMessageEvent(
            pubkey: signer.npubHex,
            g: 'u8vx',
            text: 'x$i',
            now: now,
          ),
        );
      }
      expect(await refusal(lazy), AreaRefusal.pow);
      expect(signatureCalls, 0);
    });

    test('4: tags and content off the schema', () async {
      final signer = await areaTestSigner(3);
      Future<NostrEvent> withTags(
        List<List<String>> tags, {
        String? content,
        int? createdAt,
      }) =>
          areaSign(
            signer,
            NostrEvent(
              pubkey: signer.npubHex,
              createdAt: createdAt ?? nowSeconds,
              kind: kAreaMessageKind,
              tags: tags,
              content: content ?? '{"v":1,"text":"x"}',
            ),
          );
      final exp = '${nowSeconds + 3600}';
      final cases = <String, NostrEvent>{
        'no g': await withTags([
          ['expiration', exp],
        ]),
        'district g': await withTags([
          ['g', 'u8vxn'],
          ['expiration', exp],
        ]),
        'two g': await withTags([
          ['g', 'u8vx'],
          ['g', 'u8v'],
          ['expiration', exp],
        ]),
        'nickname tag': await withTags([
          ['g', 'u8vx'],
          ['expiration', exp],
          ['n', 'bob'],
        ]),
        'no expiration': await withTags([
          ['g', 'u8vx'],
        ]),
        'expiration past a day': await withTags([
          ['g', 'u8vx'],
          ['expiration', '${nowSeconds + 2 * 86400}'],
        ]),
        'expired': await withTags(
          [
            ['g', 'u8vx'],
            ['expiration', '${nowSeconds - 1}'],
          ],
          createdAt: nowSeconds - 3600,
        ),
        'from the future': await withTags(
          [
            ['g', 'u8vx'],
            ['expiration', '${nowSeconds + 3600}'],
          ],
          createdAt: nowSeconds + 600,
        ),
        'cell outside g': await withTags(
          [
            ['g', 'u8vx'],
            ['expiration', exp],
          ],
          content: '{"v":1,"text":"x","cell":"u9bbb"}',
        ),
        'extra content key': await withTags(
          [
            ['g', 'u8vx'],
            ['expiration', exp],
          ],
          content: '{"v":1,"text":"x","lat":50.45}',
        ),
      };
      for (final entry in cases.entries) {
        expect(
          await refusal(entry.value),
          AreaRefusal.schema,
          reason: entry.key,
        );
      }
      // Presence with a cell, or content, is not presence.
      final presence = await areaSign(
        signer,
        NostrEvent(
          pubkey: signer.npubHex,
          createdAt: nowSeconds,
          kind: kAreaPresenceKind,
          tags: [
            ['g', 'u8vx'],
          ],
          content: '{"v":1,"text":"x","cell":"u8vxn"}',
        ),
      );
      expect(await refusal(presence), AreaRefusal.schema);
      expect(signatureCalls, 0);
    });

    test("5: a signature that is not the author's", () async {
      final other = await areaTestSigner(9);
      // The same event claimed by another key: the id changes, so it is
      // re-mined, but the signature is still the first key's.
      final claimed = mineNonce(
        good.copyWith(
          pubkey: other.npubHex,
          tags: good.tags.where((t) => t[0] != 'nonce').toList(),
        ),
        kAreaMessagePowBits,
      );
      final withId = await claimed.withId();
      final forged = withId.copyWith(sig: good.sig);
      expect(await refusal(forged), AreaRefusal.signature);
      expect(signatureCalls, 1);
      // And a bit flipped in a real signature.
      final flipped = good.copyWith(
        sig: '${good.sig!.substring(0, 10)}'
            '${good.sig![10] == '0' ? '1' : '0'}'
            '${good.sig!.substring(11)}',
      );
      expect(await refusal(flipped), AreaRefusal.signature);
    });

    test('a note may live seven days; a message only one', () async {
      final signer = await areaTestSigner(4);
      final note = await areaSign(
        signer,
        areaNoteEvent(
          pubkey: signer.npubHex,
          g: 'u8vx',
          text: 'x',
          lifetime: const Duration(days: 7),
          now: now,
        ),
      );
      expect(await refusal(note), isNull);
    });
  });

  test('the content is valid JSON for any text the person types', () {
    const text = 'he said "hi" \\ and left\nnext line \u{1F600}';
    final e = areaMessageEvent(pubkey: 'a' * 64, g: 'u8vx', text: text, now: now);
    final decoded = jsonDecode(e.content) as Map<String, dynamic>;
    expect(decoded['text'], text);
  });
}

List<int> _bytes(String hex) => [
      for (var i = 0; i < hex.length; i += 2)
        int.parse(hex.substring(i, i + 2), radix: 16),
    ];
