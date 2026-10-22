import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/radio_channel.dart';

/// What the radio wants Bluetooth links for right now. Written by the radio
/// controller, read by the scanner ([PeerDiscoveryController]) on each result.
///
/// The radio never made a link of its own: it went out on whatever links
/// something else had opened - the user, an undelivered message, a bump. With
/// the internet up nothing else opens one, and 2026-10-22 two phones a metre
/// apart pressed to talk on an empty mesh ("nobody in reach") until a bump
/// happened to connect them. So the radio asks, but only while it is in use:
/// its screen open on a channel, or a press going out. A tuned radio in a
/// pocket asks for nothing - the phone that talks dials it.
///
/// A plain holder, not provider state: it is set from the radio controller's
/// build and dispose, where Riverpod forbids touching another provider.
class RadioReach {
  /// The channel the radio screen is showing, while it is on screen.
  RadioChannel? onScreen;

  /// The channel a press is talking on, from the press until its last chunk.
  RadioChannel? talking;

  /// The channel to find links for, or null for none. [foreground] gates the
  /// screen's ask only: a screen left open under a locked phone is not use.
  RadioChannel? wanted({required bool foreground}) =>
      talking ?? (foreground ? onScreen : null);
}

final radioReachProvider = Provider<RadioReach>((_) => RadioReach());
