import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_service.dart';

import 'ted_service_test.mocks.dart';

@GenerateMocks([TedService])
void main() {
  late MockTedService mockTedService;

  setUp(() {
    mockTedService = MockTedService();
  });

  test('Verificar se a lista de TED Talks é carregada corretamente', () async {
    final tedTalksMock = [
      TedTalk(id: '1', title: 'Inspiração Diária'),
      TedTalk(id: '2', title: 'Ciência e Tecnologia'),
      TedTalk(id: '3', title: 'Educação e Conhecimento'),
    ];

    when(mockTedService.fetchTedTalks()).thenAnswer((_) async => tedTalksMock);

    final tedTalks = await mockTedService.fetchTedTalks();

    expect(tedTalks.length, 3);
    expect(tedTalks[0].title, 'Inspiração Diária');
    expect(tedTalks[1].title, 'Ciência e Tecnologia');
    expect(tedTalks[2].title, 'Educação e Conhecimento');
  });

  test('Deve lançar exceção se a resposta da API for inválida', () async {
    when(mockTedService.fetchTedTalks())
        .thenThrow(Exception('Erro ao carregar TedTalk'));

    expect(() async => await mockTedService.fetchTedTalks(), throwsException);
  });
}
