import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/glass_toast.dart';
import '../../../l10n/app_localizations.dart';
import '../data/cube_id_client.dart';
import '../data/cube_id_controller.dart';
import '../domain/cube_name.dart';
import 'stranger_reach_selector.dart';

/// Profile → Cube ID: take, change, share or release a short @name.
///
/// Rules are checked on the phone first (the same table the server uses), so
/// "ab" or "admin" never costs a request; availability is asked once the
/// typing stops, not per keystroke.
class CubeIdScreen extends ConsumerStatefulWidget {
  const CubeIdScreen({super.key});

  @override
  ConsumerState<CubeIdScreen> createState() => _CubeIdScreenState();
}

enum _Status { idle, invalid, reserved, checking, available, taken, offline }

class _CubeIdScreenState extends ConsumerState<CubeIdScreen> {
  final _field = TextEditingController();
  Timer? _debounce;
  _Status _status = _Status.idle;
  bool _editing = false;
  bool _busy = false;

  /// Answers for a name typed earlier must not land on the one typed now.
  String _asked = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _field.dispose();
    super.dispose();
  }

  void _onChanged(String raw) {
    _debounce?.cancel();
    final name = normalizeCubeName(raw);
    final problem = cubeNameProblem(name);
    if (name.isEmpty) {
      setState(() => _status = _Status.idle);
      return;
    }
    if (problem != null) {
      setState(
        () => _status = problem == CubeNameProblem.invalid
            ? _Status.invalid
            : _Status.reserved,
      );
      return;
    }
    setState(() => _status = _Status.checking);
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      _asked = name;
      final answer = await ref.read(cubeIdClientProvider).available(name);
      if (!mounted || _asked != normalizeCubeName(_field.text)) return;
      setState(() {
        if (answer == null) {
          _status = _Status.offline;
        } else if (answer.available) {
          _status = _Status.available;
        } else {
          _status = answer.reason == 'taken'
              ? _Status.taken
              : answer.reason == 'invalid'
                  ? _Status.invalid
                  : _Status.reserved;
        }
      });
    });
  }

  Future<void> _claim() async {
    if (_busy) return;
    setState(() => _busy = true);
    final result =
        await ref.read(cubeIdControllerProvider.notifier).claim(_field.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      switch (result) {
        case CubeIdOk():
          _editing = false;
          _status = _Status.idle;
          _field.clear();
        case CubeIdRefused(:final code):
          _status = switch (code) {
            'taken' || 'has-name' => _Status.taken,
            'invalid' => _Status.invalid,
            'reserved' => _Status.reserved,
            _ => _Status.idle,
          };
          if (_status == _Status.idle) {
            showGlassToast(
              context,
              AppLocalizations.of(context).cubeIdFailed,
              tone: ToastTone.danger,
            );
          }
        case CubeIdOffline():
          _status = _Status.offline;
      }
    });
  }

  Future<void> _release(String name) async {
    final t = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: t.cubeIdRelease,
      message: t.cubeIdReleaseConfirm(name),
      confirmLabel: t.cubeIdRelease,
    );
    if (!ok || !mounted) return;
    await ref.read(cubeIdControllerProvider.notifier).release();
  }

  /// One or two fields in a dialog; null when dismissed. [second] null asks
  /// for one.
  Future<List<String>?> _ask({
    required String title,
    String? hint,
    required String first,
    String firstValue = '',
    String? second,
    String? extraLabel,
  }) {
    final t = AppLocalizations.of(context);
    final a = TextEditingController(text: firstValue);
    final b = TextEditingController();
    return showDialog<List<String>>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgTop,
        title: Text(title, style: TextStyle(color: AppColors.textOnGlass)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hint != null)
              Text(
                hint,
                style: TextStyle(color: AppColors.textOnGlassDim, fontSize: 13),
              ),
            TextField(
              controller: a,
              autocorrect: false,
              autofocus: true,
              style: TextStyle(color: AppColors.textOnGlass),
              decoration: InputDecoration(hintText: first),
            ),
            if (second != null)
              TextField(
                controller: b,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: AppColors.textOnGlass),
                decoration: InputDecoration(hintText: second),
              ),
          ],
        ),
        actions: [
          if (extraLabel != null)
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(const <String>[]),
              child: Text(extraLabel),
            ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(MaterialLocalizations.of(ctx).cancelButtonLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop([a.text, b.text]),
            child: Text(t.cubeIdSave),
          ),
        ],
      ),
    );
  }

  void _toastFor(CubeIdResult result, String okText) {
    final t = AppLocalizations.of(context);
    final (text, tone) = switch (result) {
      CubeIdOk() => (okText, ToastTone.neutral),
      CubeIdRefused(code: 'bad-email') => (t.cubeIdEmailInvalid, ToastTone.danger),
      CubeIdRefused(code: 'rate') => (t.cubeIdFailed, ToastTone.danger),
      CubeIdRefused() => (t.cubeIdFailed, ToastTone.danger),
      // 503 and 502 reach here as offline: the server is up, its post is not.
      CubeIdOffline() => (t.cubeIdEmailUnavailable, ToastTone.danger),
    };
    showGlassToast(
      context,
      text,
      tone: tone,
      duration: const Duration(seconds: 4),
    );
  }

  Future<void> _editEmail() async {
    final t = AppLocalizations.of(context);
    final ctl = ref.read(cubeIdControllerProvider.notifier);
    final current = await ctl.email();
    if (!mounted) return;
    final answer = await _ask(
      title: t.cubeIdEmail,
      hint: t.cubeIdEmailHint,
      first: t.cubeIdEmailField,
      firstValue: current ?? '',
      extraLabel: current == null ? null : t.cubeIdEmailRemove,
    );
    if (answer == null || !mounted) return;
    if (answer.isEmpty) {
      await ctl.removeEmail();
      return;
    }
    final address = answer.first.trim();
    final result = await ctl.setEmail(address);
    if (mounted) _toastFor(result, t.cubeIdEmailSent(address));
  }

  Future<void> _recover() async {
    final t = AppLocalizations.of(context);
    final answer = await _ask(
      title: t.cubeIdRecover,
      first: t.cubeIdFieldHint,
      second: t.cubeIdEmailField,
    );
    if (answer == null || answer.length < 2 || !mounted) return;
    final result = await ref
        .read(cubeIdControllerProvider.notifier)
        .recover(answer[0], answer[1]);
    if (mounted) _toastFor(result, t.cubeIdRecoverSent);
  }

  Future<void> _cancelRecovery() async {
    final t = AppLocalizations.of(context);
    final result =
        await ref.read(cubeIdControllerProvider.notifier).cancelRecovery();
    if (mounted) _toastFor(result, t.cubeIdRecoveryCancelled);
  }

  static String _when(BuildContext context, DateTime at) {
    final l = MaterialLocalizations.of(context);
    final local = at.toLocal();
    return '${l.formatMediumDate(local)}, '
        '${l.formatTimeOfDay(TimeOfDay.fromDateTime(local), alwaysUse24HourFormat: true)}';
  }

  String? _statusText(AppLocalizations t) => switch (_status) {
        _Status.idle || _Status.checking => null,
        _Status.invalid => t.cubeIdInvalid,
        _Status.reserved => t.cubeIdReserved,
        _Status.available => t.cubeIdAvailable,
        _Status.taken => t.cubeIdTaken,
        _Status.offline => t.cubeIdOffline,
      };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final name = ref.watch(cubeIdControllerProvider).name;
    final showField = name == null || _editing;
    final statusText = _statusText(t);
    final good = _status == _Status.available;
    final recoveryAt = ref.watch(cubeIdRecoveryProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textOnGlass,
        title: Text(t.cubeIdTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Before everything: somebody is taking the name, and only this
            // phone, while it still holds the key, can stop it.
            if (name != null && recoveryAt != null) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.danger.withValues(alpha: 0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.cubeIdRecoveryWarning(name, _when(context, recoveryAt)),
                      style: TextStyle(
                        color: AppColors.textOnGlass,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.danger,
                      ),
                      onPressed: () => unawaited(_cancelRecovery()),
                      child: Text(t.cubeIdRecoveryCancel),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
            ],
            Text(
              t.cubeIdExplainer,
              style: TextStyle(
                color: AppColors.textOnGlassDim,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            if (name != null)
              Center(
                child: Text(
                  '@$name',
                  style: AppTypography.heading(
                    size: 26,
                    color: AppColors.textOnGlass,
                  ),
                ),
              ),
            if (name != null) const SizedBox(height: 20),
            if (showField) ...[
              TextField(
                controller: _field,
                autocorrect: false,
                enableSuggestions: false,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: AppColors.textOnGlass, fontSize: 17),
                decoration: InputDecoration(
                  prefixText: '@',
                  hintText: t.cubeIdFieldHint,
                ),
                onChanged: _onChanged,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 20,
                child: _status == _Status.checking
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox.square(
                          dimension: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : statusText == null
                        ? null
                        : Text(
                            statusText,
                            style: TextStyle(
                              color: good
                                  ? AppColors.brandPrimary
                                  : AppColors.danger,
                              fontSize: 13,
                            ),
                          ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: good && !_busy ? () => unawaited(_claim()) : null,
                icon: _busy
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.alternate_email_rounded),
                label: Text(_busy ? t.cubeIdWorking : t.cubeIdClaim),
              ),
              // A new phone after a lost one: the name comes back through the
              // address it was given, rather than being taken again.
              if (name == null) ...[
                const SizedBox(height: 12),
                _Action(
                  icon: Icons.restore_rounded,
                  label: t.cubeIdRecover,
                  onTap: () => unawaited(_recover()),
                ),
              ],
            ],
            if (name != null && !_editing) ...[
              _Action(
                icon: Icons.edit_rounded,
                label: t.cubeIdChange,
                onTap: () => setState(() => _editing = true),
              ),
              _Action(
                icon: Icons.ios_share_rounded,
                label: t.cubeIdShare,
                onTap: () => unawaited(Share.share(t.cubeIdShareText(name))),
              ),
              _Action(
                icon: Icons.mail_outline_rounded,
                label: t.cubeIdEmail,
                onTap: () => unawaited(_editEmail()),
              ),
              _Action(
                icon: Icons.delete_outline_rounded,
                label: t.cubeIdRelease,
                onTap: () => unawaited(_release(name)),
              ),
            ],
            // Who can reach you through the name — "Nobody" hides it on the
            // server as well. The same control as in Profile → Privacy.
            const SizedBox(height: 18),
            const StrangerReachSelector(),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          color: AppColors.glass(0.11),
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: Icon(icon, color: AppColors.brandPrimary),
            title: Text(label, style: TextStyle(color: AppColors.textOnGlass)),
            trailing:
                Icon(Icons.chevron_right, color: AppColors.textOnGlassDim),
            onTap: onTap,
          ),
        ),
      );
}
