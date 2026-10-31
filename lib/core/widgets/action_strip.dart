import 'package:flutter/material.dart';

import 'glass_card.dart';

/// One action in an [ActionStrip].
class ActionStripItem {
  const ActionStripItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.tone,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// A destructive or switched-on action's colour; white otherwise.
  final Color? tone;
}

/// A row of actions on one glass card, each in an equal cell with its icon
/// and label centred in it: Chat, Call, Radio… on a contact, Photo, Name,
/// Card on your own profile.
///
/// One widget for both because they were two — your own profile drew three
/// separate 19-point pills, a contact one card of 25-point icons — and the
/// two screens sit a tap apart (asked to match, 2026-10-31).
class ActionStrip extends StatelessWidget {
  const ActionStrip({super.key, required this.items});

  /// The card's height: a 25-point icon, a gap, an 11-point label and room
  /// above and below. Callers that lay out around the strip read it.
  static const double height = 84;

  static const double iconSize = 25;
  static const double labelSize = 11;

  final List<ActionStripItem> items;

  @override
  Widget build(BuildContext context) => GlassCard(
        strong: true,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        borderRadius: 26,
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              for (final item in items) Expanded(child: _Cell(item)),
            ],
          ),
        ),
      );
}

class _Cell extends StatelessWidget {
  const _Cell(this.item);

  final ActionStripItem item;

  @override
  Widget build(BuildContext context) {
    final tone = item.tone ?? Colors.white;
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: tone, size: ActionStrip.iconSize),
            const SizedBox(height: 7),
            // Shrunk to its cell rather than cut. Measured in Inter Bold at
            // 11 px against the cell a 360 px phone gives five buttons
            // (63 px): "Підтвердити" is 70, "Заблокувати" 72, and "Увімкнути
            // звук" 86. An ellipsis turns a word into a guess; a label a size
            // smaller is still the word.
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                item.label,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: tone,
                  fontSize: ActionStrip.labelSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
