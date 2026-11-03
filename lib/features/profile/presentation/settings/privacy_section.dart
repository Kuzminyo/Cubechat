part of '../profile_screen.dart';

/// Privacy & security: what other people are told about you, who may write
/// from the internet, and what protects the phone itself.
class PrivacySectionScreen extends ConsumerWidget {
  const PrivacySectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return SettingsSectionScaffold(
      title: t.sectionPrivacy,
      children: [
        SettingsSubheader(t.subWhoSeesMe),
        SettingsGroup(
          children: [
            _inset(const _LastSeenTile()),
            _inset(const _ReadReceiptsTile()),
            _inset(const _ForwardLinkTile()),
            _inset(const _DiscoverableCard(framed: false), vertical: 0),
            _inset(const _MapLocationTile()),
            // A phone only: a computer does not read its own place.
            if (PlatformInfo.isMobile) _inset(const _AreaChatTile()),
            // Android's share sheet only; no other platform has one to give.
            if (PlatformInfo.isAndroid) _inset(const _ShareSheetTile()),
          ],
        ),
        // The paragraph on how last seen and read receipts cut both ways sat
        // here; it opens from the ⓘ on Last seen now.
        SettingsSubheader(t.strangerReachTitle, info: t.strangerReachHint),
        SettingsGroup(
          children: [
            _inset(
              const StrangerReachSelector(showTitle: false, showHint: false),
              vertical: 14,
            ),
          ],
        ),
        SettingsSubheader(t.subProtection),
        SettingsGroup(
          children: [
            _inset(const _AppLockTile()),
            _inset(const _FilterTile()),
            _inset(const _DeadMansRow()),
            _inset(const _FingerprintTile()),
            // The phone only: a computer that rotated could not bring the
            // phone back, since linking goes phone to computer.
            if (PlatformInfo.isMobile) _inset(const _RotateKeysTile()),
          ],
        ),
      ],
    );
  }
}

/// The area chat's own switch (spec, «Вход в интерфейсе»). Off: no "Nearby
/// chat" button on the map, and its socket and location are never touched.
/// On asks nothing here — the words and the refusal come on the first open.
class _AreaChatTile extends ConsumerWidget {
  const _AreaChatTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final on = ref.watch(areaSettingsProvider.select((s) => s.enabled));
    return _SettingSwitch(
      icon: on ? Icons.forum_rounded : Icons.speaker_notes_off_rounded,
      title: t.areaSettingTitle,
      hint: on ? t.areaSettingOnHint : t.areaSettingOffHint,
      value: on,
      onChanged: (value) => unawaited(
        ref.read(areaSettingsProvider.notifier).setEnabled(value),
      ),
    );
  }
}
