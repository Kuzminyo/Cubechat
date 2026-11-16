import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'radio_chunk.dart';

// What the walkie-talkie is tuned to, and what it hears. Written by
// `features/radio`, read by the transport for every radio frame on the air —
// so declared here, in core, where the transport can read it without
// importing the feature. Moved from `features/radio/data/radio_inbound.dart`,
// which re-exports it.

/// One walkie-talkie chunk as it came off the air, opened and verified.
///
/// [senderId] is who signed it. For a 1:1 chunk, and for a group chunk from
/// somebody this phone knows, it is their canonical id - the hex of their
/// X25519 key, the same string a chat is keyed by. For a group chunk from a
/// stranger it is the 16-hex fingerprint of their Ed25519 key, which is what a
/// room's roster calls an author, because a stranger has no canonical id here.
///
/// [groupTag] is the radio group's 8-byte tag, or null for a 1:1 chunk.
class RadioInbound {
  const RadioInbound({
    required this.senderId,
    required this.groupTag,
    required this.chunk,
  });

  final String senderId;
  final Uint8List? groupTag;
  final RadioChunk chunk;
}

/// Key of the radio group the radio is tuned to, if it is tuned to one:
/// lowercase hex of the 8-byte tag -> the 32-byte key. Filled by the radio
/// controller, which plays only the tuned channel - so a joined group that is
/// not tuned is not in here, and its frames are not opened.
///
/// Read by the transport for every group frame on the air, so a tag that is
/// not in here costs one map lookup and nothing else: the frame has already
/// been passed on for the phones it is meant for.
final radioGroupKeysProvider = StateProvider<Map<String, Uint8List>>(
  (ref) => const {},
);

/// The contact the radio is tuned to, if any, by canonical id - or, while an
/// idle radio takes personal calls (Ruling 27), every contact not blocked.
/// The transport works out 1:1 pair tags - an X25519 per contact, once - only
/// for these, so a phone that never used the radio does no pair crypto at
/// all, and a pair frame between two other people costs it nothing but the
/// forward.
final radioPairPeersProvider = StateProvider<Set<String>>(
  (ref) => const {},
);
