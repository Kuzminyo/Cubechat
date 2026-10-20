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
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// On a crawling link (EDGE) the map waits. A beacon repeats every 45 s, so a
/// round skipped while the link is slow costs nothing; a retraction ("I stopped
/// sharing") and a forced send still go.
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

class _Messaging extends Fake implements MessagingService {
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
    sent.add(SharedLocation.tryParse(text)!);
    return Message(
      id: 'm${sent.length}',
      chatId: chatId,
      text: text,
      sentAt: DateTime.now(),
      isMine: true,
      route: MessageRoute.internet,
    );
  }
}

const _here = LocationFix(latitude: 50.45, longitude: 30.52, accuracyMetres: 8);
const _there =
    LocationFix(latitude: 50.46, longitude: 30.53, accuracyMetres: 8);

void main() {
  late _Messaging messaging;

  ProviderContainer build({required bool slow}) {
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
    container.read(slowNetworkProvider.notifier).publish(slow);
    container.read(lastLocationFixProvider.notifier).state =
        StampedLocationFix(_here, DateTime.now());
    return container;
  }

  test('a slow link skips the beacon round, a forced one still goes', () {
    expect(
      MapPresenceController.roundAllowed(slow: true, force: false),
      isFalse,
    );
    expect(
      MapPresenceController.roundAllowed(slow: true, force: true),
      isTrue,
    );
    expect(
      MapPresenceController.roundAllowed(slow: false, force: false),
      isTrue,
    );
    expect(
      MapPresenceController.roundAllowed(slow: false, force: true),
      isTrue,
    );
  });

  testWidgets(
      'the timer round is held while slow and goes once the link is '
      'back', (tester) async {
    final container = build(slow: true);
    container.read(mapPresenceControllerProvider);
    // The arming round is forced, so it goes even on a slow link.
    await tester.pump();
    expect(messaging.sent, hasLength(1));

    // Somewhere else, so only the slow link can be the reason for silence.
    container.read(lastLocationFixProvider.notifier).state =
        StampedLocationFix(_there, DateTime.now());
    await tester.pump(const Duration(seconds: 45));
    expect(messaging.sent, hasLength(1), reason: 'held while the link crawls');

    container.read(slowNetworkProvider.notifier).publish(false);
    container.read(lastLocationFixProvider.notifier).state =
        StampedLocationFix(_there, DateTime.now());
    await tester.pump(const Duration(seconds: 45));
    expect(messaging.sent, hasLength(2), reason: 'the next round goes');
    expect(messaging.sent.last.latitude, _there.latitude);

    // The periodic timer must be gone before the binding checks for leaks,
    // which happens ahead of the tear-down.
    container.dispose();
  });

  test('a poke and a retraction still go on a slow link', () async {
    final container = build(slow: true);
    container.read(mapPresenceControllerProvider);
    await Future<void>.delayed(Duration.zero);
    final before = messaging.sent.length;

    await container.read(mapPresenceControllerProvider.notifier).pokeNow();
    expect(messaging.sent, hasLength(before + 1), reason: 'forced goes');

    await container.read(mapPresenceControllerProvider.notifier).withdraw();
    expect(messaging.sent.last.retract, isTrue, reason: 'retraction goes');
  });
}
