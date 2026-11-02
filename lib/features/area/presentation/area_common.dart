import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/area_controller.dart';
import '../data/area_place_names.dart';
import '../data/area_settings.dart';
import '../domain/area_event.dart';
import '../domain/area_level.dart';

/// The name a post is shown under: the one its author set, or the one its
/// key gives, in the reader's language.
String areaDisplayName(AppLocalizations t, String pubkey, String? name) =>
    name ?? t.areaDefaultName(areaKeyTag(pubkey));

String areaLevelLabel(AppLocalizations t, AreaLevel level) => switch (level) {
      AreaLevel.district => t.areaLevelDistrict,
      AreaLevel.city => t.areaLevelCity,
      AreaLevel.region => t.areaLevelRegion,
    };

/// "≈12 here", "50+ here", or null where it is not shown.
String? areaCountLabel(AppLocalizations t, int? count) {
  if (count == null) return null;
  return count > 50 ? t.areaPresentMany : t.areaPresentCount(count);
}

/// The cell a room is about, given where the phone is.
String? areaCellOf(AreaRoomId id, AreaPlace? place) {
  if (id.readOnly) return id.foreignCell;
  return place?.cellOf(id.level!);
}

/// The name of [cell] from the geocoder, or the level's label while it is
/// not known (or never will be).
class AreaPlaceName extends ConsumerWidget {
  const AreaPlaceName({
    super.key,
    required this.cell,
    required this.style,
  });

  final String? cell;
  final TextStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final c = cell;
    final level = c == null ? null : AreaLevel.ofPrecision(c.length);
    final fallback = level == null ? t.areaNearby : areaLevelLabel(t, level);
    if (c == null) return Text(fallback, style: style);
    final name = ref.watch(
      areaPlaceNameProvider((c, Localizations.localeOf(context).languageCode)),
    );
    return Text(
      name.valueOrNull ?? fallback,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Holds an area session for as long as it is mounted: the socket and the
/// fix run while any of these is on screen, and ~30 s after.
///
/// Acquired a microtask after mounting, because starting a session changes
/// the controller's state and Riverpod refuses that while the tree builds.
mixin AreaSessionHolder<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  late final AreaController _area;
  bool _acquired = false;

  /// Runs once the session is held; for a screen's own first calls.
  void onAreaSessionStart() {}

  @override
  void initState() {
    super.initState();
    _area = ref.read(areaControllerProvider.notifier);
    scheduleMicrotask(() {
      if (!mounted) return;
      _area.acquire();
      _acquired = true;
      onAreaSessionStart();
    });
  }

  @override
  void dispose() {
    if (_acquired) _area.release();
    super.dispose();
  }
}

/// Asks once, in words and with a way to say no, before anything of the area
/// chat runs (spec, «Согласие при первом открытии»; App Store 5.1.2(i), as
/// `confirmMapSharing`). True when consent is there afterwards.
Future<bool> ensureAreaConsent(BuildContext context, WidgetRef ref) async {
  if (ref.read(areaSettingsProvider).consented) return true;
  final t = AppLocalizations.of(context);
  final allowed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      key: const ValueKey('area-consent'),
      title: Text(t.areaConsentTitle),
      content: Text(t.areaConsentBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.areaConsentDecline),
        ),
        FilledButton(
          key: const ValueKey('area-consent-allow'),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(t.areaConsentAllow),
        ),
      ],
    ),
  );
  if (allowed != true) return false;
  await ref.read(areaSettingsProvider.notifier).setConsented(true);
  return true;
}
