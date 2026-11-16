import 'dart:io';

import 'package:cubechat/app/bindings.dart';
import 'package:cubechat/core/theme/app_theme.dart';
import 'package:cubechat/core/util/timed_subtree.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chat/presentation/chat_screen.dart';
import 'package:cubechat/features/chat/presentation/widgets/message_bubble.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// How much a conversation's first frame creates: elements and render objects
/// under the header, the composer, and one plain text bubble.
///
/// The S24+ put the open frame of a 436-message chat at 18-29 ms of build
/// (1199, 2026-11-10): the list 8.5-11 ms, the composer 2.3-4.2, the header
/// 2.4-3.7, and over 5 s of scrolling `item.inflate` 47 ms for 40 bubbles -
/// 1.2 ms of creating widgets per bubble before any text is measured. A test
/// cannot time a phone, but it can count what is created, and creating is
/// what inflate is. These are the counts after the 1200 trim; growing one
/// back fails here instead of on a phone.
final _peer = 'a' * 64;

class _FakeMessages extends MessagesController {
  @override
  Map<String, List<Message>> build() {
    final start = DateTime(2026, 9, 1);
    return {
      _peer: [
        for (var i = 0; i < 40; i++)
          Message(
            id: 'm$i',
            wireId: 'w$i',
            chatId: _peer,
            text: 'message number $i with some words in it',
            sentAt: start.add(Duration(minutes: i)),
            isMine: i.isEven,
            status: MessageStatus.read,
          ),
      ],
    };
  }
}

/// Elements and render objects at and under [root].
({int elements, int renders, Map<String, int> byType}) _census(Element root) {
  var elements = 0;
  var renders = 0;
  final byType = <String, int>{};
  void visit(Element e) {
    elements++;
    if (e is RenderObjectElement) renders++;
    final name = e.widget.runtimeType.toString();
    byType[name] = (byType[name] ?? 0) + 1;
    e.visitChildren(visit);
  }

  visit(root);
  return (elements: elements, renders: renders, byType: byType);
}

String _top(Map<String, int> byType) {
  final sorted = byType.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return sorted.take(18).map((e) => '${e.key} ${e.value}').join(', ');
}

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    Hive.init(Directory.systemTemp.createTempSync('open_census').path);
  });

  Future<ProviderContainer> open(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    for (final ch in [
      'com.llfbandit.record/messages',
      'plugins.it_nomads.com/flutter_secure_storage',
    ]) {
      tester.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(MethodChannel(ch), (call) async => null);
    }
    final container = ProviderContainer(
      overrides: [
        ...appBindings,
        messagesControllerProvider.overrideWith(_FakeMessages.new),
      ],
    );
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.dark(),
        home: ChatScreen(peerId: _peer, peerLabel: 'Alice'),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    tester.takeException();
    return container;
  }

  Future<void> close(WidgetTester tester, ProviderContainer container) async {
    await tester.pumpWidget(const SizedBox());
    // Inside the test: the container owns the messaging service's timers, and
    // the binding checks for pending timers before any tear-down runs.
    container.dispose();
    await tester.pump(const Duration(seconds: 10));
    tester.takeException();
  }

  testWidgets('the header\'s buttons sit where the IconButtons sat',
      (tester) async {
    Map<String, Rect> boxes() => {
          for (final tip in ['Back', 'Search'])
            tip: tester.getRect(find.byTooltip(tip)),
        };

    final container = await open(tester);
    // Where the Material IconButtons 1199 had put them, to the pixel: this
    // test compared the two on every run while the old header was kept for the
    // phone's comparison run, and the buttons are 30 pt faces at 21 and 339.
    expect(boxes(), {
      'Back': const Rect.fromLTRB(21, 17, 51, 47),
      'Search': const Rect.fromLTRB(339, 17, 369, 47),
    });
    await close(tester, container);
  });

  testWidgets('what opening a chat creates', (tester) async {
    final container = await open(tester);

    Element inflated(String label) => tester.element(
          find.byWidgetPredicate((w) => w is TimedInflate && w.label == label),
        );

    final header = _census(inflated('header'));
    final composer = _census(inflated('composer'));
    final bubbleElements = tester.elementList(find.byType(MessageBubble));
    expect(bubbleElements.length, greaterThan(4), reason: 'the list drew');
    // Ours and theirs alternate; take one of each, as a pair is what a
    // screen of conversation is made of.
    final ours = bubbleElements.firstWhere(
      (e) => (e.widget as MessageBubble).message.isMine,
    );
    final theirs = bubbleElements.firstWhere(
      (e) => !(e.widget as MessageBubble).message.isMine,
    );
    final mine = _census(ours);
    final other = _census(theirs);

    // ignore: avoid_print
    print('header   ${header.elements} elements, ${header.renders} render '
        'objects\n  ${_top(header.byType)}');
    // ignore: avoid_print
    print('composer ${composer.elements} elements, ${composer.renders} render '
        'objects\n  ${_top(composer.byType)}');
    // ignore: avoid_print
    print('ours     ${mine.elements} elements, ${mine.renders} render '
        'objects\n  ${_top(mine.byType)}');
    // ignore: avoid_print
    print('theirs   ${other.elements} elements, ${other.renders} render '
        'objects\n  ${_top(other.byType)}');

    // Elements, 1199 → 1200, on this harness: ours 59 → 23, theirs 44 → 23
    // (render objects 35 and 26 → 16), header 246 → 186. The composer stays
    // at 125: nothing in it is built for a state it is not in, and what is
    // left is the text field itself. Each is a few above today's count, so a
    // new wrapper has to be argued for rather than slipping in.
    expect(mine.elements, lessThanOrEqualTo(26),
        reason: 'it is created for every message that scrolls into view');
    expect(other.elements, lessThanOrEqualTo(26));
    expect(mine.renders, lessThanOrEqualTo(18));
    expect(other.renders, lessThanOrEqualTo(18));
    expect(header.elements, lessThanOrEqualTo(195));
    expect(composer.elements, lessThanOrEqualTo(130));

    await close(tester, container);
  });
}
