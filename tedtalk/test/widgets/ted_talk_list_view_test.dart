import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/widgets/ted_talk_list_view.dart';

void main() {
  group('TedTalkListView Tests', () {
    testWidgets('TedTalkListView loads with TED Talks',
        (WidgetTester tester) async {
      final tedTalks = [
        TedTalk(
          id: '1',
          name: 'TED Talk 1',
          speaker: 'Speaker 1',
          description: 'Description 1',
          duration: const Duration(minutes: 10),
          image: 'https://example.com/image1.jpg',
        ),
        TedTalk(
          id: '2',
          name: 'TED Talk 2',
          speaker: 'Speaker 2',
          description: 'Description 2',
          duration: const Duration(minutes: 20),
          image: 'https://example.com/image2.jpg',
        ),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TedTalkListView(
            tedTalksFuture: Future.value(tedTalks),
            onRemove: (_) {},
            onEdit: (_) {},
          ),
        ),
      ));

      expect(find.byType(TedTalkListView), findsOneWidget);
    });

    testWidgets('TedTalkListView loads without TED Talks',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TedTalkListView(
            tedTalksFuture: Future.value([]),
            onRemove: (_) {},
            onEdit: (_) {},
          ),
        ),
      ));

      expect(find.byType(TedTalkListView), findsOneWidget);
    });
  });
}
