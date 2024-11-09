import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/services/ted_list_service.dart';
import 'package:tedtalk/services/ted_talk_service.dart';
import 'ted_list_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TedListService _tedListService = TedListService();
  final TedTalkService _tedTalkService = TedTalkService();
  String filtroDeBusca = '';

  void atualizarFiltro(String novoFiltro) {
    setState(() {
      filtroDeBusca = novoFiltro;
    });
  }

  Future<void> _reload() async {
    setState(() {});
  }

  void _criarNovaLista() async {
    final novoTitulo = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Criar nova Lista de TED Talks'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Título da lista'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Criar'),
            ),
          ],
        );
      },
    );

    if (novoTitulo != null && novoTitulo.isNotEmpty) {
      final novoId = DateTime.now().millisecondsSinceEpoch;

      final novaLista =
          TedList(id: novoId.toString(), title: novoTitulo, tedTalks: []);

      await _tedListService.createTedList(novaLista);
      _reload();
    }
  }

  Future<void> _removerLista(TedList lista) async {
    // Apagar todos os TED Talks dessa lista antes de excluir a lista
    for (var tedTalk in lista.tedTalks) {
      await _tedTalkService.deleteTedTalk(tedTalk);
    }
    // Agora remove a lista em si
    await _tedListService.deleteTedList(lista.id);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ResumoAssistido(),
          BarraDePesquisa(atualizarFiltro: atualizarFiltro),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: _criarNovaLista,
              child: const Text('Criar Nova Lista'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TedList>>(
              future: _tedListService.fetchAllTedLists(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma lista encontrada'));
                } else {
                  final listas = snapshot.data!
                      .where((lista) => lista.title
                          .toLowerCase()
                          .contains(filtroDeBusca.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: listas.length,
                    itemBuilder: (context, index) {
                      final lista = listas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListTile(
                          title: Text(lista.title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _editarLista(lista);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  bool confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Confirmar Exclusão'),
                                            content: const Text(
                                                'Tem certeza que deseja excluir esta lista?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: const Text('Excluir'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;

                                  if (confirm) {
                                    await _removerLista(lista);
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TedListPage(tedList: lista),
                              ),
                            ).then((_) {
                              _reload(); // Force reload after returning from the TedListPage
                            });
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editarLista(TedList lista) async {
    final novoTitulo = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: lista.title);
        return AlertDialog(
          title: const Text('Editar Lista de TED Talks'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Novo título da lista'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (novoTitulo != null && novoTitulo.isNotEmpty) {
      final listaAtualizada =
          TedList(id: lista.id, title: novoTitulo, tedTalks: lista.tedTalks);
      await _tedListService.updateTedList(listaAtualizada);
      _reload();
    }
  }
}

class ResumoAssistido extends StatefulWidget {
  const ResumoAssistido({Key? key}) : super(key: key);

  @override
  _ResumoAssistidoState createState() => _ResumoAssistidoState();
}

class _ResumoAssistidoState extends State<ResumoAssistido> {
  int horasAssistidas = 10;
  int tedTalksAssistidos = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horas assistidas: $horasAssistidas',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'TED Talks assistidos: $tedTalksAssistidos',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BarraDePesquisa extends StatelessWidget {
  final Function(String) atualizarFiltro;

  const BarraDePesquisa({Key? key, required this.atualizarFiltro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: TextField(
        onChanged: atualizarFiltro,
        decoration: InputDecoration(
          hintText: 'Buscar lista...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
