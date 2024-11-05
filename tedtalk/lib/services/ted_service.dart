import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ted_talk.dart';

class TedService {
  final String baseUrl = 'http://localhost:3000/tedTalks';

  Future<List<TedTalk>> fetchTedTalks() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((json) => TedTalk.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar os TED Talks');
      }
    } catch (error) {
      // Logando o erro
      print('Erro ao buscar TED Talks: $error');
      throw Exception('Falha ao carregar os TED Talks: $error');
    }
  }
}
