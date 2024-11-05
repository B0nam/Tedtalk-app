import 'package:flutter/material.dart';
import '../models/ted_talk.dart';
import '../services/ted_service.dart';

class TedList extends StatelessWidget {
  final String searchFilter;
  final TedService tedService = TedService();

  TedList({Key? key, required this.searchFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TedTalk>>(
      future: tedService.fetchTedTalks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum TED Talk encontrado.'));
        }

        final List<TedTalk> filteredTedTalks = snapshot.data!
            .where((ted) => ted.title.toLowerCase().contains(searchFilter.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: filteredTedTalks.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text(filteredTedTalks[index].title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            );
          },
        );
      },
    );
  }
}
