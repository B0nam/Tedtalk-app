import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ted_talk.dart';

const String apiUrl = "http://localhost:3000/tedTalks";

class TedService {
  Future<List<TedTalk>> fetchTedTalks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<TedTalk> contatos =
          body.map((dynamic item) => TedTalk.fromJson(item)).toList();
      return contatos;
    } else {
      throw Exception('Erro ao carregar TedTalk');
    }
  }
}
