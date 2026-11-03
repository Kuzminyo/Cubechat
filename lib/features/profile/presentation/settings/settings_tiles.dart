import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/util/haptics.dart';
import '../../../../core/widgets/glass_sheet.dart';
import 'settings_section_icons.dart';

/// A setting's name and one line under it; the rest on asking.
///
/// The section screens read as pages of small print: three-line hints under
/// every switch and whole paragraphs between them ("no extra text", asked for
/// 2026-11-03). The hint now gets one line. When it does not fit, or there is
/// a longer account ([details]), an ⓘ beside the name says so and a tap on
/// the words opens all of it in a sheet — nothing that was written is gone,
/// it is one tap away instead of always in the way.
class SettingText extends StatelessWidget {
  const SettingText({
    super.key,
    required this.title,
    this.hint = '',
    this.details,
    this.titleStyle,
  });

  final String title;

  /// One line under the name; empty for none.
  final String hint;
  final String? details;

  /// The name's style, where a card's heading wants to be larger than a row's.
  final TextStyle? titleStyle;

  static const _hintStyle = TextStyle(fontSize: 11.5, height: 1.3);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, box) {
          final hintStyle = _hintStyle.copyWith(color: AppColors.textOnGlassDim);
          var more = details != null;
          if (!more && hint.isNotEmpty) {
            // Measured in the style the Text below will inherit — the theme's
            // font — or a hint that fits is judged not to.
            final painter = TextPainter(
              text: TextSpan(
                text: hint,
                style: DefaultTextStyle.of(context).style.merge(hintStyle),
              ),
              maxLines: 1,
              textDirection: Directionality.of(context),
              textScaler: MediaQuery.textScalerOf(context),
            )..layout(maxWidth: box.maxWidth);
            more = painter.didExceedMaxLines;
            painter.dispose();
          }
          final text = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: titleStyle ??
                          TextStyle(
                            color: AppColors.textOnGlass,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  if (more) ...[
                    const SizedBox(width: 5),
                    Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                      color: AppColors.textOnGlassFaint,
                    ),
                  ],
                ],
              ),
              if (hint.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  hint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: hintStyle,
                ),
              ],
            ],
          );
          if (!more) return text;
          return Semantics(
            button: true,
            hint: hint.isEmpty ? details : hint,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showSettingInfo(
                context,
                title: title,
                text: [
                  if (hint.isNotEmpty) hint,
                  if (details case final more?) more,
                ].join('\n\n'),
              ),
              child: text,
            ),
          );
        },
      );
}

/// A setting's whole explanation, in a sheet.
Future<void> showSettingInfo(
  BuildContext context, {
  required String title,
  required String text,
}) =>
    showGlassSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.heading(size: AppMenu.title)),
              const SizedBox(height: 12),
              Text(
                text,
                style: TextStyle(
                  color: AppColors.textOnGlassDim,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );

/// One glass block holding a run of rows, with a hairline between them.
///
/// The hairline starts past the icon badge, as in iOS Settings, so a
/// group reads as one surface with rows in it rather than a stack of slabs —
/// the stack of slabs is what the profile looked like before, and "eyes run
/// all over" was the complaint that replaced it.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) rows.add(const SettingsGroupDivider());
      rows.add(children[i]);
    }
    final radius = BorderRadius.circular(22);
    return ClipRRect(
      borderRadius: radius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.glass(0.065),
          borderRadius: radius,
          border: Border.all(color: AppColors.glass(0.08)),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rows,
          ),
        ),
      ),
    );
  }
}

/// The hairline between two rows of a [SettingsGroup]. A type of its own
/// rather than a shared key: one key on several siblings is a duplicate-key
/// error the moment a group holds three rows.
class SettingsGroupDivider extends StatelessWidget {
  const SettingsGroupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SettingsSectionRow.sidePadding +
            SettingsSectionRow.badge +
            SettingsSectionRow.gap,
      ),
      child: Container(height: 1, color: AppColors.glass(0.07)),
    );
  }
}

