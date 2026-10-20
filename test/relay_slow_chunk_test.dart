import 'dart:async';

import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/mtu_budget.dart';
import 'package:flutter_test/flutter_test.dart';

/// Files over the relay on a crawling link: smaller pieces, text first, and a
/// dropout waited out on the same chunk instead of failing the transfer.
void main() {
  group('chunk size', () {
    test('a slow link cuts relay chunks to 16 KiB', () {
      expect(relayMediaChunkData(ceiling: 1 << 20, slow: true), 16 * 1024);
      expect(relayMediaChunkData(ceiling: 1 << 20), kRelayMediaChunkData);
    });

    test('the slow chunk is still clamped by the type it is written into', () {
      expect(relayMediaChunkData(ceiling: 4096, slow: true), 4096);
    });

    test('a small file on a slow link goes in 16 KiB pieces', () {
      expect(
        relayFileChunkData(
          size: 1024 * 1024,
          maxChunks: FileChunk.maxChunks,
          ceiling: FileChunk.maxDataBytes,
          slow: true,
        ),
        kRelaySlowMediaChunkData,
      );
    });

    test('the largest relay file still fits the chunk counter when slow', () {
      // 8192 × 16 KiB is 128 MiB, half the internet ceiling. Without the step
      // up a 200 MB file sent on a slow link would throw "too many chunks"
      // before its first byte.
      const size = MessagingService.maxFileBytesRelay;
      final data = relayFileChunkData(
        size: size,
        maxChunks: FileChunk.maxChunks,
        ceiling: FileChunk.maxDataBytes,
        slow: true,
      );
      expect((size + data - 1) ~/ data, lessThanOrEqualTo(FileChunk.maxChunks));
      expect(data, lessThanOrEqualTo(kRelayMediaChunkData));
    });

    test('a fast link sizes a file exactly as before', () {
      for (final size in [1, 1 << 20, MessagingService.maxFileBytesRelay]) {
        expect(
          relayFileChunkData(
            size: size,
            maxChunks: FileChunk.maxChunks,
            ceiling: FileChunk.maxDataBytes,
          ),
          relayMediaChunkData(ceiling: FileChunk.maxDataBytes),
        );
      }
    });
  });

  group('a chunk on a slow link', () {
    ({bool sent, Duration gap}) ok(Duration g) => (sent: true, gap: g);
    ({bool sent, Duration gap}) refused(Duration g) => (sent: false, gap: g);

    test('a fast link neither yields nor waits — a refusal fails as before',
        () async {
      var yields = 0;
      var waits = 0;
      var attempts = 0;
      final r = await MessagingService.deliverMediaChunkPatiently(
        slow: () => false,
        yieldToText: () async => yields++,
        routeBack: () async {
          waits++;
          return true;
        },
        deliver: (gap) async {
          attempts++;
          return refused(gap);
        },
        gap: Duration.zero,
      );
      expect(r.sent, isFalse);
      expect((yields, waits, attempts), (0, 0, 1));
    });

    test('a slow link lets a text go first', () async {
      final order = <String>[];
      final r = await MessagingService.deliverMediaChunkPatiently(
        slow: () => true,
        yieldToText: () async => order.add('yield'),
        routeBack: () async => true,
        deliver: (gap) async {
          order.add('chunk');
          return ok(gap);
        },
        gap: Duration.zero,
      );
      expect(r.sent, isTrue);
      expect(order, ['yield', 'chunk']);
    });

    test('a dropout is waited out and the same chunk is tried again', () async {
      var attempts = 0;
      var waits = 0;
      final r = await MessagingService.deliverMediaChunkPatiently(
        slow: () => true,
        yieldToText: () async {},
        routeBack: () async {
          waits++;
          return true;
        },
        deliver: (gap) async => ++attempts == 1 ? refused(gap * 2) : ok(gap),
        gap: const Duration(milliseconds: 10),
      );
      expect(r.sent, isTrue);
      expect(attempts, 2);
      expect(waits, 1);
      // The pacing the relay asked for on the refusal is kept.
      expect(r.gap, const Duration(milliseconds: 20));
    });

    test('a route that never comes back fails the chunk without a retry',
        () async {
      var attempts = 0;
      final r = await MessagingService.deliverMediaChunkPatiently(
        slow: () => true,
        yieldToText: () async {},
        routeBack: () async => false,
        deliver: (gap) async {
          attempts++;
          return refused(gap);
        },
        gap: Duration.zero,
      );
      expect(r.sent, isFalse);
      expect(attempts, 1);
    });

    test('a retry after the wait that fails too fails the chunk', () async {
      var attempts = 0;
      final r = await MessagingService.deliverMediaChunkPatiently(
        slow: () => true,
        yieldToText: () async {},
        routeBack: () async => true,
        deliver: (gap) async {
          attempts++;
          return refused(gap);
        },
        gap: Duration.zero,
      );
      expect(r.sent, isFalse);
      expect(attempts, 2);
    });
  });

  group('waiting for a route', () {
    test('returns at once when the route is already there', () async {
      final changes = StreamController<Object?>.broadcast();
      addTearDown(changes.close);
      expect(
        await MessagingService.awaitRoute(
          hasRoute: () => true,
          changes: changes.stream,
          max: const Duration(minutes: 5),
        ),
        isTrue,
      );
    });

    test('wakes on the change that brings the route back', () async {
      final changes = StreamController<Object?>.broadcast();
      addTearDown(changes.close);
      var up = false;
      final waited = Stopwatch()..start();
      final result = MessagingService.awaitRoute(
        hasRoute: () => up,
        changes: changes.stream,
        max: const Duration(minutes: 5),
      );
      await Future<void>.delayed(const Duration(milliseconds: 20));
      changes.add(null); // a change that is not the route yet
      await Future<void>.delayed(const Duration(milliseconds: 20));
      up = true;
      changes.add(null);
      expect(await result, isTrue);
      expect(waited.elapsed, lessThan(const Duration(seconds: 5)));
    });

    test('gives up after max', () async {
      final changes = StreamController<Object?>.broadcast();
      addTearDown(changes.close);
      expect(
        await MessagingService.awaitRoute(
          hasRoute: () => false,
          changes: changes.stream,
          max: const Duration(milliseconds: 50),
        ),
        isFalse,
      );
    });

    test('a stream that closes ends the wait without a route', () async {
      final changes = StreamController<Object?>.broadcast();
      final result = MessagingService.awaitRoute(
        hasRoute: () => false,
        changes: changes.stream,
        max: const Duration(minutes: 5),
      );
      await changes.close();
      expect(await result, isFalse);
    });
  });

  group('yielding to a text', () {
    test('nothing ahead: no wait', () async {
      var asked = 0;
      await MessagingService.awaitTextsAhead(
        textAhead: () => false,
        textLeft: () async => asked++,
        max: const Duration(seconds: 30),
      );
      expect(asked, 0);
    });

    test('waits until the texts ahead have left, signal by signal', () async {
      var ahead = 2;
      var signals = 0;
      await MessagingService.awaitTextsAhead(
        textAhead: () => ahead > 0,
        textLeft: () async {
          signals++;
          ahead--;
        },
        max: const Duration(seconds: 30),
      );
      expect(ahead, 0);
      expect(signals, 2);
    });

    test('never waits past max for a text that does not leave', () async {
      final waited = Stopwatch()..start();
      await MessagingService.awaitTextsAhead(
        textAhead: () => true,
        textLeft: () => Completer<void>().future,
        max: const Duration(milliseconds: 50),
      );
      expect(waited.elapsed, lessThan(const Duration(seconds: 5)));
    });
  });
}
