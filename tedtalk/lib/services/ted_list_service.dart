import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tedtalk/models/ted_list.dart';

class TedListService {
  static const String baseUrl = 'http://localhost:4000/tedLists';

  Future<List<TedList>> fetchAllTedLists() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TedList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load TED Lists');
    }
  }

  Future<TedList> fetchTedListById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return TedList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load TED List');
    }
  }

  Future<TedList> createTedList(TedList tedList) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tedList.toJson()),
    );
    if (response.statusCode == 201) {
      return TedList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create TED List');
    }
  }

  // Método atualizado para aceitar o objeto completo de TedList
  Future<TedList> updateTedList(TedList tedList) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${tedList.id}'), // Usando o ID da lista diretamente
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tedList.toJson()),
    );
    if (response.statusCode == 200) {
      return TedList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update TED List');
    }
  }

  Future<void> deleteTedList(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete TED List');
    }
  }
}
