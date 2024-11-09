import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/pages/ted_list_page.dart';
import 'package:tedtalk/models/ted_list.dart';

void main() {
  group('TedListPage Tests', () {
    final mockTedList = TedList(
      id: '1',
      title: 'Lista de TED Talks de Exemplo',
      tedTalks: ["1", "2"],
    );

    testWidgets('Add TED Talk button triggers dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TedListPage(tedList: mockTedList),
      ));

      expect(find.text('Adicionar TED Talk'), findsOneWidget);

      await tester.tap(find.text('Adicionar TED Talk'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
