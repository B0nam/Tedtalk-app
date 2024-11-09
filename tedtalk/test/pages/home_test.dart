import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/pages/home.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('Home page renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home()));

      expect(find.text('Home Page'), findsOneWidget);

      expect(find.text('TEDTalks'), findsOneWidget);

      expect(find.text('Criar Nova Lista'), findsOneWidget);

      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
