import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a received text keeps its author proof across a restart', () {
    final original = Message(
      id: 'm1',
      chatId: 'peer',
      text: 'Ні',
      sentAt: DateTime.utc(2026, 11, 4),
      isMine: false,
      signedProof: 'AbC-_9',
    );
    final restored = MessagesController.decodeForTest(
      MessagesController.encodeForTest(original),
    );
    expect(restored.signedProof, 'AbC-_9');
    expect(restored.copyWith(text: 'x').signedProof, 'AbC-_9');
    expect(restored.copyWith(signedProof: 'new').signedProof, 'new');
  });

  test('a message without one stores no key for it', () {
    final m = Message(
      id: 'm2',
      chatId: 'peer',
      text: 'hi',
      sentAt: DateTime.utc(2026, 11, 4),
      isMine: false,
    );
    expect(MessagesController.encodeForTest(m).containsKey('proof'), isFalse);
  });
}
