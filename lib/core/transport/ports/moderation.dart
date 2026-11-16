import 'package:flutter_riverpod/flutter_riverpod.dart';

// Who the transport drops before anything else looks at a frame: people on
// the published ban list, room authors the user hid, and the stranger
// requests a first message from somebody unknown opens. Each port lists
// exactly what the transport calls; the owning feature's controller
// implements it and `lib/app/bindings.dart` binds it.

Never _unbound(String name) => throw UnimplementedError(
      '$name is bound in lib/app/bindings.dart; build the ProviderContainer '
      'with appBindings',
    );

/// The ban list. `BanListController` implements it by asking its current
/// list.
abstract interface class BanCheck {
  bool isBannedPeer(
    String identityHex,
    List<int>? nostrPubkey, {
    List<int>? signPublicKey,
  });

  bool isBannedSigner(List<int> signPublicKey);

  bool isBannedFingerprint(String hex);
}

final banCheckProvider =
    Provider<BanCheck>((ref) => _unbound('banCheckProvider'));

/// Room authors this user hid, by fingerprint. `HiddenAuthors` implements it.
abstract interface class HiddenAuthorCheck {
  bool isHidden(String authorId);
}

final hiddenAuthorCheckProvider = Provider<HiddenAuthorCheck>(
  (ref) => _unbound('hiddenAuthorCheckProvider'),
);

/// First messages from strangers waiting for an answer.
/// `MessageRequestsController` implements it.
abstract interface class MessageRequestBook {
  Future<void> get loaded;

  bool isPending(String peer);

  bool isAccepted(String peer);

  Future<void> markPending(String peer);
}

final messageRequestBookProvider = Provider<MessageRequestBook>(
  (ref) => _unbound('messageRequestBookProvider'),
);
