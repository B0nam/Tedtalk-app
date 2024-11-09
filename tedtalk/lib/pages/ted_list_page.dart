import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_talk_service.dart';

class TedListPage extends StatefulWidget {
  final TedList tedList;

  const TedListPage({Key? key, required this.tedList}) : super(key: key);

  @override
  _TedListPageState createState() => _TedListPageState();
}

class _TedListPageState extends State<TedListPage> {
  final TedTalkService _tedTalkService = TedTalkService();

  void _adicionarTedTalk() async {
    final novoTedTalk = await showDialog<TedTalk>(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController speakerController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();
        TextEditingController durationController = TextEditingController();
        TextEditingController imageController = TextEditingController();

        return AlertDialog(
          title: const Text('Adicionar TED Talk'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(hintText: 'Nome do TED Talk')),
              TextField(
                  controller: speakerController,
                  decoration: const InputDecoration(hintText: 'Palestrante')),
              TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Descrição')),
              TextField(
                  controller: durationController,
                  decoration:
                      const InputDecoration(hintText: 'Duração (em minutos)'),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: imageController,
                  decoration: const InputDecoration(hintText: 'URL da Imagem')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newId = DateTime.now().millisecondsSinceEpoch.toString();

                final newTedTalk = TedTalk(
                  id: newId,
                  name: nameController.text,
                  speaker: speakerController.text,
                  description: descriptionController.text,
                  duration: Duration(
                      minutes: int.tryParse(durationController.text) ?? 0),
                  image: imageController.text,
                );

                Navigator.of(context).pop(newTedTalk);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );

    if (novoTedTalk != null) {
      setState(() {
        widget.tedList.tedTalks.add(novoTedTalk.id);
      });

      await _tedTalkService.createTedTalk(novoTedTalk);
    }
  }

  Future<TedTalk> _buscarTedTalkCompleto(String id) async {
    final tedTalk = await _tedTalkService.fetchTedTalkById(id);
    return tedTalk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tedList.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total de TED Talks: ${widget.tedList.tedTalks.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TedTalk>>(
              future: Future.wait(widget.tedList.tedTalks
                  .map((id) => _buscarTedTalkCompleto(id))),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Nenhum TED Talk encontrado.'));
                } else {
                  final tedTalks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tedTalks.length,
                    itemBuilder: (context, index) {
                      final tedTalk = tedTalks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          leading: Image.network(
                            "https://store-images.s-microsoft.com/image/apps.698.9007199266296203.3ee303e5-000c-4c1d-9e50-cb965308ca7f.17039190-26bd-4450-b4c2-d918551d8bf0?h=210",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(tedTalk.name),
                          subtitle: Text('Palestrante: ${tedTalk.speaker}'),
                          trailing: Text('${tedTalk.duration.inMinutes} min'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _adicionarTedTalk,
              child: const Text('Adicionar TED Talk'),
            ),
          ),
        ],
      ),
    );
  }
}
