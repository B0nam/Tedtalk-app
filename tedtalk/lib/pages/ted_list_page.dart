import 'package:flutter/material.dart';
import 'package:tedtalk/controller/ted_list_controller.dart';
import 'package:tedtalk/controller/ted_talk_controller.dart';
import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/widgets/ted_talk_dialog.dart';

class TedListPage extends StatefulWidget {
  final TedList tedList;

  const TedListPage({Key? key, required this.tedList}) : super(key: key);

  @override
  _TedListPageState createState() => _TedListPageState();
}

class _TedListPageState extends State<TedListPage> {
  final TedListController _tedListController = TedListController();
  final TedTalkController _tedTalkController = TedTalkController();

  Future<void> _reloadTedTalks() async {
    setState(() {});
  }

  Future<void> _adicionarTedTalk() async {
    final novoTedTalk = await showDialog<TedTalk>(
      context: context,
      builder: (context) => const TedTalkDialog(),
    );

    if (novoTedTalk != null) {
      await _tedListController.addTedTalkToList(widget.tedList, novoTedTalk);
      _reloadTedTalks();
    }
  }

  Future<void> _editarTedTalk(TedTalk tedTalk) async {
    final updatedTedTalk = await showDialog<TedTalk>(
      context: context,
      builder: (context) => TedTalkDialog(tedTalk: tedTalk),
    );

    if (updatedTedTalk != null) {
      await _tedTalkController.updateTedTalk(updatedTedTalk);
      _reloadTedTalks();
    }
  }

  Future<void> _removerTedTalk(String tedTalkId) async {
    await _tedListController.removeTedTalkFromList(widget.tedList, tedTalkId);
    await _tedListController.deleteTedTalk(tedTalkId);
    _reloadTedTalks();
  }

  Future<void> _removerTedList() async {
    await _tedListController.deleteTedList(widget.tedList);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tedList.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _removerTedList,
          ),
        ],
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
              future: _tedListController.fetchTedTalks(widget.tedList.tedTalks),
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _editarTedTalk(tedTalk),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removerTedTalk(tedTalk.id),
                              ),
                            ],
                          ),
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
