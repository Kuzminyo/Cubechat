import 'dart:math';
import 'dart:typed_data';

import 'frame.dart';

/// Link-layer fragmentation for frames that exceed a BLE link's usable MTU.
///
/// A frame larger than the negotiated payload is split into N fragment frames,
/// each laid out as
///
/// ```
///   [FrameType.fragment : 1][fragId : 4][index : 1][count : 1][slice : M]
/// ```
///
/// and reassembled on the far side *before* normal dispatch — so the mesh,
/// dedup, replay-window and relay logic never see fragments. The `slice` bytes
/// are a contiguous span of the ORIGINAL encoded frame (including its own type
/// byte), so concatenating the slices in index order reproduces it exactly.
///
/// This is what lets a forward-secret text (~215–230 B) or a media chunk reach
/// a peer across a low-MTU iOS↔Android link where a whole frame would be
/// truncated on the wire.

/// Header bytes after the frame-type byte: fragId(4) + index(1) + count(1).
const int kFragHeaderLen = 4 + 1 + 1;

/// Max fragments a single frame may split into — `index`/`count` are u8.
const int kMaxFragments = 255;

final _fragRand = Random.secure();

/// Split [frameBytes] (a fully-encoded [Frame]) into fragment frames whose
/// individual encoded size is `<= maxFrameBytes`. Returns a single-element list
/// holding [frameBytes] unchanged when it already fits — callers can send the
/// result verbatim in either case.
///
/// Throws [ArgumentError] if [maxFrameBytes] is too small to hold even a
/// one-byte slice, or if the frame would need more than [kMaxFragments]
/// fragments at this size (callers size media chunks so this never triggers in
/// practice; text frames are far too small to approach the cap).
/// Whether [frameBytes] can be fragmented for a link whose frames may be at
/// most [maxFrameBytes].
///
/// The same arithmetic [fragmentFrame] throws on, asked instead of caught. A
/// frame sized for the relay — where one chunk is one event and 63 KiB is
/// ordinary — cannot go on a Bluetooth link at all, and the caller has a
/// better answer than an exception per chunk: leave it to the road it was
/// sized for.
bool fitsFragments(int frameBytes, int maxFrameBytes) {
  if (frameBytes <= maxFrameBytes) return true;
  final maxSlice = maxFrameBytes - 1 - kFragHeaderLen;
  if (maxSlice < 1) return false;
  return (frameBytes + maxSlice - 1) ~/ maxSlice <= kMaxFragments;
}

List<Uint8List> fragmentFrame(Uint8List frameBytes, int maxFrameBytes) {
  if (frameBytes.length <= maxFrameBytes) return [frameBytes];

  final maxSlice = maxFrameBytes - 1 - kFragHeaderLen;
  if (maxSlice < 1) {
    throw ArgumentError('maxFrameBytes $maxFrameBytes too small to fragment');
  }
  final count = (frameBytes.length + maxSlice - 1) ~/ maxSlice;
  if (count > kMaxFragments) {
    throw ArgumentError(
        'frame of ${frameBytes.length}B needs $count fragments > $kMaxFragments '
        'at maxFrameBytes=$maxFrameBytes');
  }

  final fragId = Uint8List(4);
  for (var i = 0; i < 4; i++) {
    fragId[i] = _fragRand.nextInt(256);
  }

  final out = <Uint8List>[];
  for (var i = 0; i < count; i++) {
    final start = i * maxSlice;
    final end = start + maxSlice < frameBytes.length
        ? start + maxSlice
        : frameBytes.length;
    final sliceLen = end - start;
    final frag = Uint8List(1 + kFragHeaderLen + sliceLen);
    var c = 0;
    frag[c++] = FrameType.fragment.value;
    frag.setRange(c, c += 4, fragId);
    frag[c++] = i;
    frag[c++] = count;
    frag.setRange(c, c += sliceLen, frameBytes.sublist(start, end));
    out.add(frag);
  }
  return out;
}

/// Per-link reassembly buffer for [FrameType.fragment] frames.
///
/// Bounded in the same spirit as `ImageReassembler`: partial groups expire
/// after [staleAfter], and both the group count and total buffered bytes are
/// capped so a peer that streams fragments and never finishes can't grow memory
/// without limit.
///
/// The caps were global, so one link that streamed unfinished groups was
/// bounded but still evicted every other link's half-built frames — anyone in
/// range could keep a neighbour's media from ever reassembling. Each link now
/// has its own share, and pays for its own excess before anyone else does.
class FrameFragmentReassembler {
  FrameFragmentReassembler({
    this.staleAfter = const Duration(seconds: 20),
    this.maxPendingGroups = 64,
    this.maxBufferedBytes = 512 * 1024,
    this.maxGroupsPerLink = 8,
    this.maxBufferedBytesPerLink = 256 * 1024,
  });

