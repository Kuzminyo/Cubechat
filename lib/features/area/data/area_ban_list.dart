import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';

import '../../../core/util/debug_log.dart';
import '../../moderation/data/ban_list_controller.dart' show banListPublicKeyHex;

/// What a moderator removed from the area chat: event ids, and keys that are
/// no longer accepted. Only the last day — a key lives six hours at most.
@immutable
class AreaBanList {
  const AreaBanList({
    this.updatedAt = 0,
    this.events = const <String>{},
    this.keys = const <String>{},
  });

  final int updatedAt;
  final Set<String> events;
  final Set<String> keys;
}

/// The bytes `canonicalAreaBanBody` in `push/src/index.js` signs: keys in
/// this order, arrays sorted, no `sig`.
///
/// **Not the general `/banned`.** Its canonical form is built from known
/// fields, and a new field in the signed body would break the check in every
/// installed build — they would stop applying the whole list (spec, «Бан не
/// попадает в общий /banned»). Hence a list and a route of its own.
String canonicalAreaBanBody(Map<String, dynamic> body) {
  List<String> sorted(String key) =>
      List<String>.of((body[key] as List<dynamic>).cast<String>())..sort();
  return jsonEncode(<String, Object?>{
    'v': body['v'],
    'updatedAt': body['updatedAt'],
    'events': sorted('events'),
    'keys': sorted('keys'),
  });
}

/// The signed list, or null for anything forged or malformed.
Future<AreaBanList?> verifyAreaBanList(
  Map<String, dynamic> body, {
  String publicKeyHex = banListPublicKeyHex,
}) async {
  try {
    if (body['v'] != 1 || body['updatedAt'] is! int || body['sig'] is! String) {
      return null;
    }
    final hex64 = RegExp(r'^[0-9a-f]{64}$');
    for (final field in const ['events', 'keys']) {
      final list = body[field];
      if (list is! List || list.any((e) => e is! String || !hex64.hasMatch(e))) {
        return null;
      }
    }
    final sig = _unhex(body['sig'] as String);
    final ok = await Ed25519().verify(
      utf8.encode(canonicalAreaBanBody(body)),
      signature: Signature(
        sig,
        publicKey: SimplePublicKey(
          _unhex(publicKeyHex),
          type: KeyPairType.ed25519,
        ),
      ),
    );
    if (!ok) return null;
    return AreaBanList(
      updatedAt: body['updatedAt'] as int,
      events: (body['events'] as List).cast<String>().toSet(),
      keys: (body['keys'] as List).cast<String>().toSet(),
    );
  } catch (_) {
    return null;
  }
}

List<int> _unhex(String hex) {
  if (hex.length.isOdd) throw const FormatException('odd hex');
  return [
    for (var i = 0; i < hex.length; i += 2)
      int.parse(hex.substring(i, i + 2), radix: 16),
  ];
}

/// Fetches the body of `GET /banned/area`; null on any failure.
typedef AreaBanFetcher = Future<Map<String, dynamic>?> Function();

const String kAreaBanListUrl = 'https://push.cubechat.tech/banned/area';

Future<Map<String, dynamic>?> fetchAreaBanList() async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
  try {
    final request = await client.getUrl(Uri.parse(kAreaBanListUrl));
    final response =
        await request.close().timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      await response.drain<void>();
      return null;
    }
    final text = await response
        .transform(utf8.decoder)
        .join()
        .timeout(const Duration(seconds: 15));
    if (text.length > 512 * 1024) return null;
    final decoded = jsonDecode(text);
    return decoded is Map<String, dynamic> ? decoded : null;
  } catch (e) {
    DebugLog.instance.log('AREA', 'ban list unavailable: $e');
    return null;
  } finally {
    client.close(force: true);
  }
}
