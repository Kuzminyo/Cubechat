import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// A button in a header: one icon size, one touch target, one colour.
///
/// Header buttons were each built on the spot — the Chats menu a default
/// 24-point IconButton in the accent green, the profile's a 22-point white one
/// on its own disc, the selection bar's a default white one, the Contacts
/// megaphone 26 in green — so the same kind of control looked different on
/// every screen and changed size as you moved between tabs.
class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
    this.disc = true,
  });

  /// The dark disc behind every header button, the one a contact's profile
  /// drew for its back and three dots — asked for on the Contacts megaphone
  /// and the other three-dot buttons too (2026-10-31), so the controls in a
  /// header read as controls and not as a stray glyph on the aurora.
  static Color get discColor => Colors.black.withValues(alpha: 0.34);

  /// The glyph size every header button draws at.
  static const double iconSize = 22;

  /// The square every header button answers taps in — the platform minimum.
  static const double target = 44;

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  /// Defaults to the glass ink; only for a button that needs to stand out
  /// from the ones beside it, which none currently does.
  final Color? color;

  /// False only where the caller draws a disc of its own, or where the button
  /// sits in a row of a list rather than in a header.
  final bool disc;

  @override
  Widget build(BuildContext context) {
    final button = SizedBox.square(
      dimension: target,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        iconSize: iconSize,
        constraints: const BoxConstraints.tightFor(
          width: target,
          height: target,
        ),
        icon: Icon(icon, size: iconSize, color: color ?? AppColors.textOnGlass),
      ),
    );
    if (!disc) return button;
    return Material(
      color: discColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: button,
    );
  }
}

/// The three dots, the same everywhere. See [HeaderIconButton].
class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    required this.onPressed,
    this.tooltip,
    this.color,
    this.disc = true,
  });

  static const double iconSize = HeaderIconButton.iconSize;

  final VoidCallback? onPressed;
  final String? tooltip;

  /// White on glass by default; white over a photo too, which is what the
  /// scrimmed buttons on a cover want.
  final Color? color;

  /// See [HeaderIconButton.disc].
  final bool disc;

  @override
  Widget build(BuildContext context) => HeaderIconButton(
        icon: Icons.more_vert_rounded,
        onPressed: onPressed,
        tooltip: tooltip,
        color: color,
        disc: disc,
      );
}
