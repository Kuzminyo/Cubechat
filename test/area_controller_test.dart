import 'package:cubechat/core/transport/nostr/area_relay_link.dart';
import 'package:cubechat/core/transport/nostr/nostr_event.dart';
import 'package:cubechat/core/transport/nostr/nostr_pow.dart';
import 'package:cubechat/features/area/data/area_controller.dart';
import 'package:cubechat/features/area/data/area_location.dart';
import 'package:cubechat/features/area/data/area_report.dart';
import 'package:cubechat/features/area/data/area_settings.dart';
import 'package:cubechat/features/area/data/area_store.dart';
import 'package:cubechat/features/area/domain/area_event.dart';
import 'package:cubechat/features/area/domain/area_level.dart';
import 'package:cubechat/features/moderation/domain/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/area_fixtures.dart';

/// Records what the controller asks for and sends; hands events in when told.
class _FakeLink extends AreaRelayLink {
  _FakeLink({required super.onEvent, required this.connection})
      : super(onConnection: connection);

  final void Function(bool) connection;
  final List<List<Map<String, Object>>> filters = [];
  final List<NostrEvent> published = [];
  bool up = false;

  void Function(NostrEvent)? deliverTo;

  @override
  bool get connected => up;

  @override
  void setFilters(List<Map<String, Object>> f) {
    filters.add(f);
    if (!up && f.isNotEmpty) {
      up = true;
      connection(true);
    }
  }

  @override
  Future<AreaPublishOutcome> publish(NostrEvent signed) async {
    published.add(signed);
    return AreaPublishOutcome.accepted;
  }

  @override
  Future<void> dispose() async => up = false;
}

class _FakeReporter extends AreaReporter {
  final List<String> reported = [];

  @override
  Future<bool> send({
    required ReportReason reason,
    required String authorKey,
    required String eventId,
    required String geohash,
    required String text,
    required int sentAtSeconds,
    String? note,
  }) async {
    reported.add('$geohash:$eventId');
    return true;
  }
}

