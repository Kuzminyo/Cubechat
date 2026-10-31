import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:cubechat/features/radio/data/radio_controller.dart';
import 'package:cubechat/features/radio/data/radio_internet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Port implements RadioInternetPort {
  final calls = <Set<String>>[];

  @override
  void setTags(Set<String> tagHexes) => calls.add(tagHexes);

  @override
  Future<Set<String>> pairTagsFor(String canonicalId) async =>
      {'$canonicalId-prev', '$canonicalId-now', '$canonicalId-next'};
}

/// A radio whose tuning the test sets directly.
class _Radio extends RadioController {
  @override
  RadioState build() => const RadioState();

  void tune(RadioChannel? channel) =>
      state = state.copyWith(active: () => channel);
}

class _Relays extends RelaySettingsController {
  _Relays(this.enabled);

  final bool enabled;

  @override
  RelaySettings build() =>
      RelaySettings(enabled: enabled, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();

  void set(bool on) =>
      state = RelaySettings(enabled: on, urls: RelaySettings.defaultUrls);
}

void main() {
  (ProviderContainer, _Port) start({required bool relaysOn}) {
    final port = _Port();
    final container = ProviderContainer(
      overrides: [
        radioInternetPortProvider.overrideWithValue(port),
        radioControllerProvider.overrideWith(_Radio.new),
        relaySettingsProvider.overrideWith(() => _Relays(relaysOn)),
      ],
    );
    addTearDown(container.dispose);
    container.listen(radioInternetProvider, (_, __) {});
    return (container, port);
  }

  const room = RadioRoom(name: '#patrol', hasPassword: false, tagHex: 'aa');

  test('a tuned group is listened to only while relays are on', () async {
    final (c, port) = start(relaysOn: false);
    (c.read(radioControllerProvider.notifier) as _Radio).tune(room);
    await Future<void>.delayed(Duration.zero);
    expect(c.read(radioInternetProvider), isEmpty);
    expect(port.calls.last, isEmpty, reason: 'relays are the user\'s choice');

    (c.read(relaySettingsProvider.notifier) as _Relays).set(true);
    await Future<void>.delayed(Duration.zero);
    expect(c.read(radioInternetProvider), {'aa'});
    expect(port.calls.last, {'aa'});

    (c.read(radioControllerProvider.notifier) as _Radio).tune(null);
    await Future<void>.delayed(Duration.zero);
    expect(port.calls.last, isEmpty, reason: 'nothing tuned, socket closed');
  });

  test('a tuned contact is three hours of pair tags', () async {
    final (c, port) = start(relaysOn: true);
    (c.read(radioControllerProvider.notifier) as _Radio)
        .tune(const RadioContact('bob'));
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect(port.calls.last, {'bob-prev', 'bob-now', 'bob-next'});
    expect(c.read(radioInternetProvider), hasLength(3));
  });

  test('retuning before the pair tags arrive keeps the new channel', () async {
    final (c, port) = start(relaysOn: true);
    final radio = c.read(radioControllerProvider.notifier) as _Radio;
    radio.tune(const RadioContact('bob'));
    radio.tune(room);
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect(port.calls.last, {'aa'}, reason: "bob's late tags are dropped");
  });
}
