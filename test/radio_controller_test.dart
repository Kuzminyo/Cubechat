import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/audio/radio_audio.dart';
import 'package:cubechat/core/crypto/radio_crypto.dart';
import 'package:cubechat/core/storage/hive_cipher.dart';
import 'package:cubechat/core/storage/hive_init.dart';
import 'package:cubechat/core/transport/radio_chunk.dart';
import 'package:cubechat/features/radio/data/radio_controller.dart';
import 'package:cubechat/features/radio/data/radio_inbound.dart';
import 'package:cubechat/features/radio/data/radio_ports.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

final _base = DateTime.fromMillisecondsSinceEpoch(1760000000000);

class _FakeSender implements RadioSender {
  _FakeSender(this.now);
  final DateTime Function() now;
  final sent = <({DateTime at, RadioChunk chunk, String to})>[];

  @override
  Future<int> toContact(String canonicalId, RadioChunk chunk) async {
    sent.add((at: now(), chunk: chunk, to: canonicalId));
    return 1;
  }

  @override
  Future<int> toGroup(Uint8List key, Uint8List tag, RadioChunk chunk) async {
    sent.add((at: now(), chunk: chunk, to: radioHex(tag)));
    return 1;
  }
}

class _FakeMic implements RadioMicrophone {
  bool allow = true;
  int opens = 0;
  int closes = 0;
  StreamController<Uint8List>? _ctrl;

  void emit(Uint8List pcm) => _ctrl?.add(pcm);

  @override
  Future<Stream<Uint8List>?> open() async {
    opens++;
    if (!allow) return null;
    _ctrl = StreamController<Uint8List>(sync: true);
    return _ctrl!.stream;
  }

  @override
  Future<void> close() async => closes++;
}

/// Encodes a frame as its first sample; decodes packet `[a, b]` into 960
/// samples of `a * 100 + b`, so a test can read off which frame of which
/// chunk was played where.
class _FakeCodec implements RadioCodec {
  @override
  RadioEncoder encoder() => _Enc();
  @override
  RadioDecoder decoder() => _Dec();
}

class _Enc implements RadioEncoder {
  @override
  Uint8List encode(Int16List frame) =>
      Uint8List.fromList([frame[0] & 0xFF, (frame[0] >> 8) & 0xFF]);
  @override
  void dispose() {}
}

class _Dec implements RadioDecoder {
  @override
  Int16List decode(Uint8List packet) =>
      Int16List(960)..fillRange(0, 960, packet[0] * 100 + packet[1]);
  @override
  void dispose() {}
}

class _FakeSink implements RadioAudioSink {
  _FakeSink(this.now);
  final DateTime Function() now;
  final events = <({String what, DateTime at})>[];
  final written = <Int16List>[];

  @override
  Future<void> start({required bool playInSilentMode}) async =>
      events.add((what: 'start', at: now()));

  @override
  Future<void> write(Int16List pcm) async {
    written.add(pcm);
    events.add((what: 'write', at: now()));
  }

  @override
  Future<void> stop() async => events.add((what: 'stop', at: now()));

  /// First sample of every 20 ms frame played, in order.
  List<int> get frameMarks => [
        for (final w in written)
          for (var i = 0; i < w.length; i += 960) w[i],
      ];
}

class _MemoryStore implements RadioGroupStore {
  final groups = <String, StoredRadioGroup>{};
  bool? silent;

  @override
  Future<List<StoredRadioGroup>> loadGroups() async => groups.values.toList();
  @override
  Future<void> putGroup(StoredRadioGroup stored) async =>
      groups[stored.group.tagHex] = stored;
  @override
  Future<void> deleteGroup(String tagHex) async => groups.remove(tagHex);
  @override
  Future<void> clearGroups() async => groups.clear();
  @override
  Future<bool?> loadPlayInSilentMode() async => silent;
  @override
  Future<void> savePlayInSilentMode(bool value) async => silent = value;
}

/// Stands in for MessagingService, which owns the inbound stream: each build
/// hands out a new one, as the real service does when it is rebuilt.
final _fakeService = Provider<StreamController<RadioInbound>>((ref) {
  final c = StreamController<RadioInbound>.broadcast(sync: true);
  ref.onDispose(() => unawaited(c.close()));
  return c;
});

