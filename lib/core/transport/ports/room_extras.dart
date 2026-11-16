import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Per-conversation extras the transport keeps in step with what it sends and
// receives: a room's picture and topic, pinned messages, how far we have read.
// Each port lists exactly what the transport calls, the controller in the
// owning feature implements it, and `lib/app/bindings.dart` binds it.

Never _unbound(String name) => throw UnimplementedError(
      '$name is bound in lib/app/bindings.dart; build the ProviderContainer '
      'with appBindings',
    );

/// A room's picture. `ChannelAvatarsController` implements it.
abstract interface class ChannelAvatars {
  Future<void> get loaded;

  /// The room's picture, or its parent room's for a community room.
  Uint8List? forChannel(String name);

  /// False when [jpeg] is refused (too large, not an image).
  Future<bool> store(String name, Uint8List jpeg);

  Future<void> forget(String name);
}

final channelAvatarsProvider =
    Provider<ChannelAvatars>((ref) => _unbound('channelAvatarsProvider'));

/// A room's topic. `ChannelDescriptionsController` implements it.
abstract interface class ChannelDescriptions {
  Future<void> get loaded;

  String? forChannel(String name);

  /// False when [text] is too long.
  Future<bool> store(String name, String text);

  Future<void> forget(String name);
}

final channelDescriptionsProvider = Provider<ChannelDescriptions>(
  (ref) => _unbound('channelDescriptionsProvider'),
);

/// Pinned messages, by chat. `PinnedController` implements it.
abstract interface class Pins {
  Future<void> pin(
    String chatId,
    String wireId, {
    DateTime? at,
    bool mineOnly = false,
  });

  /// Unpins [wireId], or everything in [chatId] when it is null.
  Future<void> unpin(String chatId, {String? wireId});

  Future<void> forget(String chatId);
}

final pinsProvider = Provider<Pins>((ref) => _unbound('pinsProvider'));

/// How far this phone has read each chat — what a read receipt reports.
/// `ReadMarkersController` implements it.
abstract interface class ReadMarkers {
  Future<void> get loaded;

  DateTime? lastReadAt(String chatId);

  Future<void> forget(String chatId);
}

final readMarkersProvider =
    Provider<ReadMarkers>((ref) => _unbound('readMarkersProvider'));

/// How far this phone's read receipts got, per chat and per message, across
/// restarts — so a cold start does not acknowledge the whole history again.
/// `AckMarkersController` implements it.
abstract interface class AckMarkers {
  Future<void> get loaded;

  /// Where [chatId]'s receipts got to.
  DateTime? ackedUpTo(String chatId);

  /// The oldest moment the per-message record vouches for; null when it
  /// vouches for nothing yet.
  DateTime? get ackCoverFrom;

  bool hasAcked(String wireId);

  Future<void> markIdsAcked(Map<String, DateTime> ids);

  Future<void> markAcked(String chatId, DateTime at);
}

final ackMarkersProvider =
    Provider<AckMarkers>((ref) => _unbound('ackMarkersProvider'));
