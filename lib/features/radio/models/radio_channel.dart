import 'package:flutter/foundation.dart';

/// Something the radio can be tuned to: a group everyone in it hears, or one
/// contact.
///
/// The key a group is sealed with is not part of this - it stays inside the
/// controller and the transport. What the screen holds is a name to show and
/// an id to hand back.
@immutable
sealed class RadioChannel {
  const RadioChannel();
}

/// A radio group, joined by name and (possibly empty) password.
///
/// [tagHex] is its identity: lowercase hex of the 8-byte one-way tag, the same
/// string `radioGroupKeysProvider` is keyed by. Two joins that derive the same
/// key are the same group whatever was typed, so equality is on the tag alone.
class RadioRoom extends RadioChannel {
  const RadioRoom({
    required this.name,
    required this.hasPassword,
    required this.tagHex,
  });

  /// Normalised, as `normalizeChannelName` returns it: `#patrol`.
  final String name;

  /// Whether a non-empty password went into the key. Cosmetic - a lock in the
  /// list; the key already bakes it in.
  final bool hasPassword;

  final String tagHex;

  @override
  bool operator ==(Object other) =>
      other is RadioRoom && other.tagHex == tagHex;

  @override
  int get hashCode => Object.hash(RadioRoom, tagHex);

  @override
  String toString() => 'RadioRoom($name)';
}

/// One contact, talked to 1:1. [canonicalId] is the hex of their X25519 key,
/// the string a chat is keyed by and the sender id a 1:1 chunk arrives with.
class RadioContact extends RadioChannel {
  const RadioContact(this.canonicalId);

  final String canonicalId;

  @override
  bool operator ==(Object other) =>
      other is RadioContact && other.canonicalId == canonicalId;

  @override
  int get hashCode => Object.hash(RadioContact, canonicalId);

  @override
  String toString() => 'RadioContact($canonicalId)';
}
