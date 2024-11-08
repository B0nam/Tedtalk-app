import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_list_service.dart';
import 'package:tedtalk/services/ted_talk_service.dart';
import 'package:tedtalk/models/ted_list.dart';

class TedListWidget extends StatefulWidget {
  const TedListWidget({Key? key}) : super(key: key);

  @override
  _TedListWidgetState createState() => _TedListWidgetState();
}

class _TedListWidgetState extends State<TedListWidget> {
  final TedListService _tedListService = TedListService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TED Lists'),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      ),
      body: FutureBuilder<List<TedList>>(
        future: _tedListService.fetchAllTedLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No TED Lists available'));
          } else {
            final tedLists = snapshot.data!;
            return ListView.builder(
              itemCount: tedLists.length,
              itemBuilder: (context, index) {
                final tedList = tedLists[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(tedList.title),
                    subtitle:
                        Text('Contains ${tedList.tedTalks.length} TED Talks'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TedTalksListScreen(tedList: tedList),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TedTalksListScreen extends StatelessWidget {
  final TedList tedList;

  const TedTalksListScreen({Key? key, required this.tedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tedList.title),
      ),
      body: ListView.builder(
        itemCount: tedList.tedTalks.length,
        itemBuilder: (context, index) {
          final tedTalkId = tedList.tedTalks[index];
          // Você pode usar o serviço de TedTalkService para pegar os detalhes do TED Talk
          return FutureBuilder<TedTalk>(
            future: TedTalkService().fetchTedTalkById(tedTalkId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No TED Talk found'));
              } else {
                final tedTalk = snapshot.data!;
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(tedTalk.name),
                    subtitle: Text('Speaker: ${tedTalk.speaker}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