/// Everything around the controller, faked, inside one fakeAsync zone.
class _Rig {
  _Rig(this.async) {
    sender = _FakeSender(now);
    sink = _FakeSink(now);
    container = ProviderContainer(
      overrides: [
        radioInboundProvider.overrideWith(
          (ref) => ref.watch(_fakeService).stream,
        ),
        radioSenderProvider.overrideWithValue(sender),
        radioMicrophoneProvider.overrideWithValue(mic),
        radioCodecProvider.overrideWithValue(_FakeCodec()),
        radioAudioProvider.overrideWithValue(sink),
        radioClockProvider.overrideWithValue(now),
        radioCallBusyProvider.overrideWithValue(() => callBusy),
        radioGroupStoreProvider.overrideWithValue(store),
      ],
    );
    container.read(radioControllerProvider);
    async.flushMicrotasks();
  }

  final FakeAsync async;

  /// The current service's inbound stream - a new one after [restartService].
  StreamController<RadioInbound> get inbound => container.read(_fakeService);

  /// What an Emergency Wipe does to the real transport: invalidates it, and
  /// whoever reads it next gets a new service with a new stream.
  void restartService() {
    final old = inbound;
    container.invalidate(_fakeService);
    expect(identical(inbound, old), isFalse);
    // Riverpod refreshes a listened dependent on its scheduler's next turn.
    async.elapse(Duration.zero);
  }

  final mic = _FakeMic();
  final store = _MemoryStore();
  late final _FakeSender sender;
  late final _FakeSink sink;
  late final ProviderContainer container;
  bool callBusy = false;

  DateTime now() => _base.add(async.elapsed);
  int get nowMs => now().millisecondsSinceEpoch;

  RadioController get ctl => container.read(radioControllerProvider.notifier);
  RadioState get state => container.read(radioControllerProvider);

  RadioRoom join(String name) {
    RadioRoom? g;
    ctl.joinGroup(name, '').then((v) => g = v);
    async.flushMicrotasks();
    return g!;
  }

  bool? press() {
    bool? ok;
    ctl.pressToTalk().then((v) => ok = v);
    async.flushMicrotasks();
    return ok;
  }

  void release() {
    ctl.releaseToTalk();
    async.flushMicrotasks();
  }

  void hear(String sender, RadioRoom? group, RadioChunk chunk) {
    inbound.add(
      RadioInbound(
        senderId: sender,
        groupTag: group == null ? null : radioUnhex(group.tagHex),
        chunk: chunk,
      ),
    );
    async.flushMicrotasks();
  }

  void dispose() {
    container.dispose();
    async.flushMicrotasks();
  }
}

/// [ms] milliseconds of 48 kHz PCM16, little-endian, every sample [value].
Uint8List _pcm(int ms, {int value = 7}) {
  final samples = 48 * ms;
  final out = Uint8List(samples * 2);
  final bd = ByteData.sublistView(out);
  for (var i = 0; i < samples; i++) {
    bd.setInt16(i * 2, value, Endian.little);
  }
  return out;
}

Uint8List _txId(int fill) =>
    Uint8List(RadioChunk.idLen)..fillRange(0, 16, fill);

RadioChunk _chunk(
  Uint8List tx,
  int seq,
  int startedAtMs, {
  bool last = false,
}) =>
    RadioChunk(
      transmissionId: tx,
      seq: seq,
      isLast: last,
      startedAtMs: startedAtMs,
      frames: [
        for (var i = 0; i < RadioChunk.framesPerChunk; i++)
          Uint8List.fromList([seq, i]),
      ],
    );

