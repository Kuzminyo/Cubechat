// The call rules live in core beside the signal they judge: the transport
// asks which signals wake a phone, and must not import a feature to do it.
// Re-exported so the call feature keeps reading them from here.
export '../../../core/transport/call_rules.dart';
