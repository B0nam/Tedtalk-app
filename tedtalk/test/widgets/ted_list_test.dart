import 'package:flutter_test/flutter_test.dart';
import 'package:tedtalk/models/ted_talk.dart';

void main() {
  group('TedList', () {
    test('deve filtrar corretamente os TED Talks com base no título', () {
      final tedTalks = [
        TedTalk(id: '1', title: 'Inspiração Diária'),
        TedTalk(id: '2', title: 'Ciência e Tecnologia'),
        TedTalk(id: '3', title: 'Educação e Conhecimento'),
      ];

      final filteredList = tedTalks
          .where((ted) => ted.title.toLowerCase().contains('ciência'))
          .toList();

      expect(filteredList.length, 1);
      expect(filteredList[0].title, 'Ciência e Tecnologia');
    });
  });
}
