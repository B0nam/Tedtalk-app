import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/main.dart';
import 'package:tedtalk/pages/home.dart';

void main() {
  group('MyApp Widget Tests', () {
    testWidgets('App loads and shows Home widget', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(Home), findsOneWidget);
    });

    testWidgets('AppBar has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('Debug banner is hidden', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(Banner), findsNothing);
    });
  });
}
