// The contact model lives in core: the transport reads a [KnownPeer]'s keys
// on every frame and must not import a feature to do it. Kept as a re-export
// so the features that import it from here keep working unchanged.
export '../../../core/models/known_peer.dart';
