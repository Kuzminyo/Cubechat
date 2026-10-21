import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../l10n/app_localizations.dart';
import '../../channels/models/channel.dart' show normalizeChannelName;
import '../data/radio_controller.dart';

/// «Додати рацію»: a name and, if the group wants one, a password. Joining
/// tunes the radio to the new group - nobody adds a radio to look at it.
Future<void> showRadioJoinSheet(BuildContext context) => showGlassSheet<void>(
      context: context,
      builder: (_) => const _RadioJoinSheet(),
    );

class _RadioJoinSheet extends ConsumerStatefulWidget {
  const _RadioJoinSheet();

  @override
  ConsumerState<_RadioJoinSheet> createState() => _RadioJoinSheetState();
}

class _RadioJoinSheetState extends ConsumerState<_RadioJoinSheet> {
  final _name = TextEditingController();
  final _password = TextEditingController();
  bool _missing = false;
  bool _joining = false;

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_joining) return;
    // The controller's own rule: "#" and spaces alone are no name, and it
    // throws on one. Said here, on the field, before it gets that far.
    if (normalizeChannelName(_name.text).isEmpty) {
      setState(() => _missing = true);
      return;
    }
    setState(() => _joining = true);
    final radio = ref.read(radioControllerProvider.notifier);
    try {
      final group = await radio.joinGroup(_name.text, _password.text);
      radio.select(group);
    } catch (_) {
      // Nothing to join with is the only way this throws, and it is guarded
      // above; a failure of the disk is the controller's to log, not ours.
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    InputDecoration deco(String label, {String? prefix, String? error}) =>
        InputDecoration(
          labelText: label,
          errorText: error,
          labelStyle: TextStyle(color: AppColors.textOnGlassDim, fontSize: 14),
          prefixText: prefix,
          prefixStyle: TextStyle(color: AppColors.textOnGlassDim),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.glassBorder),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.brandPrimary),
          ),
        );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.radioAddGroup,
            style: AppTypography.heading(
              size: AppMenu.title,
              color: AppColors.textOnGlass,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            key: const ValueKey('radio-join-name'),
            controller: _name,
            autofocus: true,
            textInputAction: TextInputAction.next,
            cursorColor: AppColors.brandPrimary,
            style: TextStyle(color: AppColors.textOnGlass),
            onChanged: (_) {
              if (_missing) setState(() => _missing = false);
            },
            decoration: deco(
              t.radioJoinNameLabel,
              prefix: '#',
              error: _missing ? t.radioJoinNameRequired : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const ValueKey('radio-join-password'),
            controller: _password,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => unawaited(_submit()),
            cursorColor: AppColors.brandPrimary,
            style: TextStyle(color: AppColors.textOnGlass),
            decoration: deco(t.radioJoinPasswordLabel),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              t.radioJoinHint,
              style: TextStyle(
                color: AppColors.textOnGlassDim,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 18),
          FilledButton(
            key: const ValueKey('radio-join-submit'),
            onPressed: _joining ? null : () => unawaited(_submit()),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.brandPrimary,
              foregroundColor: Colors.black,
              disabledBackgroundColor: AppColors.glass(0.12),
              disabledForegroundColor: AppColors.textOnGlassFaint,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              t.radioJoinSubmit,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
