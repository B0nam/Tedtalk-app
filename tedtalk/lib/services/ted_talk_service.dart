import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tedtalk/models/ted_talk.dart';

class TedTalkService {
  static const String baseUrl = 'http://localhost:3000/tedTalks';

  Future<List<TedTalk>> fetchAllTedTalks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TedTalk.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load TED Talks');
    }
  }

  Future<TedTalk> fetchTedTalkById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return TedTalk.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load TED Talk');
    }
  }

  Future<TedTalk> createTedTalk(TedTalk tedTalk) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tedTalk.toJson()),
    );
    if (response.statusCode == 201) {
      return TedTalk.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create TED Talk');
    }
  }

  Future<void> updateTedTalk(TedTalk tedTalk) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${tedTalk.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tedTalk.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update TED Talk');
    }
  }

  Future<void> deleteTedTalk(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete TED Talk');
    }
  }
}
