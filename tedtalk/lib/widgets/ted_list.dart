import 'package:flutter/material.dart';
import '../models/ted_talk.dart';
import '../services/ted_service.dart';

class TedList extends StatefulWidget {
  final String searchFilter;

  const TedList({Key? key, required this.searchFilter}) : super(key: key);

  @override
  _TedListState createState() => _TedListState();
}

class _TedListState extends State<TedList> {
  List<TedTalk> tedTalks = [];
  final TedService tedService = TedService();

  @override
  void initState() {
    super.initState();
    loadTedTalks();
  }

  Future<void> loadTedTalks() async {
    try {
      final fetchedTedTalks = await tedService.fetchTedTalks();
      setState(() {
        tedTalks = fetchedTedTalks;
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TedTalk> filteredTedTalks = tedTalks
        .where((ted) => ted.title.toLowerCase().contains(widget.searchFilter.toLowerCase()))
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
  }
}
