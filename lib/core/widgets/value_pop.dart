import 'package:flutter/material.dart';

import '../util/motion.dart';

/// A small piece of state that pops when it changes: a count, a delivery tick.
///
/// Only on a change. The first build shows [child] as it is, so a list of
/// these appearing does not ripple — chat rows are "there straight away" on
/// purpose (see `chats_list_screen.dart`). At rest it is one [AnimatedSwitcher]
/// with no ticker, so a screenful of them schedules no frames, and with Reduce
/// Motion on the duration is zero and the new value is simply there.
///
/// Transform and opacity alone: nothing around it is laid out again.
class ValuePop extends StatelessWidget {
  const ValuePop({super.key, required this.value, required this.child});

  /// Compared with `==`; a change is what plays the pop.
  final Object value;
  final Widget child;

  static final _grow = Tween<double>(begin: 0.6, end: 1);

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: AppMotion.duration(context, AppMotion.control),
        switchInCurve: AppMotion.pop,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: _grow.animate(animation),
            child: child,
          ),
        ),
        child: KeyedSubtree(key: ValueKey(value), child: child),
      );
}
