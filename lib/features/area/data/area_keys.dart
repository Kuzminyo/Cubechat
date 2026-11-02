import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/nostr/nostr_signer.dart';
import '../domain/area_level.dart';
import 'area_store.dart';

/// Who this phone is in one place of the area chat, for a few hours.
class AreaIdentity {
  AreaIdentity({
    required this.level,
    required this.cell,
    required this.signer,
    required this.notAfter,
    this.customName,
  });

  final AreaLevel level;
  final String cell;
  final Secp256k1NostrSigner signer;
  final DateTime notAfter;

  /// The name set by hand for this key's window, or null for the one the key
  /// gives.
  final String? customName;

  String get pubkey => signer.npubHex;
}

/// The area chat's keys: one per (cell, level), random, at most six hours.
///
/// **Random, from the CSPRNG, and derived from nothing of ours.** bitchat's
/// were `HMAC(deviceSeed, geohash)`, the same forever (H8): whoever read a
/// channel for months knew who came back, and a stolen seed tied every old
/// message to its device. Here neither is possible — the account seed, its
/// Nostr key and the device key never meet these.
///
/// Kept in the encrypted settings box with `notAfter`, so a restart a minute
/// later does not change a name mid-conversation; dropped when it passes, and
/// by the emergency wipe.
class AreaKeyring {
  AreaKeyring(
    this._kv, {
    DateTime Function()? clock,
    Uint8List Function()? randomSeed,
  })  : _clock = clock ?? DateTime.now,
        _randomSeed = randomSeed ?? _secureSeed;

  final AreaKv _kv;
  final DateTime Function() _clock;
  final Uint8List Function() _randomSeed;

  /// Six hours — the owner's answer to question 10.
  static const Duration lifetime = Duration(hours: 6);

  final Map<String, AreaIdentity> _cache = {};

  static Uint8List _secureSeed() {
    final rand = Random.secure();
    return Uint8List.fromList(List.generate(32, (_) => rand.nextInt(256)));
  }

  static String _slot(AreaLevel level, String cell) => '${level.name}:$cell';

  Future<Map<String, Map<String, Object?>>> _read() async {
    final raw = await _kv.get(AreaKeys.keys);
    if (raw is! Map) return {};
    final now = _clock().millisecondsSinceEpoch;
    return {
      for (final e in raw.entries)
        if (e.key is String &&
            e.value is Map &&
            ((e.value as Map)['notAfter'] as int? ?? 0) > now)
          e.key as String: Map<String, Object?>.from(e.value as Map),
    };
  }

  /// This phone's key for [cell] at [level]: the one still in its window, or
  /// a new one. A new cell is a new key, so moving is a new name too.
  Future<AreaIdentity> identityFor(AreaLevel level, String cell) async {
    assert(cell.length == level.precision, 'a $level cell is ${level.precision}');
    final slot = _slot(level, cell);
    final cached = _cache[slot];
    if (cached != null && cached.notAfter.isAfter(_clock())) return cached;
    final all = await _read();
    final stored = all[slot];
    if (stored != null) {
      final seed = stored['seed'];
      final notAfter = stored['notAfter'];
      if (seed is String && notAfter is int) {
        final identity = AreaIdentity(
          level: level,
          cell: cell,
          signer: await Secp256k1NostrSigner.deriveFromSeed(
            Uint8List.fromList(base64.decode(seed)),
          ),
          notAfter: DateTime.fromMillisecondsSinceEpoch(notAfter),
          customName: stored['name'] as String?,
        );
        return _cache[slot] = identity;
      }
    }
    return renew(level, cell);
  }

  /// A new key for [cell] at [level] now — the "New name" button, and the
  /// end of a window. The custom name goes with the old key: keeping it would
  /// tie the two together for anybody reading.
  Future<AreaIdentity> renew(AreaLevel level, String cell) async {
    final slot = _slot(level, cell);
    final seed = _randomSeed();
    final notAfter = _clock().add(lifetime);
    final all = await _read();
    all[slot] = {
      'seed': base64.encode(seed),
      'notAfter': notAfter.millisecondsSinceEpoch,
    };
    await _kv.put(AreaKeys.keys, all);
    return _cache[slot] = AreaIdentity(
      level: level,
      cell: cell,
      signer: await Secp256k1NostrSigner.deriveFromSeed(seed),
      notAfter: notAfter,
    );
  }

  /// Sets a name by hand for the current key's window; null or blank goes
  /// back to the key's own.
  Future<AreaIdentity> setName(
    AreaLevel level,
    String cell,
    String? name,
  ) async {
    final current = await identityFor(level, cell);
    final clean = name?.trim();
    final all = await _read();
    final entry = all[_slot(level, cell)];
    if (entry == null) return current;
    if (clean == null || clean.isEmpty) {
      entry.remove('name');
    } else {
      entry['name'] = clean;
    }
    await _kv.put(AreaKeys.keys, all);
    return _cache[_slot(level, cell)] = AreaIdentity(
      level: level,
      cell: cell,
      signer: current.signer,
      notAfter: current.notAfter,
      customName: clean == null || clean.isEmpty ? null : clean,
    );
  }

  /// Whether [name] is already this phone's name in some other place — the
  /// warning "the same name ties you together across districts".
  Future<bool> nameUsedElsewhere(
    String name,
    AreaLevel level,
    String cell,
  ) async {
    final want = name.trim().toLowerCase();
    if (want.isEmpty) return false;
    final mine = _slot(level, cell);
    for (final e in (await _read()).entries) {
      if (e.key == mine) continue;
      final other = e.value['name'];
      if (other is String && other.toLowerCase() == want) return true;
    }
    return false;
  }

  /// The emergency wipe, and the switch going off.
  Future<void> wipe() async {
    _cache.clear();
    await _kv.delete(AreaKeys.keys);
  }
}

final areaKeyringProvider =
    Provider<AreaKeyring>((ref) => AreaKeyring(ref.watch(areaKvProvider)));
