import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/storage/hive_cipher.dart';
import '../../../core/storage/hive_init.dart';
import '../../../core/transport/nostr/relay_settings.dart';

// [RelaySettings], the relay status and the slow-network flag live in core —
// the transport applies the one and publishes the other two. Re-exported so
// the profile's screens keep reading them from here.
export '../../../core/transport/nostr/relay_settings.dart';

/// Persists [RelaySettings] in the shared (encrypted) Hive settings box.
class RelaySettingsController extends Notifier<RelaySettings> {
  static const _enabledKey = 'nostr.enabled';
  static const _urlsKey = 'nostr.relays';

  /// Relay endpoints retired from the defaults, dropped once from lists that
  /// were saved while they were still stock.
  ///
  /// Changing [RelaySettings.defaultUrls] alone reaches nobody who has ever
  /// touched the relay screen: the stored list wins over the defaults, and
  /// enabling the fallback at all writes one. Every phone actually testing this
  /// therefore had the retired relay saved.
  static const _retiredUrls = <String>['wss://relay.damus.io'];

  /// Marks the one-time removal as done, so a user who deliberately adds a
  /// retired relay back keeps it.
  static const _retiredAppliedKey = 'nostr.relays.retiredApplied';

  /// Relay endpoints added to the defaults, folded once into lists that were
  /// saved before they were stock.
  ///
  /// The mirror of [_retiredUrls] and needed for exactly the same reason: a
  /// stored list wins over the defaults, and merely switching the internet
  /// fallback on writes one. So every phone that has ever used the relay
  /// screen — which is every phone testing this — would have kept its two and
  /// never seen the third, and the fix for "delivery rests on one road" would
  /// have reached nobody who reported it.
  static const _addedUrls = <String>['wss://nostr.mom'];

  /// Applied once, so somebody who deliberately removes an added relay keeps it
  /// removed. The same promise the retirement above makes in the other
  /// direction: this may change a list once, and never again.
  static const _addedAppliedKey = 'nostr.relays.addedApplied.v1';

  Box<dynamic>? _box;
  Future<void>? _loading;

  /// Completes once the stored list has replaced [RelaySettings.initial].
  ///
  /// The transport waits on this before its first pool. It used to start one
  /// on the defaults and rebuild it a moment later when the stored list
  /// landed — a 2026-09-21 log has `internet fallback on` twice at every
  /// launch and eight sockets opened, torn down and opened again.
  Future<void> get loaded => _loading ?? Future<void>.value();

  @override
  RelaySettings build() {
    unawaited(_loading = _load());
    return RelaySettings.initial;
  }

  Future<void> _load() async {
    try {
      final box = await hiveCipherProvider
          .openEncryptedBox<dynamic>(HiveBoxes.settings);
      _box = box;
      // `?? true` is the new-install default; a stored `false` is somebody's
      // decision and outranks it.
      final enabled = box.get(_enabledKey) as bool? ?? true;
      var stored = (box.get(_urlsKey) as List<dynamic>?)
          ?.map((e) => e.toString())
          .where(isValidRelayUrl)
          .toList();

      final retiredApplied = box.get(_retiredAppliedKey) as bool? ?? false;
      if (!retiredApplied) {
        if (stored != null) {
          final pruned =
              stored.where((u) => !_retiredUrls.contains(u)).toList();
          // Never leave someone with no relay at all: an empty list falls back
          // to the defaults below, which is the right answer anyway.
          if (pruned.length != stored.length) {
            stored = pruned;
            await box.put(_urlsKey, stored);
          }
        }
        await box.put(_retiredAppliedKey, true);
      }

      final addedApplied = box.get(_addedAppliedKey) as bool? ?? false;
      if (!addedApplied) {
        if (stored != null && stored.isNotEmpty) {
          final missing =
              _addedUrls.where((u) => !stored!.contains(u)).toList();
          if (missing.isNotEmpty) {
            stored = [...stored, ...missing];
            await box.put(_urlsKey, stored);
          }
        }
        // Marked done even when the list was empty or untouched: an empty list
        // already falls through to the defaults below, which now carry it.
        await box.put(_addedAppliedKey, true);
      }

      state = RelaySettings(
        enabled: enabled,
        urls: (stored == null || stored.isEmpty)
            ? RelaySettings.defaultUrls
            : stored,
      );
    } catch (e) {
      debugPrint('RelaySettings load failed: $e');
    }
  }

  Future<void> setEnabled(bool value) async {
    state = state.copyWith(enabled: value);
    await _persist();
  }

  /// Add a relay. Returns false when the URL isn't a valid `ws(s)://` endpoint
  /// or is already in the list.
  Future<bool> addRelay(String url) async {
    final normalized = url.trim();
    if (!isValidRelayUrl(normalized)) return false;
    if (state.urls.contains(normalized)) return false;
    state = state.copyWith(urls: [...state.urls, normalized]);
    await _persist();
    return true;
  }

  Future<void> removeRelay(String url) async {
    if (!state.urls.contains(url)) return;
    state = state.copyWith(
      urls: state.urls.where((u) => u != url).toList(),
    );
    await _persist();
  }

  /// Turn the fallback off and restore the stock relay list — used by
  /// Emergency Wipe, which must leave no trace of who you talked to.
  Future<void> reset() async {
    state = RelaySettings.initial;
    try {
      await _box?.delete(_enabledKey);
      await _box?.delete(_urlsKey);
    } catch (e) {
      debugPrint('RelaySettings reset failed: $e');
    }
  }

  Future<void> _persist() async {
    final box = _box;
    if (box == null) return;
    try {
      await box.put(_enabledKey, state.enabled);
      await box.put(_urlsKey, state.urls);
    } catch (e) {
      debugPrint('RelaySettings persist failed: $e');
    }
  }

  /// A relay URL must be an absolute `ws://` or `wss://` endpoint with a host.
  /// Anything else would either fail to connect or, worse, silently fall back
  /// to some other scheme.
  static bool isValidRelayUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.isAbsolute || uri.host.isEmpty) return false;
    return uri.scheme == 'wss' || uri.scheme == 'ws';
  }
}

final relaySettingsProvider =
    NotifierProvider<RelaySettingsController, RelaySettings>(
  RelaySettingsController.new,
);