  final Duration staleAfter;
  final int maxPendingGroups;
  final int maxBufferedBytes;

  /// Partial groups one link may hold at once. A link sends frames one after
  /// another, so more than a couple in flight is already unusual.
  final int maxGroupsPerLink;

  /// Bytes one link may hold. The largest group is 255 slices of one MTU,
  /// about 130 kB at 512, so this fits two of the worst case.
  final int maxBufferedBytesPerLink;

  final Map<String, _PendingGroup> _pending = {};

  /// Feed the payload of one fragment frame — i.e. `Frame.decode(bytes).payload`
  /// for a frame whose type is [FrameType.fragment]. [linkKey] scopes the
  /// 4-byte fragId to one link so ids from different peers can't collide.
  ///
  /// Returns the fully-reassembled original frame bytes when the last missing
  /// fragment lands, otherwise null (more fragments still expected, or the
  /// fragment was malformed / a duplicate).
  Uint8List? ingest(String linkKey, Uint8List fragmentPayload) {
    _gc();
    if (fragmentPayload.length < kFragHeaderLen + 1) return null; // no slice

    final fragIdHex = _hex(fragmentPayload, 0, 4);
    final index = fragmentPayload[4];
    final count = fragmentPayload[5];
    if (count == 0 || index >= count) return null;
    final slice =
        Uint8List.sublistView(fragmentPayload, kFragHeaderLen);

    final key = '$linkKey:$fragIdHex';
    var group = _pending[key];
    if (group == null) {
      while (_groupsOf(linkKey) >= maxGroupsPerLink) {
        _evictOldest(link: linkKey);
      }
      _evictUntilGroupSlot();
      group = _PendingGroup(
        link: linkKey,
        count: count,
        startedAt: DateTime.now(),
      );
      _pending[key] = group;
    }
    if (group.count != count) {
      // count disagreement across fragments of the same id — corrupt; restart.
      _pending.remove(key);
      return null;
    }
    if (group.slices.containsKey(index)) return null; // duplicate

    group.slices[index] = slice;
    group.byteCount += slice.length;
    group.lastTouched = DateTime.now();
    while (_bytesOf(linkKey) > maxBufferedBytesPerLink &&
        _evictOldest(exceptKey: key, link: linkKey)) {}
    while (_bufferedBytes > maxBufferedBytes && _evictOldest(exceptKey: key)) {}

    if (group.slices.length != group.count) return null;

    final total = group.byteCount;
    final out = Uint8List(total);
    var cursor = 0;
    for (var i = 0; i < group.count; i++) {
      final s = group.slices[i]!;
      out.setRange(cursor, cursor += s.length, s);
    }
    _pending.remove(key);
    return out;
  }

  int get _bufferedBytes =>
      _pending.values.fold<int>(0, (s, g) => s + g.byteCount);

  int _groupsOf(String link) =>
      _pending.values.where((g) => g.link == link).length;

  int _bytesOf(String link) => _pending.values
      .where((g) => g.link == link)
      .fold<int>(0, (s, g) => s + g.byteCount);

  void _gc() {
    final now = DateTime.now();
    _pending.removeWhere((_, g) => now.difference(g.startedAt) > staleAfter);
  }

  void _evictUntilGroupSlot() {
    while (_pending.length >= maxPendingGroups && _pending.isNotEmpty) {
      _evictOldest();
    }
  }

  /// Drop the least recently touched group — of [link] alone when given.
  /// False when there was nothing to drop.
  bool _evictOldest({String? exceptKey, String? link}) {
    String? oldestKey;
    DateTime? oldest;
    for (final e in _pending.entries) {
      if (e.key == exceptKey) continue;
      if (link != null && e.value.link != link) continue;
      if (oldest == null || e.value.lastTouched.isBefore(oldest)) {
        oldest = e.value.lastTouched;
        oldestKey = e.key;
      }
    }
    if (oldestKey == null) return false;
    _pending.remove(oldestKey);
    return true;
  }

  static String _hex(Uint8List b, int start, int len) {
    final sb = StringBuffer();
    for (var i = start; i < start + len; i++) {
      sb.write(b[i].toRadixString(16).padLeft(2, '0'));
    }
    return sb.toString();
  }
}

class _PendingGroup {
  _PendingGroup({
    required this.link,
    required this.count,
    required this.startedAt,
  }) : lastTouched = startedAt;

  final String link;
  final int count;
  final DateTime startedAt;
  DateTime lastTouched;
  int byteCount = 0;
  final Map<int, Uint8List> slices = {};
}
