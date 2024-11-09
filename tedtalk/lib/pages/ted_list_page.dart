import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/models/ted_talk.dart'; // Importando o TedTalk
import 'package:tedtalk/services/ted_list_service.dart';
import 'package:tedtalk/services/ted_talk_service.dart'; // Servico para pegar dados completos do TED Talk

class TedListPage extends StatefulWidget {
  final TedList tedList;

  const TedListPage({Key? key, required this.tedList}) : super(key: key);

  @override
  _TedListPageState createState() => _TedListPageState();
}

class _TedListPageState extends State<TedListPage> {
  final TedListService _tedListService = TedListService();
  final TedTalkService _tedTalkService =
      TedTalkService(); // Serviço para pegar o TED Talk completo

  // Função para adicionar um TED Talk à lista
  void _adicionarTedTalk() async {
    final novoTedTalkId = await showDialog<int>(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Adicionar TED Talk'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'ID do TED Talk'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(int.tryParse(controller.text) ?? 0);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );

    if (novoTedTalkId != null && novoTedTalkId > 0) {
      setState(() {
        widget.tedList.tedTalks
            .add(novoTedTalkId); // Adiciona o ID na lista de IDs
      });

      // Atualiza a lista de TED Talks no serviço
      await _tedListService.updateTedList(widget.tedList);
    }
  }

  // Função para buscar o TED Talk completo baseado no ID
  Future<TedTalk> _buscarTedTalk(int id) async {
    return await _tedTalkService
        .fetchTedTalkById(id); // Busca os detalhes do TED Talk com o ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tedList.title),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      ),
      body: Column(
        children: [
          // Exibe a quantidade de TED Talks na lista
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total de TED Talks: ${widget.tedList.tedTalks.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Lista os TED Talks
          Expanded(
            child: FutureBuilder<List<TedTalk>>(
              future: Future.wait(
                widget.tedList.tedTalks.map((id) => _buscarTedTalk(id)),
              ),
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
                              fit: BoxFit.cover),
                          title: Text(tedTalk.name),
                          subtitle: Text(
                              'Duração: ${tedTalk.duration.inMinutes} min\nPor: ${tedTalk.speaker}'),
                          isThreeLine: true,
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
