import 'package:cubechat/features/call/data/call_media.dart';
import 'package:cubechat/features/call/domain/call_network_quality.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loss reduces bandwidth immediately; recovery needs sustained health',
      () {
    final quality = CallNetworkQuality();
    final normal = quality.bitrate;
    quality.sample(loss: 0.12, rtt: 0.8);
    expect(quality.bitrate, lessThan(normal));
    final constrained = quality.bitrate;
    quality.sample(loss: 0, rtt: 0.1);
    expect(quality.bitrate, constrained);
    for (var i = 0; i < 8; i++) {
      quality.sample(loss: 0, rtt: 0.1);
    }
    expect(quality.bitrate, normal);
  });

  test('missing measurements cannot restore quality', () {
    final quality = CallNetworkQuality()..sample(loss: 0.2, rtt: 1);
    final constrained = quality.bitrate;
    for (var i = 0; i < 12; i++) {
      quality.sample();
    }
    expect(quality.bitrate, constrained);
  });

  test('oscillating network does not alternate bitrate every sample', () {
    final quality = CallNetworkQuality()..sample(loss: 0.1, rtt: 0.7);
    final constrained = quality.bitrate;
    for (var i = 0; i < 10; i++) {
      quality.sample(loss: 0, rtt: 0.1);
      quality.sample(loss: 0.06, rtt: 0.4);
    }
    expect(quality.bitrate, constrained);
  });

  test('the bars say nothing until feedback arrives, then follow the ladder',
      () {
    final quality = CallNetworkQuality();
    expect(quality.bars, 0);
    quality.sample();
    expect(quality.bars, 0);
    quality.sample(loss: 0, rtt: 0.1);
    expect(quality.bars, 4);
    quality.sample(loss: 0.04, rtt: 0.1);
    expect(quality.bars, 3);
    quality.sample(loss: 0.2, rtt: 0.1);
    expect(quality.bars, 2);
  });

  group('with WebRTC\'s own bandwidth estimate', () {
    const budget = 832000; // 800 kbit/s of picture and 32 of speech.

    test('a link short of what we send steps down without any RTCP', () {
      final quality = CallNetworkQuality()
        ..sample(rtt: 0.1, available: 400000, budget: budget);
      expect(quality.bitrate, 24000);
      expect(quality.bars, 3, reason: 'an estimate is a measurement');
      // Still short of the smaller step: one more down.
      quality.sample(rtt: 0.1, available: 150000, budget: 384000);
      expect(quality.bitrate, 16000);
    });

    test('a link that carries what we send does not step down', () {
      final quality = CallNetworkQuality()
        ..sample(rtt: 0.1, available: 900000, budget: budget);
      expect(quality.bitrate, 32000);
    });

    test('a clear link climbs back with no loss figure from the other side',
        () {
      final quality = CallNetworkQuality()
        ..sample(rtt: 0.1, available: 200000, budget: budget);
      expect(quality.bitrate, lessThan(32000));
      for (var i = 0; i < 8; i++) {
        quality.sample(rtt: 0.1, available: 400000, budget: 184000);
      }
      expect(quality.bitrate, 32000);
    });

    test('right after climbing, a lagging estimate does not knock it down',
        () {
      final quality = CallNetworkQuality()
        ..sample(rtt: 0.1, available: 200000, budget: budget);
      for (var i = 0; i < 8; i++) {
        quality.sample(rtt: 0.1, available: 400000, budget: 184000);
      }
      expect(quality.bitrate, 32000);
      // The estimate still describes the old ceiling for a moment.
      quality.sample(rtt: 0.1, available: 400000, budget: budget);
      quality.sample(rtt: 0.1, available: 450000, budget: budget);
      expect(quality.bitrate, 32000, reason: 'two polls of grace');
      quality.sample(rtt: 0.1, available: 450000, budget: budget);
      expect(quality.bitrate, 24000, reason: 'then it is believed');
    });

    test('an estimate alone, with no round trip, cannot restore quality', () {
      final quality = CallNetworkQuality()
        ..sample(rtt: 0.1, available: 200000, budget: budget);
      final constrained = quality.bitrate;
      for (var i = 0; i < 12; i++) {
        quality.sample(available: 5000000, budget: budget);
      }
      expect(quality.bitrate, constrained);
    });
  });

  test('the picture steps down with the link and up to its ceiling', () {
    const good = 32000;
    const fair = 24000;
    const poor = 16000;
    final relayed = WebRtcCallMedia.videoLimits(good, relayed: true);
    expect(relayed.bitrate, WebRtcCallMedia.videoMaxBitrate);
    expect(relayed.scale, 1.0);
    // Direct: nothing crosses our server, so a good link gets more.
    final direct = WebRtcCallMedia.videoLimits(good, relayed: false);
    expect(direct.bitrate, greaterThan(relayed.bitrate));
    final reduced = WebRtcCallMedia.videoLimits(fair, relayed: true);
    final low = WebRtcCallMedia.videoLimits(poor, relayed: true);
    expect(reduced.bitrate, lessThan(relayed.bitrate));
    expect(low.bitrate, lessThan(reduced.bitrate));
    expect(low.fps, lessThan(reduced.fps));
    expect(low.scale, greaterThan(reduced.scale));
  });
}
