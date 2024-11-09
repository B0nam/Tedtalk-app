import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/models/ted_talk.dart';

void main() {
  group('TedTalk', () {
    // Teste do fromJson
    test('Deve criar um objeto TedTalk a partir de um JSON válido', () {
      final Map<String, dynamic> json = {
        'id': '1',
        'name': 'Inspiração Diária',
        'image': 'image1.jpg',
        'speaker': 'Autor 1',
        'duration': 15,
        'description': 'Descrição do TedTalk'
      };

      final tedTalk = TedTalk.fromJson(json);

      expect(tedTalk.id, '1');
      expect(tedTalk.name, 'Inspiração Diária');
      expect(tedTalk.image, 'image1.jpg');
      expect(tedTalk.speaker, 'Autor 1');
      expect(tedTalk.duration, Duration(minutes: 15));
      expect(tedTalk.description, 'Descrição do TedTalk');
    });

    // Teste do toJson
    test('Deve criar um mapa JSON a partir de um objeto TedTalk', () {
      final tedTalk = TedTalk(
        id: '1',
        name: 'Inspiração Diária',
        image: 'image1.jpg',
        speaker: 'Autor 1',
        duration: Duration(minutes: 15),
        description: 'Descrição do TedTalk',
      );

      final json = tedTalk.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'Inspiração Diária');
      expect(json['image'], 'image1.jpg');
      expect(json['speaker'], 'Autor 1');
      expect(json['duration'], 15); // O duration é convertido para minutos
      expect(json['description'], 'Descrição do TedTalk');
    });
  });
}
