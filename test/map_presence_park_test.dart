import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/transport/shared_location.dart';
import 'package:cubechat/core/util/app_lifecycle.dart';
import 'package:cubechat/core/util/location_service.dart';
import 'package:cubechat/core/util/platform_capabilities.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/map/data/map_friends_controller.dart';
import 'package:cubechat/features/map/data/map_presence_controller.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/models/known_peer.dart';
import 'package:cubechat/features/profile/data/privacy_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// The live map parks its GPS after three rounds that reached nobody, and the
/// park has to end when the road comes back. "Гео иногда тупо не передаётся,
/// хотя все разрешения есть" (2026-10-20) was the park never ending: a parked
/// round would only send a fix younger than a minute, and with the GPS parked
/// nothing could produce one — so one bad two minutes of signal stopped the
/// pin until the app was restarted.
class _Privacy extends PrivacySettingsController {
  @override
  PrivacySettings build() =>
      PrivacySettings.initial.copyWith(shareMapLocation: true);
}

class _Friends extends MapFriendsController {
  @override
  Set<String> build() => const {'alice'};
}

class _Peers extends KnownPeersController {
  @override
  Map<String, KnownPeer> build() => {
        'alice': KnownPeer(
          pubkeyHex: 'alice',
          displayName: 'alice',
          lastSeen: DateTime(2026),
        ),
      };
}

/// A road that can be cut and restored. Cut, a beacon finds no route, which
/// `sendText` reports as [MessageRoute.queued] rather than by throwing.
class _Messaging extends Fake implements MessagingService {
  bool reachable = false;
  final sent = <SharedLocation>[];

  @override
  Future<Message> sendText(
    String chatId,
    String text, {
    String? replyToWireId,
    String? replyPreview,
    bool transient = false,
    Message? resendOf,
  }) async {
    if (reachable) sent.add(SharedLocation.tryParse(text)!);
    return Message(
      id: 'm${sent.length}',
      chatId: chatId,
      text: text,
      sentAt: DateTime.now(),
      isMine: true,
      route: reachable ? MessageRoute.internet : MessageRoute.queued,
    );
  }
}

const _here = LocationFix(latitude: 50.45, longitude: 30.52, accuracyMetres: 8);

Future<void> _settle() async {
  for (var i = 0; i < 20; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  late _Messaging messaging;

  ProviderContainer build() {
    messaging = _Messaging();
    AppLifecycle.instance.isForeground = true;
    final container = ProviderContainer(
      overrides: [
        privacySettingsProvider.overrideWith(_Privacy.new),
        mapFriendsControllerProvider.overrideWith(_Friends.new),
        knownPeersControllerProvider.overrideWith(_Peers.new),
        messagingServiceProvider.overrideWithValue(messaging),
        platformCapabilitiesProvider
            .overrideWithValue(PlatformCapabilities.phone),
      ],
    );
    addTearDown(container.dispose);
    container.read(lastLocationFixProvider.notifier).state =
        StampedLocationFix(_here, DateTime.now());
    return container;
  }

  /// Three rounds with the road cut: the arming round, then two more.
  Future<MapPresenceController> parked(ProviderContainer container) async {
    container.read(mapPresenceControllerProvider);
    await _settle();
    final presence = container.read(mapPresenceControllerProvider.notifier);
    await presence.pokeNow();
    await presence.pokeNow();
    return presence;
  }

  test('a parked beacon goes out again once the road is back', () async {
    final container = build();
    final presence = await parked(container);
    expect(messaging.sent, isEmpty);

    // Parked means no GPS, so the fix it last had goes stale while it waits.
    container.read(lastLocationFixProvider.notifier).state = StampedLocationFix(
      _here,
      DateTime.now().subtract(const Duration(minutes: 5)),
    );
    messaging.reachable = true;

    await presence.pokeNow();

    expect(
      messaging.sent,
      hasLength(1),
      reason: 'the stale fix is what finds out the road is back',
    );
  });

  test('a fix the map screen found un-parks the beacon', () async {
    final container = build();
    final presence = await parked(container);
    container.read(lastLocationFixProvider.notifier).state = null;
    messaging.reachable = true;

    const found =
        LocationFix(latitude: 50.46, longitude: 30.53, accuracyMetres: 12);
    await presence.pokeNow(offered: StampedLocationFix(found, DateTime.now()));

    expect(messaging.sent.single.latitude, found.latitude);
    expect(
      container.read(lastLocationFixProvider)?.fix.latitude,
      found.latitude,
      reason: 'and the position is kept for the next round to use',
    );
  });
}
