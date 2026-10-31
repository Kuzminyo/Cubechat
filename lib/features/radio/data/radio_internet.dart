import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/messaging_service.dart';
import '../../../core/transport/peer_id.dart';
import '../../profile/data/relay_settings_controller.dart';
import 'radio_controller.dart';

/// The two things [RadioInternet] asks of the transport, behind a provider so
/// a test can watch them without building a [MessagingService] (whose
/// constructor starts the mesh's timers).
abstract class RadioInternetPort {
  void setTags(Set<String> tagHexes);
  Future<Set<String>> pairTagsFor(String canonicalId);
}

class _MessagingRadioInternetPort implements RadioInternetPort {
  _MessagingRadioInternetPort(this._ref);

  final Ref _ref;

  @override
  void setTags(Set<String> tagHexes) =>
      _ref.read(messagingServiceProvider).setRadioInternetTags(tagHexes);

  @override
  Future<Set<String>> pairTagsFor(String canonicalId) =>
      _ref.read(messagingServiceProvider).radioPairTagsFor(canonicalId);
}

final radioInternetPortProvider = Provider<RadioInternetPort>(
  _MessagingRadioInternetPort.new,
);

/// Which radio tags the walkie-talkie listens to through our relay (stage 4a,
/// `docs/superpowers/plans/2026-10-31-walkie-talkie-internet.md`), and the one
/// place that tells the transport so.
///
/// Only the tuned channel, and only while the relays are switched on in
/// Profile: they are off by default because touching a server is the user's
/// decision ([RelaySettings.enabled]), and the radio does not get to make it
/// for them. A group is its fixed tag; a contact is the pair tags of the
/// previous, current and next hour, worked out again when the hour turns.
///
/// Not the personal-call wait (Ruling 27): an idle radio would have to listen
/// on every contact's pair tags, three each, and that is stage 4b's, together
/// with the push that wakes a sleeping phone.
class RadioInternet extends Notifier<Set<String>> {
  Timer? _nextHour;

  /// Bumped on every rebuild, so a pair-tag derivation that finishes after
  /// the radio was retuned does not write the old contact's tags back.
  int _generation = 0;

  @override
  Set<String> build() {
    final active = ref.watch(radioControllerProvider.select((s) => s.active));
    final enabled = ref.watch(relaySettingsProvider.select((s) => s.enabled));
    final generation = ++_generation;
    // Before a rebuild as well as at the end: the build after it sets the
    // tags itself, so the socket is not closed only to be opened again.
    ref.onDispose(() => _nextHour?.cancel());

    if (!enabled || active == null) {
      _apply(const {});
      return const {};
    }
    switch (active) {
      case RadioRoom(:final tagHex):
        final tags = {tagHex};
        _apply(tags);
        return tags;
      case RadioContact(:final canonicalId):
        unawaited(_tuneToContact(canonicalId, generation));
        return const {};
    }
  }

  Future<void> _tuneToContact(String canonicalId, int generation) async {
    final tags =
        await ref.read(radioInternetPortProvider).pairTagsFor(canonicalId);
    if (generation != _generation) return;
    state = tags;
    _apply(tags);
    // A pair tag lasts an hour; the three in hand cover the one after this
    // too, so the turn of the hour is the moment to slide them along.
    final now = DateTime.now();
    final epochMs = PeerId.rotationPeriod.inMilliseconds;
    final intoEpoch = now.millisecondsSinceEpoch % epochMs;
    _nextHour = Timer(
      Duration(milliseconds: epochMs - intoEpoch + 1000),
      () => unawaited(_tuneToContact(canonicalId, generation)),
    );
  }

  void _apply(Set<String> tags) =>
      ref.read(radioInternetPortProvider).setTags(tags);
}

final radioInternetProvider =
    NotifierProvider<RadioInternet, Set<String>>(RadioInternet.new);