/// A row that opens a section: coloured badge, title, a short grey state on
/// the right, chevron.
class SettingsSectionRow extends StatelessWidget {
  const SettingsSectionRow({
    super.key,
    required this.section,
    required this.title,
    this.value,
    required this.onTap,
    this.danger = false,
  });

  /// The badge and its glyph: 34 points and 19. They were raised to a
  /// contact page's 42 and 22 on the morning of 2026-11-03 and put back the
  /// same day — at that size the list read as too heavy ("return the size
  /// the icons were").
  static const double badge = 34;
  static const double iconSize = 19;
  static const double sidePadding = 14;
  static const double gap = 13;

  final SettingsSection section;
  final String title;

  /// What the section is set to, in a word or two — "@kuzminyo", "Через
  /// запит". One line; a long one is cut, never allowed to push the chevron.
  final String? value;
  final VoidCallback onTap;

  /// Acts in place rather than opening a screen, so no chevron; red title.
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    final accent = danger ? AppColors.danger : AppColors.brandPrimary;
    return InkWell(
      onTap: () {
        danger ? Haptics.warn() : Haptics.tap();
        onTap();
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: badge + 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: sidePadding,
            vertical: 10,
          ),
          child: Row(
            children: [
              // A tint of the theme's colour with the icon in the colour
              // itself — so a rose theme gets rose badges. Red for the wipe
              // row only. Filled exactly as a contact's page fills its boxes:
              // at the same size as theirs this badge still read larger,
              // because a 30%-to-12% gradient inside a 42%-alpha edge draws
              // the whole box, where the contact's flat 14% leaves only the
              // glyph to see (2026-11-03, after the sizes were matched).
              Container(
                width: badge,
                height: badge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: accent.withValues(alpha: 0.14),
                ),
                child: Icon(section.icon, size: iconSize, color: accent),
              ),
              const SizedBox(width: gap),
              // The title wins the width and may take a second line — the
              // Ukrainian "Конфіденційність і безпека" beside "Через запит"
              // does not fit one line of a 360 dp phone, and a cut section
              // name is worse than a taller row. The value is the one cut.
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.rowTitle.copyWith(
                    fontSize: 15.5,
                    color: danger ? AppColors.danger : AppColors.textOnGlass,
                  ),
                ),
              ),
              if (value != null && value.isNotEmpty) ...[
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: AppColors.textOnGlassDim,
                    ),
                  ),
                ),
              ],
              if (!danger) ...[
                const SizedBox(width: 2),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.glass(0.35),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The grey capitals above a group inside a section screen.
class SettingsSubheader extends StatelessWidget {
  const SettingsSubheader(this.text, {super.key, this.info});

  final String text;

  /// What the group under it is about, opened from an ⓘ beside the heading
  /// rather than printed under the group.
  final String? info;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      text.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
        color: AppColors.textOnGlassDim,
      ),
    );
    final info = this.info;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      child: info == null
          ? label
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showSettingInfo(context, title: text, text: info),
              child: Row(
                children: [
                  Flexible(child: label),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: AppColors.textOnGlassFaint,
                  ),
                ],
              ),
            ),
    );
  }
}

/// The frame of every section screen: the same transparent bar and list
/// padding as Customize, so each section opens the way Customize always has.
class SettingsSectionScaffold extends StatelessWidget {
  const SettingsSectionScaffold({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Only where there is somewhere to go back to: beside the profile on
        // a computer window the section is the pane's whole navigator.
        automaticallyImplyLeading: false,
        leading: Navigator.canPop(context)
            ? BackButton(color: AppColors.textOnGlass)
            : null,
        title: Text(
          title,
          style: AppTypography.heading(size: 18, color: AppColors.textOnGlass),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 140),
          children: children,
        ),
      ),
    );
  }
}
