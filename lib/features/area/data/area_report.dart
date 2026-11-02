import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/transport/nostr/nostr_event.dart';
import '../../../core/transport/nostr/nostr_pow.dart';
import '../../../core/transport/nostr/nostr_signer.dart';
import '../../../core/util/debug_log.dart';
import '../../moderation/domain/report.dart';
import '../domain/area_event.dart';

/// POSTs [body] to [endpoint]; the status, or -1 for no answer.
typedef AreaReportPoster = Future<int> Function(Uri endpoint, String body);

Future<int> _defaultPost(Uri endpoint, String body) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 12);
  try {
    final request = await client.postUrl(endpoint);
    request.headers.contentType = ContentType.json;
    request.write(body);
    final response =
        await request.close().timeout(const Duration(seconds: 20));
    await response.drain<void>();
    return response.statusCode;
  } catch (e) {
    DebugLog.instance.log('AREA', 'report: ${endpoint.host} did not answer: $e');
    return -1;
  } finally {
    client.close(force: true);
  }
}

/// Mines [bits] of work into [unsigned]; `Isolate.run` in the app.
typedef AreaMiner = Future<NostrEvent> Function(NostrEvent unsigned, int bits);

Future<NostrEvent> mineOffThread(NostrEvent unsigned, int bits) =>
    Isolate.run(() => mineNonce(unsigned, bits), debugName: 'area-pow');

/// A report from the area chat.
///
/// **Not signed with the account's Nostr key** (spec, «Две вещи отличаются»):
/// the report server would learn "account X was reading city Y", the very link
/// the area chat does not have. Signed with a key made for this one report —
/// not even the reporter's area key, so the report is not tied to their name
/// in the chat either — with 16 bits of work, and limited by address on the
/// server (10 an hour).
///
/// Sent once and not queued: a queue would be a file on disk saying which
/// city was read, and the reported event is gone within a day anyway.
class AreaReporter {
  AreaReporter({
    AreaReportPoster? post,
    AreaMiner? mine,
    DateTime Function()? clock,
  })  : _post = post ?? _defaultPost,
        _mine = mine ?? mineOffThread,
        _clock = clock ?? DateTime.now;

  final AreaReportPoster _post;
  final AreaMiner _mine;
  final DateTime Function() _clock;

  static final Uri endpoint = Uri.parse('https://push.cubechat.tech/report');

  /// Same kind and tag as every other report (`push/src/index.js`).
  static const int reportKind = 24242;

  /// True if the server took it.
  Future<bool> send({
    required ReportReason reason,
    required String authorKey,
    required String eventId,
    required String geohash,
    required String text,
    required int sentAtSeconds,
    String? note,
  }) async {
    final report = ModerationReport(
      reason: reason,
      note: note,
      context: ReportContext.area,
      target: authorKey,
      eventId: eventId,
      geohash: geohash,
      messageText: text,
      messageKind: ReportedKind.text,
      messageSentAt: sentAtSeconds * 1000,
    );
    try {
      final rand = Random.secure();
      final signer = await Secp256k1NostrSigner.deriveFromSeed(
        Uint8List.fromList(List.generate(32, (_) => rand.nextInt(256))),
      );
      final mined = await _mine(
        NostrEvent(
          pubkey: signer.npubHex,
          createdAt: _clock().millisecondsSinceEpoch ~/ 1000,
          kind: reportKind,
          tags: const [
            ['action', 'report'],
          ],
          content: jsonEncode(report.toJson()),
        ),
        kAreaReportPowBits,
      );
      final signed = await signer.sign(mined);
      final status = await _post(endpoint, jsonEncode(signed.toJson()));
      return status == 200;
    } catch (e) {
      DebugLog.instance.log('AREA', 'report not sent: $e');
      return false;
    }
  }
}

final areaReporterProvider = Provider<AreaReporter>((ref) => AreaReporter());
