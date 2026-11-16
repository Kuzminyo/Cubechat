// The room model lives in core: the transport opens room frames with a
// [Channel]'s key and must not import a feature to do it. Kept as a re-export
// so the features that import it from here keep working unchanged.
export '../../../core/models/channel.dart';
