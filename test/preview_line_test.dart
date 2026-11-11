import 'package:cubechat/features/chat/domain/message_preview.dart';
import 'package:cubechat/features/chat/presentation/widgets/preview_line.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// "Эмодзи звонков поменяй на иконки нормальные": the chat list draws an icon
/// where the preview string carries an emoji, and the right arrow for a call.
void main() {
  Future<AppLocalizations> pump(
      WidgetTester tester, String Function(AppLocalizations) text) async {
    late AppLocalizations t;
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Builder(builder: (context) {
          t = AppLocalizations.of(context);
          return PreviewLine(text(t));
        }),
      ),
    ));
    await tester.pump();
    return t;
  }

  final cases = <String, (String Function(AppLocalizations), IconData)>{
    'missed call': (
      (t) => '$previewCallLead ${t.previewCallMissed}',
      Icons.call_missed_rounded,
    ),
    'incoming call': (
      (t) => '$previewCallLead ${t.previewCallIncoming}',
      Icons.call_received_rounded,
    ),
    'outgoing call': (
      (t) => '$previewCallLead ${t.previewCallOutgoing}',
      Icons.call_made_rounded,
    ),
    'location': (
      (t) => '$previewLocationLead ${t.previewLocation}',
      Icons.place_rounded,
    ),
  };
  for (final MapEntry(key: name, value: (text, icon)) in cases.entries) {
    testWidgets('$name: an icon, and no emoji left in the words',
        (tester) async {
      await pump(tester, text);
      expect(find.byIcon(icon), findsOneWidget);
      final rich = tester.widget<RichText>(find.byType(RichText).last);
      expect(rich.text.toPlainText(), isNot(contains(previewCallLead)));
      expect(rich.text.toPlainText(), isNot(contains(previewLocationLead)));
    });
  }

  testWidgets('anything else is plain text', (tester) async {
    await pump(tester, (_) => 'hello there');
    expect(find.text('hello there'), findsOneWidget);
    expect(find.byType(Icon), findsNothing);
  });
}
