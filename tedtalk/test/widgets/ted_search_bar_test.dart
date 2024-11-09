import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/widgets/ted_search_bar.dart';

void main() {
  group('TedSearchBar Tests', () {
    testWidgets('TedSearchBar renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TedSearchBar(
            updateFilter: (String newFilter) {},
          ),
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);

      expect(find.byIcon(Icons.search), findsOneWidget);

      expect(find.text('Procure sua lista...'), findsOneWidget);
    });

    testWidgets('TextField updates filter correctly',
        (WidgetTester tester) async {
      String filter = '';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TedSearchBar(
            updateFilter: (String newFilter) {
              filter = newFilter;
            },
          ),
        ),
      ));

      await tester.enterText(find.byType(TextField), 'Lista 1');
      await tester.pump();

      expect(filter, 'Lista 1');
    });

    testWidgets('updateFilter is called when typing',
        (WidgetTester tester) async {
      String filter = '';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TedSearchBar(
            updateFilter: (String newFilter) {
              filter = newFilter;
            },
          ),
        ),
      ));

      expect(filter, '');

      await tester.enterText(find.byType(TextField), 'Nova Lista');
      await tester.pump();

      expect(filter, 'Nova Lista');
    });
  });
}
