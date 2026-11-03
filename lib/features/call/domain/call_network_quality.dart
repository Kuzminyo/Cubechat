/// Limits only our outgoing speech stream; WebRTC still controls congestion
/// below this ceiling. Fast reduction, slow recovery avoids pumping the codec
/// up and down on an unstable mobile link. Thresholds are conservative policy,
/// not a claim that the user's logs contained RTP quality measurements.
class CallNetworkQuality {
  int bitrate = 32000;
  int _healthy = 0;

  /// Whether any feedback has arrived. Before it, [bars] says nothing.
  bool _measured = false;

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

  void sample({double? loss, double? rtt}) {
    if (loss != null && (!loss.isFinite || loss < 0 || loss > 1)) loss = null;
    if (rtt != null && (!rtt.isFinite || rtt < 0)) rtt = null;
    if (loss != null || rtt != null) _measured = true;
    final target = (loss != null && loss >= 0.08) || (rtt != null && rtt >= 0.6)
        ? 16000
        : (loss != null && loss >= 0.03) || (rtt != null && rtt >= 0.3)
            ? 24000
            : 32000;
    if (target < bitrate) {
      bitrate = target;
      _healthy = 0;
      return;
    }
    // Missing RTCP is not evidence of recovery; a silent or broken connection
    // must not turn the bandwidth ceiling back up.
    if (loss == null || rtt == null || loss >= 0.02 || rtt >= 0.25) {
      _healthy = 0;
      return;
    }
    if (++_healthy >= 8) {
      bitrate = 32000;
      _healthy = 0;
    }
  }
}
