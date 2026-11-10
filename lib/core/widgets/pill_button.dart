import 'package:flutter/material.dart';

import '../theme/colors.dart';

class PillButton extends StatefulWidget {
  const PillButton({
    super.key,
    required this.label,
    this.icon,
    this.active = false,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool active;
  final VoidCallback? onTap;

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          // 12, not 16: on the grid, and a pill in the AirDrop card's tight
          // row still fits its whole word.
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          // Active is a brighter fill and border, not a green glow under it
          // (unslop pass, 2026-11-10).
          decoration: BoxDecoration(
            color:
                widget.active ? AppColors.glass(0.18) : AppColors.glass(0.10),
            border: Border.all(
              color:
                  widget.active ? AppColors.glass(0.30) : AppColors.glass(0.15),
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 14, color: AppColors.textOnGlass),
                const SizedBox(width: 8),
              ],
              // Flexible, so a pill in a tight row gives way with an ellipsis
              // instead of overflowing it.
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        widget.active ? FontWeight.w600 : FontWeight.w500,
                    color: AppColors.textOnGlass,
                  ),
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
