import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/channel.dart';

/// The rooms this phone is in, with their keys — what the transport needs to
/// open a room frame and to send one. Exactly the members it calls;
/// `ChannelController` implements it.
abstract interface class ChannelDirectory {
  /// The room called [name] (normalised), or null if we are not in it.
  Channel? byName(String name);

  /// The room whose 8-byte frame tag is [tag], or null — the lookup every
  /// room frame on the air costs.
  Channel? channelForTag(Uint8List tag);

  /// Joins [rawName] under a key handed to us (an invite), not a password.
  Future<Channel> joinWithKey(String rawName, Uint8List key);

  /// Joins the community room of [channelName], if it has one.
  Future<Channel?> joinCommunity(String channelName, {required bool asAdmin});

  Future<void> leave(String name);

  Future<void> setAdminOnly(String name, bool value);
}

/// Bound in `lib/app/bindings.dart`; see [ChannelDirectory].
final channelDirectoryProvider = Provider<ChannelDirectory>(
  (ref) => throw UnimplementedError(
    'channelDirectoryProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
