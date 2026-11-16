import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/file_transfer_task.dart';

/// Every file transfer the transfer centre shows, by id.
/// Bound in `lib/app/bindings.dart` to the files feature's controller state.
final fileTransferTasksProvider = Provider<Map<String, FileTransferTask>>(
  (ref) => throw UnimplementedError(
    'fileTransferTasksProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);

/// What the transport tells the transfer centre as it sends and reassembles
/// files: a new transfer, its progress, its end — and what it asks: whether a
/// paused one may run. Exactly the members it calls;
/// `FileTransferController` implements it.
abstract interface class FileTransfers {
  /// Resolves once transfers have been read from disk.
  Future<void> get loaded;

  void register(FileTransferTask task);

  void setStatus(String id, FileTransferStatus status, {String? error});

  void setProgress(String id, int completed, int total);

  void complete(String id, {String? filePath, int? bytesTotal});

  void cancel(String id);

  /// Waits while [id] is paused; false once it is cancelled or gone.
  Future<bool> waitUntilRunnable(String id);

  Future<void> remove(String id);
}

/// Bound in `lib/app/bindings.dart`; see [FileTransfers].
final fileTransfersProvider = Provider<FileTransfers>(
  (ref) => throw UnimplementedError(
    'fileTransfersProvider is bound in lib/app/bindings.dart; build the '
    'ProviderContainer with appBindings',
  ),
);
