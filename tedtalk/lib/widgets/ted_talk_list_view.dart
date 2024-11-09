import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_talk.dart';

class TedTalkListView extends StatelessWidget {
  final Future<List<TedTalk>> tedTalksFuture;
  final Function(String) onRemove;
  final Function(TedTalk) onEdit;

  const TedTalkListView({
    Key? key,
    required this.tedTalksFuture,
    required this.onRemove,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TedTalk>>(
      future: tedTalksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum TED Talk encontrado.'));
        } else {
          final tedTalks = snapshot.data!;
          return ListView.builder(
            itemCount: tedTalks.length,
            itemBuilder: (context, index) {
              final tedTalk = tedTalks[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: Image.network(
                    "https://store-images.s-microsoft.com/image/apps.698.9007199266296203.3ee303e5-000c-4c1d-9e50-cb965308ca7f.17039190-26bd-4450-b4c2-d918551d8bf0?h=210",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(tedTalk.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Palestrante: ${tedTalk.speaker}'),
                      Text('Duração: ${tedTalk.duration.inMinutes} minutos'),
                      Text('Descrição: ${tedTalk.description}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => onEdit(tedTalk),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onRemove(tedTalk.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
