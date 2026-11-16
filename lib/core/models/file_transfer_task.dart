import 'package:flutter/foundation.dart';

// Moved from `features/files/data/file_transfer_controller.dart`, which
// re-exports it: the transport registers, advances and completes transfers
// as it sends and reassembles files, and must not import a feature to do it.

enum FileTransferDirection { outgoing, incoming }

enum FileTransferStatus {
  queued,
  transferring,
  paused,
  completed,
  failed,
  canceled,
}

/// Where a transfer came from. The transfer centre shows both; only a chat
/// file is ever retried by the file queue.
enum FileTransferSource { chat, airdrop }

@immutable
class FileTransferTask {
  const FileTransferTask({
    required this.id,
    required this.chatId,
    required this.fileName,
    this.messageId,
    required this.filePath,
    required this.mime,
    required this.bytesTotal,
    required this.completedUnits,
    required this.totalUnits,
    required this.direction,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.error,
    this.source = FileTransferSource.chat,
    this.peerName,
  });

  final String id;
  final String chatId;
  final String fileName;
  final String? messageId;
  final String filePath;
  final String mime;
  final int bytesTotal;
  final int completedUnits;
  final int totalUnits;
  final FileTransferDirection direction;
  final FileTransferStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? error;
  final FileTransferSource source;

  /// The other person's name when the task was made — AirDrop shows it,
  /// because an AirDrop file has no conversation to be read in.
  final String? peerName;

  double get progress => totalUnits <= 0
      ? (status == FileTransferStatus.completed ? 1 : 0)
      : (completedUnits / totalUnits).clamp(0.0, 1.0);

  bool get active =>
      status == FileTransferStatus.transferring ||
      status == FileTransferStatus.queued ||
      status == FileTransferStatus.paused;

  FileTransferTask copyWith({
    String? filePath,
    int? bytesTotal,
    int? completedUnits,
    int? totalUnits,
    FileTransferStatus? status,
    DateTime? updatedAt,
    String? error,
    bool clearError = false,
  }) =>
      FileTransferTask(
        id: id,
        chatId: chatId,
        fileName: fileName,
        messageId: messageId,
        filePath: filePath ?? this.filePath,
        mime: mime,
        bytesTotal: bytesTotal ?? this.bytesTotal,
        completedUnits: completedUnits ?? this.completedUnits,
        totalUnits: totalUnits ?? this.totalUnits,
        direction: direction,
        status: status ?? this.status,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now(),
        error: clearError ? null : error ?? this.error,
        source: source,
        peerName: peerName,
      );
}
