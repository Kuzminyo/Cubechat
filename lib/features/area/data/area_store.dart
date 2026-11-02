import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';

/// The little the area chat keeps on disk, and nothing else (spec,
/// «Ограничения памяти»): its own switches, its own keys with their
/// `notAfter`, the authors hidden here, and its own notes until they expire.
/// Who was read, where, and what they wrote stays in memory.
///
/// In the encrypted settings box, under `area.*` keys, so an emergency wipe
/// takes it with everything else.
abstract class AreaKv {
  Future<Object?> get(String key);
  Future<void> put(String key, Object value);
  Future<void> delete(String key);
}

class HiveAreaKv implements AreaKv {
  Box<dynamic>? _box;
  Future<Box<dynamic>>? _opening;

  Future<Box<dynamic>> _open() {
    final box = _box;
    if (box != null && box.isOpen) return Future.value(box);
    return _opening ??= hiveCipherProvider
        .openEncryptedBox<dynamic>(HiveBoxes.settings)
        .then((b) {
      _box = b;
      _opening = null;
      return b;
    });
  }

  @override
  Future<Object?> get(String key) async => (await _open()).get(key);

  @override
  Future<void> put(String key, Object value) async =>
      (await _open()).put(key, value);

  @override
  Future<void> delete(String key) async => (await _open()).delete(key);
}

/// For tests.
class MemoryAreaKv implements AreaKv {
  final Map<String, Object> values = {};

  @override
  Future<Object?> get(String key) async => values[key];

  @override
  Future<void> put(String key, Object value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

final areaKvProvider = Provider<AreaKv>((ref) => HiveAreaKv());

/// Storage keys, in one place so the wipe can name them all.
class AreaKeys {
  static const settings = 'area.settings';
  static const keys = 'area.keys';
  static const notes = 'area.notes';
  static const hidden = 'area.hidden';

  static const all = [settings, keys, notes, hidden];
}
