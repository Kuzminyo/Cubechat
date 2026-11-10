/// Limits only our outgoing speech stream; WebRTC still controls congestion
/// below this ceiling. Fast reduction, slow recovery avoids pumping the codec
/// up and down on an unstable mobile link. Thresholds are conservative policy,
/// not a claim that the user's logs contained RTP quality measurements.
///
/// **Not only on the other side's reports** (2026-11-10). The ladder used to
/// move on remote RTCP alone, and in the 2026-11-09 log not one of seven
/// samples had any: on a weak link the call kept sending 720p at 30 fps and
/// 800 kbit/s, and their picture froze where WhatsApp's steps down. So it
/// also reads what WebRTC itself measures on every poll — its bandwidth
/// estimate for the link ([available]) and the round trip of the connection
/// — and steps down when the link cannot carry what we are trying to send.
class CallNetworkQuality {
  int bitrate = 32000;
  int _healthy = 0;

  /// Polls to leave the bandwidth estimate alone after stepping up. WebRTC
  /// never probes above the ceiling it is given, so right after the ceiling
  /// rises the estimate still describes the old one; judging it then would
  /// step straight back down.
  int _grace = 0;

  /// Whether any feedback has arrived. Before it, [bars] says nothing.
  bool _measured = false;

  /// The link is short of what we send when its estimate is under this share
  /// of our [budget]: then a step down, before the picture freezes.
  static const double _shortOfBudget = 0.7;

  /// And clear of it at this share: one condition for climbing back up.
  static const double _clearOfBudget = 0.9;

  /// The signal bars on the call screen: 0 while nothing is known, then 4 on
  /// a healthy link, 3 and 2 at the two reduced steps. Read off the same
  /// ladder the codec follows, so the bars and what is actually sent agree.
  int get bars => !_measured
      ? 0
      : switch (bitrate) {
          32000 => 4,
          24000 => 3,
          _ => 2,
        };

  /// One poll. [loss] and [rtt] as the other side reports them, or the
  /// connection's own round trip for [rtt] when it does not. [available] is
  /// WebRTC's estimate of what the link can carry out of this phone, in
  /// bits a second, and [budget] what the current step asks of it — speech
  /// plus the picture when the camera is on.
  void sample({double? loss, double? rtt, int? available, int? budget}) {
    if (loss != null && (!loss.isFinite || loss < 0 || loss > 1)) loss = null;
    if (rtt != null && (!rtt.isFinite || rtt < 0)) rtt = null;
    if (available != null && available <= 0) available = null;
    if (budget != null && budget <= 0) budget = null;
    if (loss != null || rtt != null || available != null) _measured = true;
    var target = (loss != null && loss >= 0.08) || (rtt != null && rtt >= 0.6)
        ? 16000
        : (loss != null && loss >= 0.03) || (rtt != null && rtt >= 0.3)
            ? 24000
            : 32000;
    if (_grace > 0) {
      _grace--;
    } else if (available != null &&
        budget != null &&
        available < budget * _shortOfBudget) {
      final lower = bitrate > 24000 ? 24000 : 16000;
      if (lower < target) target = lower;
    }
    if (target < bitrate) {
      bitrate = target;
      _healthy = 0;
      return;
    }
    // Missing RTCP is not evidence of recovery; a silent or broken connection
    // must not turn the bandwidth ceiling back up. WebRTC's own estimate is
    // evidence, though: with it and a known round trip, a link that is clear
    // of what we send counts as healthy even when the other side reports no
    // loss figure.
    final lossOk = loss != null ? loss < 0.02 : available != null;
    final rttOk = rtt != null && rtt < 0.25;
    final linkClear = available == null ||
        budget == null ||
        available >= budget * _clearOfBudget;
    if (!lossOk || !rttOk || !linkClear) {
      _healthy = 0;
      return;
    }
    if (++_healthy >= 8) {
      if (bitrate < 32000) _grace = 2;
      bitrate = 32000;
      _healthy = 0;
    }
  }
}
