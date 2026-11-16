// Moved from `features/profile/data/privacy_settings_controller.dart`, which
// re-exports it: the transport's stranger gate reads it on every internet
// arrival and must not import a feature to do it.

/// Who may reach this phone from the internet without being a contact —
/// Profile → Privacy. See `strangerVerdict` for what each value does, and the
/// Cube ID registry, which hides the @name altogether for [none].
///
/// [wire] is the exact string the registry and this phone's settings store.
enum StrangerReach {
  all,
  request,
  none;

  String get wire => name;

  static StrangerReach fromWire(String? value) => switch (value) {
        'request' => StrangerReach.request,
        'none' => StrangerReach.none,
        _ => StrangerReach.all,
      };
}
