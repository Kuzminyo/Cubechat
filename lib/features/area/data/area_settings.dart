import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'area_store.dart';

/// The area chat's three switches.
@immutable
class AreaSettings {
  const AreaSettings({
    this.enabled = true,
    this.consented = false,
    this.showPresence = false,
  });

  /// Profile → Privacy → "Area chat". Off: no button on the map, and the
  /// socket and the location are never touched.
  ///
  /// On by default so the button is there to be found — it is the point of
  /// the feature — but nothing happens behind it until [consented].
  final bool enabled;

  /// The words-and-a-refusal screen on the first open of "Nearby" (spec,
  /// «Согласие при первом открытии»). Until it is accepted no fix is asked
  /// for and no socket opened.
  final bool consented;

  /// "Show that I'm here". **Off by default**, and symmetric like last seen
  /// in `PrivacySettings`: off, this phone sends no presence and is shown no
  /// count (the owner's answer to question 5).
  final bool showPresence;

  AreaSettings copyWith({
    bool? enabled,
    bool? consented,
    bool? showPresence,
  }) =>
      AreaSettings(
        enabled: enabled ?? this.enabled,
        consented: consented ?? this.consented,
        showPresence: showPresence ?? this.showPresence,
      );

  Map<String, Object> toJson() => {
        'enabled': enabled,
        'consented': consented,
        'presence': showPresence,
      };

  static AreaSettings fromJson(Object? raw) {
    if (raw is! Map) return const AreaSettings();
    return AreaSettings(
      enabled: raw['enabled'] is bool ? raw['enabled'] as bool : true,
      consented: raw['consented'] == true,
      showPresence: raw['presence'] == true,
    );
  }
}

class AreaSettingsController extends Notifier<AreaSettings> {
  bool _touched = false;
  late final AreaKv _kv;

  @override
  AreaSettings build() {
    _kv = ref.watch(areaKvProvider);
    unawaited(_load());
    return const AreaSettings();
  }

  Future<void> _load() async {
    try {
      final raw = await _kv.get(AreaKeys.settings);
      if (!_touched) state = AreaSettings.fromJson(raw);
    } catch (_) {
      // Encrypted storage not there yet: the defaults, which send nothing.
    }
  }

  Future<void> _save(AreaSettings next) async {
    _touched = true;
    state = next;
    try {
      await _kv.put(AreaKeys.settings, next.toJson());
    } catch (_) {}
  }

  Future<void> setEnabled(bool on) => _save(state.copyWith(enabled: on));
  Future<void> setConsented(bool on) => _save(state.copyWith(consented: on));
  Future<void> setShowPresence(bool on) =>
      _save(state.copyWith(showPresence: on));

  /// The emergency wipe switches the area chat off and forgets the consent
  /// (spec, «Вход в интерфейсе»). What is on disk goes with the settings box.
  Future<void> wipe() async {
    _touched = true;
    state = const AreaSettings(enabled: false);
    try {
      await _kv.delete(AreaKeys.settings);
    } catch (_) {}
  }
}

final areaSettingsProvider =
    NotifierProvider<AreaSettingsController, AreaSettings>(
  AreaSettingsController.new,
);
