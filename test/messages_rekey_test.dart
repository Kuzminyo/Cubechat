import 'dart:io';

import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

Message _m(String chat, String wire, int at, {bool mine = false}) => Message(
      id: 'm$wire',
      chatId: chat,
      text: wire,
      sentAt: DateTime.fromMillisecondsSinceEpoch(at),
      isMine: mine,
      wireId: wire,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('cubechat_rekey_');
    Hive.init(dir.path);
  });

  tearDown(() async {
    await settleBackgroundStorage();
    try {
      await Hive.close();
    } on FileSystemException {
      // closed on dispose, unawaited
    }
    try {
      if (dir.existsSync()) dir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows holds a just-closed box briefly.
    }
  });

  test('a conversation moves to the new key, merged and in order', () async {
    final c = ProviderContainer();
    addTearDown(c.dispose);
    final messages = c.read(messagesControllerProvider.notifier);
    await messages.loaded;
    messages
      ..append('old', _m('old', 'a', 1))
      ..append('old', _m('old', 'b', 3, mine: true))
      // Their first message from the new key beat the rotation here.
      ..append('new', _m('new', 'c', 2))
      ..append('new', _m('new', 'b', 3, mine: true));

    await messages.rekeyChat('old', 'new');

    final state = c.read(messagesControllerProvider);
    expect(state.containsKey('old'), isFalse);
    expect(state['new']!.map((m) => m.wireId), ['a', 'c', 'b']);
    expect(state['new']!.every((m) => m.chatId == 'new'), isTrue);
  });
}
