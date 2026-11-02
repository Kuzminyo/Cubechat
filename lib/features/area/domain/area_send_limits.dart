/// How often this phone lets itself speak in the area chat (spec, «Лимиты на
/// телефоне»): a message no more than once in [messageGap] and no more than
/// [messagesPerWindow] in [messageWindow], per level; notes no more than
/// [notesPerDay] a day from the phone.
///
/// The relay holds its own, per address; these are what keep an honest phone
/// from ever meeting them.
class AreaSendLimits {
  static const Duration messageGap = Duration(seconds: 3);
  static const Duration messageWindow = Duration(minutes: 10);
  static const int messagesPerWindow = 20;
  static const int notesPerDay = 3;

  final Map<Object, List<DateTime>> _sent = {};

  /// Whether a message may go to [level] at [now].
  bool canSend(Object level, DateTime now) {
    final times = _trim(level, now);
    if (times.isNotEmpty && now.difference(times.last) < messageGap) {
      return false;
    }
    return times.length < messagesPerWindow;
  }

  void noteSent(Object level, DateTime now) =>
      _sent.putIfAbsent(level, () => <DateTime>[]).add(now);

  /// Whether another note may be left, given when this phone's notes still on
  /// record were made.
  static bool canLeaveNote(Iterable<DateTime> madeAt, DateTime now) =>
      madeAt
          .where((t) => now.difference(t) < const Duration(days: 1))
          .length <
      notesPerDay;

  void clear() => _sent.clear();

  List<DateTime> _trim(Object level, DateTime now) {
    final times = _sent.putIfAbsent(level, () => <DateTime>[]);
    times.removeWhere((t) => now.difference(t) >= messageWindow);
    return times;
  }
}
