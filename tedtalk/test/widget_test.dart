import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/pages/home.dart';
import 'package:tedtalk/widgets/ted_search_bar.dart';
import 'package:tedtalk/widgets/ted_summary.dart';

void main() {
  testWidgets(
      'Main Widget Test - Home Page should display widgets and interact',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Home(),
    ));

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.byType(TedSummary), findsOneWidget);
    expect(find.byType(TedSearchBar), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'TED Talk');
    await tester.pump();

    expect(find.text('TED Talk'), findsOneWidget);
  });
}
