// lib/pages/home.dart
import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/services/ted_list_service.dart';
import 'package:tedtalk/widgets/ted_list_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TedListService _tedListService = TedListService();
  String filtroDeBusca = '';

  void atualizarFiltro(String novoFiltro) {
    setState(() {
      filtroDeBusca = novoFiltro;
    });
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
          Expanded(
            child: FutureBuilder<List<TedList>>(
              future: _tedListService
                  .fetchAllTedLists(), // Carregar todas as listas de TED Talks
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator()); // Carregando
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error: ${snapshot.error}')); // Exibe erro se houver
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                          'No TED Lists available')); // Caso não haja dados
                } else {
                  final listas = snapshot.data!
                      .where((lista) => lista.title.toLowerCase().contains(
                          filtroDeBusca
                              .toLowerCase())) // Aplica o filtro de busca
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
                          subtitle: Text(
                              'Contains ${lista.tedTalks.length} TED Talks'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Navega para a tela de TED Talks dessa lista
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TedTalksListScreen(tedList: lista),
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
          ),
        ],
      ),
    );
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
          hintText: 'Search TED Lists...',
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