void main() {
  late MemoryAreaKv kv;
  late ProviderContainer container;
  late _FakeLink link;
  late _FakeReporter reporter;
  void Function(NostrEvent)? deliver;

  Future<void> settle() async {
    for (var i = 0; i < 20; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  Future<AreaController> start({bool presence = false}) async {
    kv = MemoryAreaKv()
      ..values[AreaKeys.settings] = {
        'enabled': true,
        'consented': true,
        'presence': presence,
      };
    reporter = _FakeReporter();
    container = ProviderContainer(
      overrides: [
        areaKvProvider.overrideWithValue(kv),
        areaDistrictReaderProvider.overrideWithValue(() async => ('u8vxn', null)),
        areaBanFetcherProvider.overrideWithValue(() async => null),
        areaMinerProvider.overrideWithValue((e, bits) async => mineNonce(e, bits)),
        areaSignatureCheckProvider.overrideWithValue(areaRealSignatureCheck),
        areaReporterProvider.overrideWithValue(reporter),
        areaLinkFactoryProvider.overrideWithValue(
          ({required onEvent, required onConnection}) {
            deliver = onEvent;
            return link = _FakeLink(onEvent: onEvent, connection: onConnection);
          },
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(areaSettingsProvider);
    final c = container.read(areaControllerProvider.notifier);
    await settle();
    c.acquire();
    await settle();
    return c;
  }

  List<String> gsOf(Iterable<NostrEvent> events) =>
      [for (final e in events) e.firstTagValue('g') ?? '-'];

  test('nothing at all before consent', () async {
    kv = MemoryAreaKv();
    var dialled = false;
    var located = false;
    container = ProviderContainer(
      overrides: [
        areaKvProvider.overrideWithValue(kv),
        areaDistrictReaderProvider.overrideWithValue(() async {
          located = true;
          return ('u8vxn', null);
        }),
        areaLinkFactoryProvider.overrideWithValue(
          ({required onEvent, required onConnection}) {
            dialled = true;
            return _FakeLink(onEvent: onEvent, connection: onConnection);
          },
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(areaControllerProvider.notifier).acquire();
    await settle();
    expect(container.read(areaSettingsProvider).consented, isFalse);
    expect(dialled, isFalse);
    expect(located, isFalse);
  });

  test('the subscription is the cities around the district and the region, '
      'never finer', () async {
    final c = await start();
    expect(c.state.place!.district, 'u8vxn');
    final last = link.filters.last;
    for (final f in last) {
      for (final g in f['#g']! as List<String>) {
        expect(g.length, inInclusiveRange(3, 4), reason: g);
      }
    }
    expect(last.first['#g'], containsAll(['u8vx', 'u8v']));
  });

  test('presence is off by default: nothing sent, no count shown', () async {
    final c = await start();
    c.setPresenceRoom(const AreaRoomId.own(AreaLevel.city));
    await settle();
    expect(link.published.where((e) => e.kind == kAreaPresenceKind), isEmpty);
    expect(c.presentCount(const AreaRoomId.own(AreaLevel.city)), isNull);
  });

  test('presence on: only to the open level, never to the district',
      () async {
    final c = await start(presence: true);
    c.setPresenceRoom(const AreaRoomId.own(AreaLevel.district));
    await settle();
    expect(link.published, isEmpty);
    expect(c.presentCount(const AreaRoomId.own(AreaLevel.district)), isNull);

    c.setPresenceRoom(const AreaRoomId.own(AreaLevel.city));
    await settle();
    final presence =
        link.published.where((e) => e.kind == kAreaPresenceKind).toList();
    expect(gsOf(presence), ['u8vx']);
    expect(c.presentCount(const AreaRoomId.own(AreaLevel.city)), isNotNull);
    c.setPresenceRoom(null);
  });

  test('a city read from the map: only the subscription leaves the phone',
      () async {
    final c = await start(presence: true);
    final keysBefore = Map.of(kv.values[AreaKeys.keys]! as Map);
    c.openForeign('u9bb');
    await settle();
    expect(link.filters.last.first['#g'], contains('u9bb'));
    const foreign = AreaRoomId.foreign('u9bb');
    expect(await c.send(foreign, 'привіт зі Львова'), AreaSendResult.readOnly);
    c.setPresenceRoom(foreign);
    await settle();
    expect(link.published, isEmpty);
    expect(c.presentCount(foreign), isNull);
    expect(kv.values[AreaKeys.keys], keysBefore, reason: 'no key made');
  });

  test('a district message carries the city in g and the district in the '
      'content', () async {
    final c = await start();
    final result =
        await c.send(const AreaRoomId.own(AreaLevel.district), 'хто тут?');
    expect(result, AreaSendResult.sent);
    final sent = link.published.single;
    expect(sent.kind, kAreaMessageKind);
    expect(sent.firstTagValue('g'), 'u8vx');
    expect(AreaContent.decode(sent.content).cell, 'u8vxn');
    expect(
      c.room(const AreaRoomId.own(AreaLevel.district)).posts.single.mine,
      isTrue,
    );
    // The next one inside three seconds waits.
    expect(
      await c.send(const AreaRoomId.own(AreaLevel.district), 'ще'),
      AreaSendResult.tooFast,
    );
  });

  test('a note without a hand-picked district has no cell, whatever the fix',
      () async {
    final c = await start();
    await c.leaveNote('кава тут', lifetime: const Duration(hours: 1));
    final note = link.published.single;
    expect(note.kind, kAreaNoteKind);
    expect(note.firstTagValue('g'), 'u8vx');
    expect(AreaContent.decode(note.content).cell, isNull);

    await c.leaveNote(
      'тут теж',
      lifetime: const Duration(hours: 24),
      pinnedDistrict: 'u8vxp',
    );
    expect(AreaContent.decode(link.published.last.content).cell, 'u8vxp');
    expect(
      () => c.leaveNote('x', lifetime: const Duration(hours: 1), pinnedDistrict: 'u9bbb'),
      throwsArgumentError,
    );
    // Two notes, two keys, neither a chat key.
    final noteKeys = link.published.map((e) => e.pubkey).toSet();
    expect(noteKeys, hasLength(2));
    expect(noteKeys, isNot(contains(c.identity(AreaLevel.city)!.pubkey)));
  });

  test('nothing is ever sent in answer to what arrives', () async {
    final c = await start(presence: true);
    final stranger = await areaTestSigner(5);
    final now = DateTime.now();
    final inbound = [
      await areaSignedMessage(stranger, now: now, text: 'привіт'),
      await areaSignedMessage(stranger, now: now, cell: 'u8vxn', text: 'район'),
      await areaSign(
        stranger,
        areaPresenceEvent(pubkey: stranger.npubHex, g: 'u8vx', now: now),
      ),
      await areaSign(
        stranger,
        areaNoteEvent(
          pubkey: stranger.npubHex,
          g: 'u8vx',
          text: 'записка',
          lifetime: const Duration(hours: 1),
          now: now,
        ),
      ),
    ];
    final before = link.published.length;
    for (final e in inbound) {
      deliver!(e);
    }
    await settle();
    await Future<void>.delayed(const Duration(milliseconds: 200));
    expect(link.published.length, before);
    expect(c.room(const AreaRoomId.own(AreaLevel.city)).posts, hasLength(1));
    expect(c.room(const AreaRoomId.own(AreaLevel.district)).posts, hasLength(1));
    expect(c.allNotes(), hasLength(1));
  });

  test('a forged event never reaches a room', () async {
    final c = await start();
    final stranger = await areaTestSigner(6);
    final real = await areaSignedMessage(stranger, now: DateTime.now());
    // Flip the first hex digit rather than overwrite it with a fixed value:
    // writing '00' left the signature untouched whenever it already began
    // with 00 — one run in 256 — and the "forgery" was the real event, which
    // rightly got in. That failed CI on 1569151d (2026-11-04).
    final sig = real.sig!;
    final forged = sig.replaceRange(0, 1, sig[0] == '0' ? '1' : '0');
    deliver!(real.copyWith(sig: forged));
    await settle();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(c.room(const AreaRoomId.own(AreaLevel.city)).posts, isEmpty);
  });

  test('a report names the event and blocks its author here', () async {
    final c = await start();
    final stranger = await areaTestSigner(7);
    final e = await areaSignedMessage(stranger, now: DateTime.now());
    deliver!(e);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    const city = AreaRoomId.own(AreaLevel.city);
    final post = c.room(city).posts.single;
    await c.report(post, c.geohashOf(city)!, reason: ReportReason.spam);
    expect(reporter.reported, ['u8vx:${e.id}']);
    expect(c.room(city).posts, isEmpty);
    expect((kv.values[AreaKeys.hidden]! as Map).keys, contains(stranger.npubHex));
  });

  test('the wipe erases keys, notes and the switch', () async {
    final c = await start();
    await c.leaveNote('x', lifetime: const Duration(hours: 1));
    expect(kv.values.keys, containsAll([AreaKeys.keys, AreaKeys.notes]));
    await c.wipe();
    for (final key in AreaKeys.all) {
      expect(kv.values.containsKey(key), isFalse, reason: key);
    }
    expect(container.read(areaSettingsProvider).enabled, isFalse);
    expect(link.up, isFalse);
  });

  test('every outgoing event obeys the ceilings', () async {
    final c = await start(presence: true);
    c.setPresenceRoom(const AreaRoomId.own(AreaLevel.region));
    await c.send(const AreaRoomId.own(AreaLevel.district), 'a');
    await c.send(const AreaRoomId.own(AreaLevel.city), 'b');
    await c.send(const AreaRoomId.own(AreaLevel.region), 'c');
    await c.leaveNote('d', lifetime: const Duration(days: 7));
    await settle();
    expect(link.published.length, greaterThanOrEqualTo(5));
    for (final e in link.published) {
      checkAreaCeilings(e);
      final g = e.firstTagValue('g')!;
      expect(g.length, lessThanOrEqualTo(4));
      if (e.kind == kAreaPresenceKind) expect(g, 'u8v');
    }
    c.setPresenceRoom(null);
  });

  group('AreaCellTracker', () {
    test('a new district is believed after two fixes in a row', () {
      final t = AreaCellTracker();
      expect(t.accept('u8vxn'), 'u8vxn');
      expect(t.accept('u8vxp'), 'u8vxn');
      expect(t.accept('u8vxn'), 'u8vxn');
      expect(t.accept('u8vxp'), 'u8vxn');
      expect(t.accept('u8vxp'), 'u8vxp');
    });
  });
}
