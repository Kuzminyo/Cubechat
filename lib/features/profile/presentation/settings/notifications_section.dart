part of '../profile_screen.dart';

/// Notifications & calls: what may wake the phone, and who may ring it.
class NotificationsSectionScreen extends ConsumerWidget {
  const NotificationsSectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return SettingsSectionScaffold(
      title: t.sectionNotifications,
      children: [
        SettingsSubheader(t.subNotifications),
        SettingsGroup(
          children: [
            if (PlatformInfo.isMobile) _inset(const _PushWakeRow()),
            // A computer's push is its process: this is what keeps one
            // running for calls and messages with no window open.
            if (desktopPresenceSupported)
              _inset(const _DesktopAutostartTile()),
            _inset(const _QuietHoursRow()),
            _inset(const _NotificationPreviewSelector(), vertical: 14),
          ],
        ),
        SettingsSubheader(t.subCalls),
        SettingsGroup(
          children: [
            _inset(const _AcceptCallsTile()),
            _inset(const _CallDirectTile()),
            if (PlatformInfo.isAndroid) _inset(const _CallFullScreenTile()),
          ],
        ),
      ],
    );
  }
}

/// Name and text, name only, or nothing — see [NotificationPreview].
///
/// Built like the stranger-reach control in Privacy: three short answers to
/// one question, where a switch could only say two of them.
class _NotificationPreviewSelector extends ConsumerWidget {
  const _NotificationPreviewSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final preview = ref.watch(notificationPreviewProvider);
    Widget label(String text) => Text(
          text,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 14),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Who else can read a banner — the lock screen, apps with access to
        // notifications — opens from the ⓘ; it was a paragraph under these.
        SettingText(title: t.notifPreviewTitle, details: t.notifPreviewHint),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<NotificationPreview>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: NotificationPreview.full,
                label: label(t.notifPreviewFull),
              ),
              ButtonSegment(
                value: NotificationPreview.nameOnly,
                label: label(t.notifPreviewNameOnly),
              ),
              ButtonSegment(
                value: NotificationPreview.hidden,
                label: label(t.notifPreviewHidden),
              ),
            ],
            selected: {preview},
            onSelectionChanged: (v) {
              Haptics.tap();
              unawaited(
                ref.read(notificationPreviewProvider.notifier).set(v.first),
              );
            },
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 6),
              ),
              foregroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? AppColors.textOnGlass
                    : AppColors.textOnGlassDim,
              ),
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? AppColors.brandPrimary.withValues(alpha: 0.35)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
