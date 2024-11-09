import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/models/ted_list.dart';

void main() {
  group('TedList', () {
    // Teste do fromJson
    test('Deve criar um objeto TedList a partir de um JSON válido', () {
      final Map<String, dynamic> json = {
        'id': '1',
        'title': 'Lista de TED Talks',
        'tedTalks': ['1', '2', '3']
      };

      final tedList = TedList.fromJson(json);

      expect(tedList.id, '1');
      expect(tedList.title, 'Lista de TED Talks');
      expect(tedList.tedTalks, ['1', '2', '3']);
    });

    // Teste do toJson
    test('Deve criar um mapa JSON a partir de um objeto TedList', () {
      final tedList = TedList(
        id: '1',
        title: 'Lista de TED Talks',
        tedTalks: ['1', '2', '3'],
      );

      final json = tedList.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Lista de TED Talks');
      expect(json['tedTalks'], ['1', '2', '3']);
    });
  });
}
