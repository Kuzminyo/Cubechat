import 'package:flutter/foundation.dart';

// Moved from `features/peers/data/presence_controller.dart`, which re-exports
// it: the transport's presence heartbeat reads [PeerPresence.ttl] and what a
// beacon said, and must not import a feature to do it.

/// The last presence beacon we received from one peer.
@immutable
class PeerPresence {
  const PeerPresence({
    required this.online,
    required this.at,
    this.hidesLastSeen = false,
  });

  /// What the beacon said: the peer had the app open, or was leaving it.
  final bool online;

  /// When it landed, by our clock.
  final DateTime at;

  /// They asked not to be shown a clock: their switch is off, so we say
  /// whether they are here but never when they were.
  ///
  /// A request rather than an enforcement — see `PresenceBeacon`. Honouring it
  /// is what the same switch on this phone would want from theirs.
  final bool hidesLastSeen;

  /// A beacon is only worth believing for a while: the app can be killed
  /// outright, and the goodbye beacon is best-effort.
  ///
  /// **100 s, down from 150 on 2026-09-04.** The old value fitted two whole
  /// heartbeats (`MessagingService.presenceHeartbeat` is 70 s) so that one
  /// entirely lost beacon could not dim a peer who was still there. That margin
  /// was bought with the wait everybody else pays: somebody who loses their
  /// network sends no goodbye, so the dot stayed lit for the full window, and
  /// it was reported exactly that way — "в сети через 2 минуты проходит когда
  /// вышел из сети".
  ///
  /// **The trade this used to describe has been paid off from the other side,
  /// and this number did not move.** What 100 s no longer covered was a beacon
  /// lost outright, which showed the peer as away for the 40 s until the next
  /// one landed — reported on 2026-09-08 as the status reading "щойно" about
  /// somebody who was plainly still there.
  ///
  /// The note here said the alternative — beaconing more often — was radio,
  /// and radio is the heat three rounds of this app went into removing. That
  /// was reasoned rather than measured, and the measurement says otherwise: an
  /// "online" beacon only goes out while the app is on screen, so a 99-minute
  /// field log holds four rounds. `MessagingService.presenceHeartbeat` is 45 s
  /// now, which fits two whole beacons inside this window at a cost of about
  /// two extra rounds an hour on a phone somebody is looking at.
  ///
  /// So both reports are answered at once: one lost beacon no longer dims
  /// anybody, and a phone that dies without a goodbye still goes dark in the
  /// same 100 s — which is the half that must not grow, because a dot that
  /// stays lit is a lie nobody can correct.
  ///
  /// **60 s, down from 100 on 2026-09-15**, asked for directly ("ten seconds —
  /// no, sixty"), with `MessagingService.presenceHeartbeat` brought down to
  /// 25 s so two beacons still fit. Ten was priced first and declined: a
  /// beacon every four seconds is eleven times the traffic, on relays that
  /// already answer bursts with `rate-limited` and then refuse real messages.
  /// The half of the complaint that is not this number — the goodbye not
  /// arriving, so the dot stayed lit for the whole window after leaving — was
  /// a dropped goodbye and an iPhone suspended mid fan-out, both fixed the same
  /// day; see `MessagingService.announcePresence`.
  static const Duration ttl = Duration(seconds: 60);

  bool get isFresh => DateTime.now().difference(at) < ttl;

  @override
  bool operator ==(Object other) =>
      other is PeerPresence && other.online == online && other.at == at;

  @override
  int get hashCode => Object.hash(online, at);
}
