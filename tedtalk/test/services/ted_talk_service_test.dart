import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_talk_service.dart';

import 'ted_talk_service_test.mocks.dart';

@GenerateMocks([TedTalkService])
void main() {
  late MockTedTalkService mockTedTalkService;

  setUp(() {
    mockTedTalkService = MockTedTalkService();
  });

  test('Verificar se a lista de TED Talks é carregada corretamente', () async {
    final tedTalksMock = [
      TedTalk(
          id: '1',
          name: '1',
          image: '1',
          speaker: '1',
          duration: const Duration(minutes: 1),
          description: '1'),
      TedTalk(
          id: '2',
          name: '2',
          image: '2',
          speaker: '2',
          duration: const Duration(minutes: 2),
          description: '2'),
      TedTalk(
          id: '3',
          name: '3',
          image: '3',
          speaker: '3',
          duration: const Duration(minutes: 3),
          description: '3'),
    ];

    when(mockTedTalkService.fetchAllTedTalks()).thenAnswer((_) async => tedTalksMock);

    final tedTalks = await mockTedTalkService.fetchAllTedTalks();

    expect(tedTalks.length, 3);
  });

  test('Deve lançar exceção se a resposta da API for inválida', () async {
    when(mockTedTalkService.fetchAllTedTalks())
        .thenThrow(Exception('Erro ao carregar TedTalk'));

    expect(() async => await mockTedTalkService.fetchAllTedTalks(), throwsException);
  });
}
