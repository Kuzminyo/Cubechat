/// How much of a message its notification may show.
///
/// A banner is the one place a decrypted message leaves the app: it is drawn
/// on the lock screen, read by every app holding notification access, and not
/// covered by the app lock. Android shows the text on the lock screen unless
/// the user found the system switch that hides it. bitchat's review of its own
/// app named the same thing (H4, July 2026), with no way to turn it off.
///
/// [full] is the default because it is what every build did before the
/// setting existed, and what a messenger is expected to do.
///
/// [wire] is the string the settings box stores.
enum NotificationPreview {
  full,
  nameOnly,
  hidden;

  String get wire => name;

  static NotificationPreview fromWire(Object? value) => switch (value) {
        'nameOnly' => NotificationPreview.nameOnly,
        'hidden' => NotificationPreview.hidden,
        _ => NotificationPreview.full,
      };

  /// The title and body a banner may carry under this setting.
  ///
  /// [newMessage] stands in for the text, [appName] for the sender. The
  /// avatar is the caller's to drop: it is drawn from the sender's key and
  /// says who as plainly as the name does.
  ({String title, String body}) redact({
    required String title,
    required String body,
    required String appName,
    required String newMessage,
  }) =>
      switch (this) {
        NotificationPreview.full => (title: title, body: body),
        NotificationPreview.nameOnly => (title: title, body: newMessage),
        NotificationPreview.hidden => (title: appName, body: newMessage),
      };
}
