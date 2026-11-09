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
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
            ),
    );
  }
}
