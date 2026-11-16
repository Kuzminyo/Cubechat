// The message model lives in core: the transport files what arrives as a
// [Message] and must not import a feature to do it. Kept as a re-export so the
// features that import it from here keep working unchanged.
export '../../../core/models/message.dart';
