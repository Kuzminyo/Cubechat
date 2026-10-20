import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/transport/file_reassembly.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:flutter_test/flutter_test.dart';

Uint8List _id(int fill) => Uint8List(16)..fillRange(0, 16, fill);

FileChunk _chunk(int fill, int seq, {int total = 5}) => FileChunk(
      fileId: _id(fill),
      seq: seq,
      total: total,
      data: Uint8List(64),
    );

/// A partial file is expired by how long it has been *silent*, not by how long
/// ago it started: on EDGE a file of a few megabytes takes longer than the ten
/// minutes, and every chunk of it was still arriving.
void main() {
  late Directory tmp;
  late FileReassembler r;
  late DateTime now;
  final t0 = DateTime.utc(2026, 10, 20, 12);

  setUp(() {
    tmp = Directory.systemTemp.createTempSync('cubechat-file-stale');
    now = t0;
    r = FileReassembler(workDir: tmp, clock: () => now);
  });

  tearDown(() async {
    await r.clear();
    if (tmp.existsSync()) tmp.deleteSync(recursive: true);
  });

  test('a transfer that keeps moving is not expired', () async {
    await r.ingest(_chunk(1, 0));
    now = t0.add(const Duration(minutes: 9));
    await r.ingest(_chunk(1, 1));
    // The collection runs on the next chunk of anything — here another file.
    now = t0.add(const Duration(minutes: 12));
    await r.ingest(_chunk(2, 0));

    expect(r.pendingCount, 2);
    expect(r.progressOf(_id(1)), 2 / 5);
  });

  test('a transfer that stopped is expired ten minutes after its last chunk',
      () async {
    await r.ingest(_chunk(1, 0));
    now = t0.add(const Duration(minutes: 10, seconds: 1));
    await r.ingest(_chunk(2, 0));

    expect(r.pendingCount, 1);
    expect(r.progressOf(_id(1)), 0);
  });

  test('a transfer that moved and then stopped is expired from the stop',
      () async {
    await r.ingest(_chunk(1, 0));
    now = t0.add(const Duration(minutes: 9));
    await r.ingest(_chunk(1, 1));
    now = t0.add(const Duration(minutes: 19, seconds: 1));
    await r.ingest(_chunk(2, 0));

    expect(r.progressOf(_id(1)), 0);
    expect(r.pendingCount, 1);
  });
}
