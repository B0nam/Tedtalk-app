import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/widgets/ted_talk_dialog.dart';

void main() {
  group('TedTalkDialog Tests', () {
    testWidgets('TedTalkDialog renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: TedTalkDialog(),
        ),
      ));

      expect(find.text('Adicionar TED Talk'), findsOneWidget);

      expect(find.byType(TextField), findsNWidgets(5));

      expect(find.text('Salvar'), findsOneWidget);
    });

    testWidgets('TedTalkDialog fills fields with existing TED Talk data',
        (WidgetTester tester) async {
      final tedTalk = TedTalk(
        id: '1',
        name: 'TED Talk Title',
        speaker: 'Speaker Name',
        description: 'Description of the talk',
        duration: const Duration(minutes: 30),
        image: 'https://example.com/image.jpg',
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TedTalkDialog(tedTalk: tedTalk),
        ),
      ));

      expect(find.byType(TextField), findsNWidgets(5));
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.controller?.text == 'TED Talk Title'),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField && widget.controller?.text == 'Speaker Name'),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.controller?.text == 'Description of the talk'),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField && widget.controller?.text == '30'),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.controller?.text == 'https://example.com/image.jpg'),
          findsOneWidget);
    });
  });
}
