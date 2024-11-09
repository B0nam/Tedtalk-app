import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/services/ted_list_service.dart';

import 'ted_list_service_test.mocks.dart';
import 'ted_talk_service_test.mocks.dart';

@GenerateMocks([TedListService])
void main() {
  late MockTedListService mockedTedListService;

  setUp(() {
    mockedTedListService = MockTedListService();
  });

  test('Verificar se a lista de TED Talks é carregada corretamente', () async {
    final tedListMock = [
      TedList(id: '1', title: '1', tedTalks: ['1','2','3']),
      TedList(id: '2', title: '2', tedTalks: ['1','2','3']),
      TedList(id: '3', title: '3', tedTalks: ['1','2','3'])
    ];

    when(mockedTedListService.fetchAllTedLists()).thenAnswer((_) async => tedListMock);

    final tedTalks = await mockedTedListService.fetchAllTedLists();

    expect(tedTalks.length, 3);
  });

  test('Deve lançar exceção se a resposta da API for inválida', () async {
    when(mockedTedListService.fetchAllTedLists())
        .thenThrow(Exception('Erro ao carregar TedTalk'));

    expect(() async => await mockedTedListService.fetchAllTedLists(), throwsException);
  });
}
