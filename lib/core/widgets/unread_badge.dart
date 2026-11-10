import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'value_pop.dart';

class UnreadBadge extends StatelessWidget {
  const UnreadBadge({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final label = count > 99 ? '99+' : '$count';
    return ValuePop(
      // By what it says, so 100 and 101 — both "99+" — do not pop for nothing.
      value: count <= 0 ? '' : label,
      child: count <= 0
          ? const SizedBox.shrink()
          : Container(
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              alignment: Alignment.center,
              // One flat accent with dark figures, like the send button: the
              // gradient pill and white on mint were the loudest thing in a
              // row of quiet ones (unslop pass, 2026-11-10).
              decoration: BoxDecoration(
                color: AppColors.brandPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(999)),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.bgDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
    );
  }
}
