import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_talk_service.dart';

@GenerateMocks([TedTalkService])
void main() {
  late MockTedService mockTedService;

  setUp(() {
    mockTedService = MockTedService();
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

    when(mockTedService.fetchTedTalks()).thenAnswer((_) async => tedTalksMock);

    final tedTalks = await mockTedService.fetchTedTalks();

    expect(tedTalks.length, 3);
    expect(tedTalks[0].title, '1');
    expect(tedTalks[1].title, '2');
    expect(tedTalks[2].title, '3');
  });

  test('Deve lançar exceção se a resposta da API for inválida', () async {
    when(mockTedService.fetchTedTalks())
        .thenThrow(Exception('Erro ao carregar TedTalk'));

    expect(() async => await mockTedService.fetchTedTalks(), throwsException);
  });
}
