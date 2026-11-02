import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cubechat/core/transport/nostr/nostr_signer.dart';
import 'package:cubechat/features/area/data/area_keys.dart';
import 'package:cubechat/features/area/data/area_store.dart';
import 'package:cubechat/features/area/domain/area_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MemoryAreaKv kv;
  late DateTime now;
  AreaKeyring ring() => AreaKeyring(kv, clock: () => now);

  setUp(() {
    kv = MemoryAreaKv();
    now = DateTime(2026, 11, 2, 12);
  });

  test("neither the account's keys nor anything derived from them", () async {
    // An account: its Ed25519 seed, the Nostr key derived from it, its
    // X25519 key. The area key must be none of them and not come from them.
    final ed = await Ed25519().newKeyPair();
    final seed = Uint8List.fromList(await ed.extractPrivateKeyBytes());
    final edPublic = (await ed.extractPublicKey()).bytes;
    final x = await X25519().newKeyPair();
    final xPublic = (await x.extractPublicKey()).bytes;
    final accountNostr = await Secp256k1NostrSigner.deriveFromSeed(seed);

    final area = await ring().identityFor(AreaLevel.city, 'u8vx');
    String hex(List<int> b) =>
        b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
    expect(area.pubkey, isNot(accountNostr.npubHex));
    expect(area.pubkey, isNot(hex(edPublic)));
    expect(area.pubkey, isNot(hex(xPublic)));
    // What is stored is a fresh random seed, not the account's.
    final stored = (kv.values[AreaKeys.keys]! as Map)['city:u8vx'] as Map;
    expect(stored['seed'], isNot(contains(hex(seed))));
  });

  test('a key per level and per cell', () async {
    final r = ring();
    final district = await r.identityFor(AreaLevel.district, 'u8vxn');
    final city = await r.identityFor(AreaLevel.city, 'u8vx');
    final region = await r.identityFor(AreaLevel.region, 'u8v');
    final otherDistrict = await r.identityFor(AreaLevel.district, 'u8vxp');
    final keys = {
      district.pubkey,
      city.pubkey,
      region.pubkey,
      otherDistrict.pubkey,
    };
    expect(keys, hasLength(4));
  });

  test('kept across a restart, renewed after six hours or by the button',
      () async {
    final first = await ring().identityFor(AreaLevel.city, 'u8vx');
    // A restart a minute later: a new keyring over the same box.
    now = now.add(const Duration(minutes: 1));
    final again = await ring().identityFor(AreaLevel.city, 'u8vx');
    expect(again.pubkey, first.pubkey);

    now = now.add(AreaKeyring.lifetime);
    final later = await ring().identityFor(AreaLevel.city, 'u8vx');
    expect(later.pubkey, isNot(first.pubkey));

    final r = ring();
    final before = await r.identityFor(AreaLevel.city, 'u8vx');
    final renewed = await r.renew(AreaLevel.city, 'u8vx');
    expect(renewed.pubkey, isNot(before.pubkey));
    expect((await r.identityFor(AreaLevel.city, 'u8vx')).pubkey, renewed.pubkey);
  });

  test('a custom name lives with its key, and the same name elsewhere is '
      'noticed', () async {
    final r = ring();
    await r.setName(AreaLevel.city, 'u8vx', 'Оля');
    expect((await r.identityFor(AreaLevel.city, 'u8vx')).customName, 'Оля');
    expect(await r.nameUsedElsewhere('оля', AreaLevel.district, 'u8vxn'), isTrue);
    expect(await r.nameUsedElsewhere('Оля', AreaLevel.city, 'u8vx'), isFalse);
    final renewed = await r.renew(AreaLevel.city, 'u8vx');
    expect(renewed.customName, isNull, reason: 'a name would tie the keys');
  });

  test('the wipe erases every key', () async {
    final r = ring();
    final before = await r.identityFor(AreaLevel.city, 'u8vx');
    await r.wipe();
    expect(kv.values.containsKey(AreaKeys.keys), isFalse);
    final after = await r.identityFor(AreaLevel.city, 'u8vx');
    expect(after.pubkey, isNot(before.pubkey));
  });
}