/// Captures `[RADIO]` lines for the duration of a test.
List<String> _captureRadioLog() {
  final lines = <String>[];
  final previous = debugPrint;
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && message.startsWith('[RADIO]')) lines.add(message);
  };
  addTearDown(() => debugPrint = previous);
  return lines;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('talking', () {
    test(
        'holding the button sends at most four chunks a second and stops on '
        'release', () {
      final log = _captureRadioLog();
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);

        expect(rig.press(), isTrue);
        expect(rig.state.floor, isA<Talking>());
        expect(rig.mic.opens, 1);

        // Three seconds of microphone, arriving as it is spoken.
        for (var i = 0; i < 30; i++) {
          rig.mic.emit(_pcm(100));
          async.elapse(const Duration(milliseconds: 100));
        }
        final held = rig.sender.sent.length;
        expect(held, inInclusiveRange(9, 11));
        for (final s in rig.sender.sent) {
          final inWindow = rig.sender.sent
              .where(
                (o) =>
                    !o.at.isBefore(s.at) &&
                    o.at.isBefore(s.at.add(const Duration(seconds: 1))),
              )
              .length;
          expect(inWindow, lessThanOrEqualTo(4), reason: 'window at ${s.at}');
        }
        expect(rig.sender.sent.every((s) => s.to == g.tagHex), isTrue);

        rig.release();
        final total = rig.sender.sent.length;
        expect(total, inInclusiveRange(9, 11));
        expect(rig.sender.sent.last.chunk.isLast, isTrue);
        expect(rig.mic.closes, 1);
        expect(rig.state.floor, isA<Idle>());

        // Whatever the microphone still says, and however long we wait,
        // nothing more goes out.
        rig.mic.emit(_pcm(1000));
        async.elapse(const Duration(seconds: 3));
        expect(rig.sender.sent.length, total);

        final seqs = rig.sender.sent.map((s) => s.chunk.seq).toList();
        expect(seqs, List<int>.generate(total, (i) => i));
        rig.dispose();
      });
      expect(log, [
        '[RADIO] sent 11 chunks in 3.0 s',
      ]);
    });

    test('pressing while the floor is busy is refused and records nothing', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        rig.hear('bob', g, _chunk(_txId(9), 0, rig.nowMs));
        expect(rig.state.floor, isA<Listening>());

        expect(rig.press(), isFalse);
        expect(rig.state.blockedReason, RadioBlockedReason.busy);
        expect(rig.mic.opens, 0);
        async.elapse(const Duration(seconds: 1));
        expect(rig.sender.sent, isEmpty);
        rig.dispose();
      });
    });

    test('the button stays busy until the last speaker has finished playing',
        () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        // A one-chunk press: the floor is free the moment it arrives.
        rig.hear('bob', g, _chunk(_txId(9), 0, rig.nowMs, last: true));
        expect(rig.state.floor, isA<Idle>());
        expect(rig.state.speakerBusy, isTrue);

        async.elapse(const Duration(milliseconds: 200));
        expect(rig.sink.written, isNotEmpty);
        expect(rig.state.speakerBusy, isTrue);
        expect(rig.press(), isFalse);
        expect(rig.state.blockedReason, RadioBlockedReason.busy);
        expect(rig.mic.opens, 0);

        // 300 ms of sound plus the stop margin later the speaker is let go.
        async.elapse(const Duration(seconds: 1));
        expect(rig.sink.events.last.what, 'stop');
        expect(rig.state.speakerBusy, isFalse);
        expect(rig.press(), isTrue);
        rig.release();
        rig.dispose();
      });
    });

    test('losing a collision stops the recording', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final pressedAt = rig.nowMs;
        expect(rig.press(), isTrue);
        for (var i = 0; i < 6; i++) {
          rig.mic.emit(_pcm(100));
          async.elapse(const Duration(milliseconds: 100));
        }
        final before = rig.sender.sent.length;
        expect(before, 2);

        // Bob pressed 100 ms before us: his press wins on every phone.
        rig.hear('bob', g, _chunk(_txId(9), 0, pressedAt - 100));
        expect(rig.state.floor, isA<Listening>());
        expect(rig.mic.closes, 1);

        rig.mic.emit(_pcm(1000));
        async.elapse(const Duration(seconds: 1));
        expect(rig.sender.sent.length, before);
        rig.dispose();
      });
    });

    test('a refused microphone says so and leaves the floor free', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        rig.mic.allow = false;
        rig.ctl.select(rig.join('#patrol'));
        expect(rig.press(), isFalse);
        expect(rig.state.blockedReason, RadioBlockedReason.microphone);
        expect(rig.state.floor, isA<Idle>());
        async.elapse(const Duration(seconds: 1));
        expect(rig.sender.sent, isEmpty);
        rig.dispose();
      });
    });

    test('during a call the radio neither talks nor plays', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        rig.callBusy = true;
        expect(rig.press(), isFalse);
        expect(rig.state.blockedReason, RadioBlockedReason.call);
        expect(rig.mic.opens, 0);

        final tx = _txId(9);
        final start = rig.nowMs;
        for (var s = 0; s < 3; s++) {
          rig.hear('bob', g, _chunk(tx, s, start, last: s == 2));
        }
        async.elapse(const Duration(seconds: 3));
        expect(rig.sink.written, isEmpty);
        expect(rig.state.floor, isA<Idle>());
        rig.dispose();
      });
    });

    test('a contact channel talks to that contact', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        rig.ctl.select(const RadioContact('bob'));
        expect(rig.press(), isTrue);
        rig.mic.emit(_pcm(300));
        rig.release();
        expect(rig.sender.sent.map((s) => s.to).toSet(), {'bob'});
        rig.dispose();
      });
    });

    test('a press held past a minute is ended for the user', () {
      final log = _captureRadioLog();
      fakeAsync((async) {
        final rig = _Rig(async);
        rig.ctl.select(rig.join('#patrol'));
        expect(rig.press(), isTrue);
        // 59.9 s of speech: still recording.
        for (var i = 0; i < 599; i++) {
          rig.mic.emit(_pcm(100));
          async.elapse(const Duration(milliseconds: 100));
        }
        expect(rig.mic.closes, 0);
        expect(rig.state.floor, isA<Talking>());
        // The finger never lifts; at 60 s the radio lets go itself.
        rig.mic.emit(_pcm(100));
        async.elapse(const Duration(milliseconds: 100));
        expect(rig.mic.closes, 1);
        expect(rig.state.floor, isA<Idle>());
        expect(rig.state.blockedReason, RadioBlockedReason.tooLong);
        expect(rig.sender.sent.last.chunk.isLast, isTrue);

        for (var i = 0; i < 10; i++) {
          rig.mic.emit(_pcm(100));
          async.elapse(const Duration(milliseconds: 100));
        }
        expect(rig.sender.sent.length, lessThanOrEqualTo(201));
        // A late release is harmless.
        rig.release();
        expect(rig.sender.sent.length, lessThanOrEqualTo(201));
        rig.dispose();
      });
      expect(log, ['[RADIO] sent 201 chunks in 60.0 s, cut at 60 s']);
    });
  });

  group('listening', () {
    test('a rebuilt messaging service is still heard', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        rig.restartService();
        rig.hear('bob', g, _chunk(_txId(9), 0, rig.nowMs, last: true));
        async.elapse(const Duration(seconds: 2));
        expect(rig.sink.frameMarks, [for (var f = 0; f < 15; f++) f]);
        rig.dispose();
      });
    });

    test('a call does not keep the floor busy after the speaker stops', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        rig.hear('bob', g, _chunk(_txId(9), 0, rig.nowMs));
        expect(rig.state.floor, isA<Listening>());
        rig.callBusy = true;
        async.elapse(const Duration(seconds: 2));
        expect(rig.state.floor, isA<Idle>());
        rig.dispose();
      });
    });

    test('inbound chunks of the active channel reach the audio sink in order',
        () {
      final log = _captureRadioLog();
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final tx = _txId(9);
        final start = rig.nowMs;

        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 1, start));
        rig.hear('bob', g, _chunk(tx, 0, start));
        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 3, start));
        rig.hear('bob', g, _chunk(tx, 2, start));
        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 4, start, last: true));
        async.elapse(const Duration(seconds: 4));

        expect(rig.sink.frameMarks, [
          for (var s = 0; s < 5; s++)
            for (var f = 0; f < RadioChunk.framesPerChunk; f++) s * 100 + f,
        ]);
        final events = rig.sink.events;
        expect(events.first.what, 'start');
        expect(events.last.what, 'stop');
        expect(events.where((e) => e.what == 'stop').length, 1);
        // 1.5 s of speech went in; the speaker is not let go before it has
        // had the time to play it.
        final firstWrite = events.firstWhere((e) => e.what == 'write').at;
        expect(
          events.last.at.difference(firstWrite),
          greaterThanOrEqualTo(const Duration(milliseconds: 1500)),
        );
        expect(rig.state.floor, isA<Idle>());
        rig.dispose();
      });
      expect(log.where((l) => l.startsWith('[RADIO] heard')), [
        '[RADIO] heard 5 chunks, 0.3 s latency, 0 lost',
      ]);
    });

    test('a hole is played as silence and counted as lost', () {
      final log = _captureRadioLog();
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final tx = _txId(9);
        final start = rig.nowMs;
        for (final s in [0, 2, 3]) {
          rig.hear('bob', g, _chunk(tx, s, start, last: s == 3));
        }
        async.elapse(const Duration(seconds: 4));
        expect(rig.sink.frameMarks, [
          for (var f = 0; f < 15; f++) f,
          for (var f = 0; f < 15; f++) 0,
          for (var f = 0; f < 15; f++) 200 + f,
          for (var f = 0; f < 15; f++) 300 + f,
        ]);
        rig.dispose();
      });
      expect(log.where((l) => l.startsWith('[RADIO] heard')), [
        '[RADIO] heard 3 chunks, 0.0 s latency, 1 lost',
      ]);
    });

    test('a transmission whose last chunk is lost lets the speaker go', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final tx = _txId(9);
        final start = rig.nowMs;
        rig.hear('bob', g, _chunk(tx, 0, start));
        rig.hear('bob', g, _chunk(tx, 1, start));
        async.elapse(const Duration(seconds: 4));
        expect(rig.state.floor, isA<Idle>());
        expect(rig.sink.events.last.what, 'stop');

        // The next press is heard from its start, not refused as "another
        // transmission while one is still playing".
        final tx2 = _txId(5);
        final start2 = rig.nowMs;
        rig.hear('carol', g, _chunk(tx2, 0, start2, last: true));
        async.elapse(const Duration(seconds: 2));
        expect(
          rig.sink.frameMarks.sublist(30),
          [for (var f = 0; f < 15; f++) f],
        );
        // The speaker is started afresh for each transmission.
        expect(rig.sink.events.where((e) => e.what == 'start').length, 2);
        rig.dispose();
      });
    });

    test('a stall of more than a second mid-sentence does not lose the rest',
        () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final tx = _txId(9);
        final start = rig.nowMs;
        for (var s = 0; s < 3; s++) {
          rig.hear('bob', g, _chunk(tx, s, start));
          async.elapse(const Duration(milliseconds: 300));
        }
        // The link stalls for 1.5 s: the floor's 1 s tail lets go.
        async.elapse(const Duration(milliseconds: 1200));
        expect(rig.state.floor, isA<Idle>());

        // The rest of the sentence comes through.
        rig.hear('bob', g, _chunk(tx, 3, start));
        expect(rig.state.floor, isA<Listening>(), reason: 'busy again');
        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 4, start));
        expect(rig.state.floor, isA<Listening>());
        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 5, start, last: true));
        async.elapse(const Duration(seconds: 3));

        final marks = rig.sink.frameMarks;
        for (var s = 3; s < 6; s++) {
          expect(
            marks.where((m) => m ~/ 100 == s).length,
            RadioChunk.framesPerChunk,
            reason: 'chunk $s played',
          );
        }
        expect(rig.state.floor, isA<Idle>());
        rig.dispose();
      });
    });

    test('a sender whose clock is six seconds behind is heard', () {
      final log = _captureRadioLog();
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final tx = _txId(9);
        final start = rig.nowMs - 6000;
        rig.hear('bob', g, _chunk(tx, 0, start));
        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 1, start, last: true));
        async.elapse(const Duration(seconds: 3));
        expect(rig.sink.frameMarks, [
          for (var s = 0; s < 2; s++)
            for (var f = 0; f < RadioChunk.framesPerChunk; f++) s * 100 + f,
        ]);
        rig.dispose();
      });
      expect(log.where((l) => l.contains('drop tx')), isEmpty);
    });

    test('a sender a minute out is dropped with one line, not one per chunk',
        () {
      final log = _captureRadioLog();
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final start = rig.nowMs - 61000;
        for (var s = 0; s < 5; s++) {
          rig.hear('bob', g, _chunk(_txId(9), s, start));
          async.elapse(const Duration(milliseconds: 300));
        }
        // Another stale press within ten seconds: no second line yet.
        rig.hear('bob', g, _chunk(_txId(8), 0, rig.nowMs - 70000));
        // Past the ten seconds, a new transmission may say so again.
        async.elapse(const Duration(seconds: 10));
        rig.hear('bob', g, _chunk(_txId(7), 0, rig.nowMs - 90000));
        rig.hear('bob', g, _chunk(_txId(7), 1, rig.nowMs - 90000));
        async.elapse(const Duration(seconds: 2));
        expect(rig.sink.written, isEmpty);
        expect(rig.state.floor, isA<Idle>());
        rig.dispose();
      });
      expect(log, [
        '[RADIO] drop tx 09090909 from bob: 61.0 s off (clock?)',
        '[RADIO] drop tx 07070707 from bob: 90.0 s off (clock?)',
      ]);
    });

    test('inbound for a channel that is not active is not played', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final a = rig.join('#patrol');
        final b = rig.join('#other');
        rig.ctl.select(a);
        final start = rig.nowMs;
        rig.hear('bob', b, _chunk(_txId(9), 0, start, last: true));
        rig.hear('bob', null, _chunk(_txId(8), 0, start, last: true));
        async.elapse(const Duration(seconds: 2));
        expect(rig.sink.events, isEmpty);
        expect(rig.state.floor, isA<Idle>());

        // Nor does it take the floor: we may still talk.
        expect(rig.press(), isTrue);
        rig.release();
        rig.dispose();
      });
    });

    test('a contact channel plays that contact and nobody else', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        rig.ctl.select(const RadioContact('bob'));
        final start = rig.nowMs;
        rig.hear('carol', null, _chunk(_txId(8), 0, start, last: true));
        async.elapse(const Duration(seconds: 2));
        expect(rig.sink.written, isEmpty);
        rig.hear('bob', null, _chunk(_txId(9), 0, rig.nowMs, last: true));
        async.elapse(const Duration(seconds: 2));
        expect(rig.sink.frameMarks, [for (var f = 0; f < 15; f++) f]);
        rig.dispose();
      });
    });
  });

  // The radio stays tuned for the life of the app, so what it costs while
  // nobody talks is what it costs for ever: a tick of ten wake-ups a second is
  // the battery the feature promised not to spend.
  group('the tick', () {
    test('a tuned channel with nobody talking runs no timer at all', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        rig.ctl.select(rig.join('#patrol'));
        expect(async.periodicTimerCount, 0);
        async.elapse(const Duration(minutes: 5));
        expect(async.periodicTimerCount, 0);
        rig.dispose();
      });
    });

    test('a heard transmission starts it and it stops by itself afterwards',
        () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        final tx = _txId(9);
        final start = rig.nowMs;

        rig.hear('bob', g, _chunk(tx, 0, start));
        expect(async.periodicTimerCount, 1);
        async.elapse(const Duration(milliseconds: 300));
        rig.hear('bob', g, _chunk(tx, 1, start, last: true));
        expect(async.periodicTimerCount, 1);

        async.elapse(const Duration(seconds: 5));
        expect(rig.sink.frameMarks, isNotEmpty);
        expect(rig.state.floor, isA<Idle>());
        expect(async.periodicTimerCount, 0);
        rig.dispose();
      });
    });

    test('a transmission whose last chunk never comes still lets it stop', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        rig.hear('bob', g, _chunk(_txId(9), 0, rig.nowMs));
        expect(async.periodicTimerCount, 1);
        async.elapse(const Duration(seconds: 6));
        expect(rig.state.floor, isA<Idle>());
        expect(async.periodicTimerCount, 0);
        rig.dispose();
      });
    });

    test('a press starts it and it stops after the release', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        rig.ctl.select(rig.join('#patrol'));
        expect(async.periodicTimerCount, 0);

        expect(rig.press(), isTrue);
        expect(async.periodicTimerCount, 1);
        rig.mic.emit(_pcm(100));
        async.elapse(const Duration(seconds: 2));
        expect(async.periodicTimerCount, 1, reason: 'still talking');

        rig.release();
        async.elapse(const Duration(seconds: 2));
        expect(rig.state.floor, isA<Idle>());
        expect(async.periodicTimerCount, 0);
        rig.dispose();
      });
    });

    test('a second transmission after the first wakes it again', () {
      fakeAsync((async) {
        final rig = _Rig(async);
        final g = rig.join('#patrol');
        rig.ctl.select(g);
        rig.hear('bob', g, _chunk(_txId(9), 0, rig.nowMs, last: true));
        async.elapse(const Duration(seconds: 4));
        expect(async.periodicTimerCount, 0);

        rig.hear('bob', g, _chunk(_txId(8), 0, rig.nowMs, last: true));
        expect(async.periodicTimerCount, 1);
        async.elapse(const Duration(seconds: 4));
        expect(async.periodicTimerCount, 0);
        expect(rig.sink.frameMarks.length, 30);
        rig.dispose();
      });
    });
  });

  group('storage', () {
    late Directory tempDir;
    late StreamController<RadioInbound> inbound;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('cubechat_radio_');
      Hive.init(tempDir.path);
      inbound = StreamController<RadioInbound>.broadcast();
    });

    tearDown(() async {
      await settleBackgroundStorage();
      await Hive.close();
      await inbound.close();
      try {
        if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
      } on FileSystemException {
        // Windows can briefly retain a Hive file handle after close.
      }
    });

    ProviderContainer fresh() {
      final c = ProviderContainer(
        overrides: [radioInboundProvider.overrideWithValue(inbound.stream)],
      );
      addTearDown(c.dispose);
      return c;
    }

    test('joining a group registers its key for inbound', () async {
      final c = fresh();
      final ctl = c.read(radioControllerProvider.notifier);
      await ctl.loaded;
      final g = await ctl.joinGroup(' #Patrol ', 'secret');

      final key = await RadioCrypto.deriveKey('#patrol', 'secret');
      final tagHex = radioHex(await RadioCrypto.deriveTag(key));
      expect(g.name, '#patrol');
      expect(g.hasPassword, isTrue);
      expect(g.tagHex, tagHex);
      expect(c.read(radioGroupKeysProvider)[tagHex], key);
      expect(c.read(radioControllerProvider).groups, [g]);

      // The key is kept, never the password.
      final box = await hiveCipherProvider
          .openEncryptedBox<dynamic>(HiveBoxes.radioGroups);
      expect(box.values.toString(), isNot(contains('secret')));

      final relaunched = fresh();
      await relaunched.read(radioControllerProvider.notifier).loaded;
      expect(relaunched.read(radioControllerProvider).groups, [g]);
      expect(relaunched.read(radioGroupKeysProvider)[tagHex], key);

      await relaunched
          .read(radioControllerProvider.notifier)
          .leaveGroup(tagHex);
      expect(relaunched.read(radioGroupKeysProvider), isEmpty);
      expect(relaunched.read(radioControllerProvider).groups, isEmpty);
    });

    test('a wipe puts play-in-silent back to on', () async {
      final c = fresh();
      final ctl = c.read(radioControllerProvider.notifier);
      await ctl.loaded;
      await ctl.setPlayInSilentMode(false);
      expect(c.read(radioControllerProvider).playInSilentMode, isFalse);
      await ctl.clear();
      expect(c.read(radioControllerProvider).playInSilentMode, isTrue);
    });

    test('play-in-silent defaults to on and survives a restart', () async {
      final c = fresh();
      final ctl = c.read(radioControllerProvider.notifier);
      await ctl.loaded;
      expect(c.read(radioControllerProvider).playInSilentMode, isTrue);
      await ctl.setPlayInSilentMode(false);
      expect(c.read(radioControllerProvider).playInSilentMode, isFalse);

      final relaunched = fresh();
      await relaunched.read(radioControllerProvider.notifier).loaded;
      expect(
        relaunched.read(radioControllerProvider).playInSilentMode,
        isFalse,
      );
    });
  });
}
