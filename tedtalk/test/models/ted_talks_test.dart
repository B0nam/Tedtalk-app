import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/models/ted_talk.dart';

void main() {
  group('Testes do Modelo TedTalk', () {
    test('fromJson deve converter corretamente um mapa para um objeto TedTalk',
        () {
      final json = {
        'id': '1',
        'title': 'TED Talk 1',
      };

      final tedTalk = TedTalk.fromJson(json);

      expect(tedTalk.id, '1');
      expect(tedTalk.title, 'TED Talk 1');
    });

    test('toJson deve converter corretamente um objeto TedTalk para um mapa',
        () {
      final tedTalk = TedTalk(id: '1', title: 'TED Talk 1');

      final json = tedTalk.toJson();

      expect(json, {'id': '1', 'title': 'TED Talk 1'});
    });
  });
}
