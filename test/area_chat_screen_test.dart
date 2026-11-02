import 'package:cubechat/core/transport/nostr/area_relay_link.dart';
import 'package:cubechat/core/transport/nostr/nostr_event.dart';
import 'package:cubechat/features/area/data/area_controller.dart';
import 'package:cubechat/features/area/data/area_location.dart';
import 'package:cubechat/features/area/data/area_store.dart';
import 'package:cubechat/features/area/domain/area_level.dart';
import 'package:cubechat/features/area/presentation/area_chat_screen.dart';
import 'package:cubechat/features/moderation/data/filter_settings.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Link extends AreaRelayLink {
  _Link({required super.onEvent});

  final List<NostrEvent> published = [];

  @override
  bool get connected => true;

  @override
  void setFilters(List<Map<String, Object>> f) {}

  @override
  Future<AreaPublishOutcome> publish(NostrEvent signed) async {
    published.add(signed);
    return AreaPublishOutcome.accepted;
  }

  @override
  Future<void> dispose() async {}
}

class _Filter extends FilterSettings {
  @override
  bool build() => true;
}

void main() {
  late _Link link;

  Widget app(Widget screen, {bool presence = false}) {
    final kv = MemoryAreaKv()
      ..values[AreaKeys.settings] = {
        'enabled': true,
        'consented': true,
        'presence': presence,
      };
    return ProviderScope(
      overrides: [
        areaKvProvider.overrideWithValue(kv),
        filterEnabledProvider.overrideWith(_Filter.new),
        areaDistrictReaderProvider.overrideWithValue(() async => ('u8vxn', null)),
        areaBanFetcherProvider.overrideWithValue(() async => null),
        areaLinkFactoryProvider.overrideWithValue(
          ({required onEvent, required onConnection}) =>
              link = _Link(onEvent: onEvent),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('uk'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: screen,
      ),
    );
  }

  testWidgets('a city read from the map has no composer and says why',
      (tester) async {
    await tester.pumpWidget(app(const AreaChatScreen.foreign('u9bb')));
    await tester.pump();
    expect(find.byKey(const ValueKey('area-composer')), findsNothing);
    expect(find.byKey(const ValueKey('area-read-only')), findsOneWidget);
    expect(find.text('Писати можна лише там, де ви є'), findsOneWidget);
    // No presence switch, no name, no "new name" in somebody else's city.
    expect(find.byKey(const ValueKey('area-presence')), findsNothing);
    expect(find.byKey(const ValueKey('area-new-name')), findsNothing);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(AreaController.linger);
    expect(link.published, isEmpty);
  });

  testWidgets('the own city: a composer, and "Show that I\'m here" off',
      (tester) async {
    await tester.pumpWidget(app(const AreaChatScreen.own(AreaLevel.city)));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pump();
    expect(find.byKey(const ValueKey('area-composer')), findsOneWidget);
    final presence = tester.widget<SwitchListTile>(
      find.byKey(const ValueKey('area-presence')),
    );
    expect(presence.value, isFalse);
    expect(
      find.text('Увімкніть «Показувати, що я тут», щоб бачити, скільки людей поруч'),
      findsOneWidget,
    );
    await tester.pumpWidget(const SizedBox());
    await tester.pump(AreaController.linger);
  });
}
