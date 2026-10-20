import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cubechat/core/transport/file_reassembly.dart';
import 'package:cubechat/core/transport/inner_payload.dart';
import 'package:cubechat/core/transport/messaging_service.dart';
import 'package:cubechat/core/util/debug_log.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/profile/data/relay_settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

class _Offline extends RelaySettingsController {
  @override
  RelaySettings build() =>
      const RelaySettings(enabled: false, urls: RelaySettings.defaultUrls);

  @override
  Future<void> get loaded => Future<void>.value();
}

/// A receiver keeps a signed manifest for five minutes waiting for its chunks.
/// That was five minutes from the manifest, however steadily the chunks came,
/// so on EDGE every transfer longer than that was thrown away — mid-way ("no
/// signed manifest" for every chunk after) or at the finish line ("drop
/// assembled file: manifest expired"). A chunk that is news now restarts the
/// five minutes.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  final sender = Uint8List.fromList(List<int>.filled(32, 0xab));

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_refresh_');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await settleBackgroundStorage();
    try {
      await Hive.close();
    } on FileSystemException {
      // The service closes its own boxes on dispose, unawaited.
    }
    try {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows holds a just-closed box or a scratch file briefly.
    }
  });

  Future<MessagingService> start() async {
    final container = ProviderContainer(
      overrides: [
        relaySettingsProvider.overrideWith(_Offline.new),
        messagingServiceProvider.overrideWith((ref) {
          final service = MessagingService(ref);
          ref.onDispose(() => unawaited(service.dispose()));
          return service;
        }),
      ],
    );
    addTearDown(container.dispose);
    await container.read(messagesControllerProvider.notifier).loaded;
    return container.read(messagingServiceProvider);
  }

  Uint8List id(int seed) =>
      Uint8List.fromList(List<int>.generate(16, (i) => seed + i));
  String hex(Uint8List b) =>
      b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

  Future<void> manifest(
    MessagingService service,
    Uint8List mediaId,
    MediaKind kind,
  ) =>
      service.debugIngestManifest(
        MediaManifest(
          mediaId: mediaId,
          kind: kind,
          total: 5,
          mime: kind == MediaKind.audio
              ? 'audio/aac'
              : kind == MediaKind.image
                  ? 'image/jpeg'
                  : 'application/octet-stream',
          durationMs: kind == MediaKind.audio ? 1000 : 0,
          name: kind == MediaKind.file ? 'a.bin' : null,
          sha256: Uint8List(32),
        ).encode(),
        senderPub: sender,
        sentAt: DateTime.now(),
      );

  test('a photo chunk restarts the manifest wait', () async {
    final service = await start();
    final mediaId = id(1);
    await manifest(service, mediaId, MediaKind.image);
    service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
    await service.debugIngestMediaChunk(
      InnerPayloadType.imageChunk,
      ImageChunk(
        imageId: mediaId,
        seq: 0,
        total: 5,
        mime: 'image/jpeg',
        data: Uint8List(64),
      ).encode(),
      senderPub: sender,
    );
    service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
    expect(service.debugHasManifest(hex(mediaId)), isTrue);
  });

  test('a voice chunk restarts the manifest wait', () async {
    final service = await start();
    final mediaId = id(2);
    await manifest(service, mediaId, MediaKind.audio);
    service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
    await service.debugIngestMediaChunk(
      InnerPayloadType.audioChunk,
      AudioChunk(
        audioId: mediaId,
        seq: 0,
        total: 5,
        durationMs: 1000,
        mime: 'audio/aac',
        data: Uint8List(64),
      ).encode(),
      senderPub: sender,
    );
    service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
    expect(service.debugHasManifest(hex(mediaId)), isTrue);
  });

  group('file', () {
    late FileReassembler files;

    setUp(() {
      files = FileReassembler(
        workDir: Directory('${tempDir.path}${Platform.pathSeparator}files'),
      );
    });

    tearDown(() => files.clear());

    Future<void> fileChunk(MessagingService service, Uint8List mediaId) =>
        service.debugIngestMediaChunk(
          InnerPayloadType.fileChunk,
          FileChunk(fileId: mediaId, seq: 0, total: 5, data: Uint8List(64))
              .encode(),
          senderPub: sender,
        );

    test('a file chunk restarts the manifest wait', () async {
      final service = await start();
      service.debugUseFileReassembler(files);
      final mediaId = id(3);
      await manifest(service, mediaId, MediaKind.file);
      service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
      await fileChunk(service, mediaId);
      service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
      expect(service.debugHasManifest(hex(mediaId)), isTrue);
    });

    test('a repeated chunk does not', () async {
      final service = await start();
      service.debugUseFileReassembler(files);
      final mediaId = id(4);
      await manifest(service, mediaId, MediaKind.file);
      await fileChunk(service, mediaId);
      service.debugAgeManifestsAndSweep(const Duration(minutes: 4));
      await fileChunk(service, mediaId); // the same sequence again
      service.debugAgeManifestsAndSweep(const Duration(minutes: 2));
      expect(service.debugHasManifest(hex(mediaId)), isFalse);
    });
  });

  test('a request for a file already on its way is not answered twice',
      () async {
    final service = await start();
    final mediaId = id(5);
    service.debugFileSendsInFlight.add(hex(mediaId));
    DebugLog.install();
    DebugLog.instance.clear();
    await service.debugHandleMediaRequest(mediaId, senderPub: sender);
    final lines = DebugLog.instance.entries.map((e) => e.text).join('\n');
    expect(lines, contains('already on its way'));
    expect(lines, isNot(contains('cannot answer media request')));
  });
}
