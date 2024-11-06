import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/widgets/ted_search_bar.dart';

void main() {
  testWidgets(
      'TedSearchBar deve chamar onFilterChange quando texto for inserido',
      (WidgetTester tester) async {
    String filtro = '';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TedSearchBar(
          onFilterChange: (novoFiltro) {
            filtro = novoFiltro;
          },
        ),
      ),
    ));

    final campoTexto = find.byType(TextField);

    await tester.enterText(campoTexto, 'TED Talk');
    await tester.pump();

    expect(filtro, 'TED Talk');
  });
}
