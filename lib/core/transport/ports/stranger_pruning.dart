import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lets the roster forget strangers past its cap.
///
/// Every broadcast announcement from somebody new adds a stranger to the
/// roster, so the transport asks for a trim after each one. *Who* is worth
/// keeping is the app's call, not the transport's — anybody with a
/// conversation, a favourite, a pin, an alias, a pending request or a live
/// session — and those answers live in the features. The one implementation
/// is `features/peers/data/stranger_pruning.dart`.
abstract interface class StrangerPruning {
  /// Forgets the strangers heard longest ago beyond the cap and returns their
  /// ids. Waits for the roster and the chat summaries first; [stillWanted] is
  /// asked once they are in, and false — the transport was torn down while
  /// waiting — forgets nobody.
  Future<List<String>> prune({required bool Function() stillWanted});
}

/// Bound in `lib/app/bindings.dart`; see [StrangerPruning].
final strangerPruningProvider = Provider<StrangerPruning>(
  (ref) => throw UnimplementedError(
    'strangerPruningProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
