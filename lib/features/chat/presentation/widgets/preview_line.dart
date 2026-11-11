import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/message_preview.dart';

/// What a preview line opens with when it opens with one of the four emoji
/// [messagePreview] uses, as an icon of the app's own set.
///
/// "эмодзи звонков поменяй на иконки нормальные" (2026-11-11): the telephone in
/// the chat list was the system's colour emoji, a different size and a
/// different weight from every other mark on the row, and it said "call" for a
/// missed one, an outgoing one and an answered one alike.
///
/// The string keeps its emoji — it is also a notification body and a line in
/// the send queue, where an icon cannot go — and this finds them by the same
/// constants the string is built from. A call's direction is read off the
/// words after the emoji, which are the three localized labels the string was
/// made from, so the arrow is the right one in every language.
({IconData icon, bool alert, String rest})? splitPreviewLead(
  String preview,
  AppLocalizations t,
) {
  ({IconData icon, bool alert, String rest})? lead(
    String emoji,
    IconData Function(String rest) icon, {
    bool Function(String rest)? alert,
  }) {
    if (!preview.startsWith('$emoji ')) return null;
    final rest = preview.substring(emoji.length + 1);
    return (icon: icon(rest), alert: alert?.call(rest) ?? false, rest: rest);
  }

  return lead(
        previewCallLead,
        (rest) {
          if (rest == t.previewCallMissed) return Icons.call_missed_rounded;
          if (rest == t.previewCallIncoming) return Icons.call_received_rounded;
          return Icons.call_made_rounded;
        },
        alert: (rest) => rest == t.previewCallMissed,
      ) ??
      lead(previewLocationLead, (_) => Icons.place_rounded) ??
      lead(previewMapLead, (_) => Icons.map_rounded) ??
      lead(previewContactLead, (_) => Icons.person_rounded);
}

/// A one-line preview, with an icon where [messagePreview] put an emoji.
///
/// Anything else is drawn exactly as a plain [Text] would draw it, so this can
/// stand in for one on any row.
class PreviewLine extends StatelessWidget {
  const PreviewLine(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
  });

  final String text;
  final TextStyle? style;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final lead = splitPreviewLead(text, AppLocalizations.of(context));
    if (lead == null) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }
    final base = DefaultTextStyle.of(context).style.merge(style);
    final size = (base.fontSize ?? 14) + 2;
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                lead.icon,
                size: size,
                // A missed call is the one preview that is news, and the row
                // already says so with the same red the call bubble uses.
                color: lead.alert ? AppColors.danger : base.color,
              ),
            ),
          ),
          TextSpan(text: lead.rest),
        ],
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
