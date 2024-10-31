import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          BarraDePesquisa(
              atualizarFiltro:
                  atualizarFiltro), // Passa a função de atualização do filtro
          Expanded(
            child: ListaDeTeds(
                filtroDeBusca:
                    filtroDeBusca), // Passa o filtro de busca para a lista
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
          hintText: 'Buscar TED Talks...',
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

class ListaDeTeds extends StatefulWidget {
  final String filtroDeBusca;

  const ListaDeTeds({Key? key, required this.filtroDeBusca}) : super(key: key);

  @override
  _ListaDeTedsState createState() => _ListaDeTedsState();
}

class _ListaDeTedsState extends State<ListaDeTeds> {
  final List<String> todasListasDeTeds = [
    'Inspiração Diária',
    'Ciência e Tecnologia',
    'Educação e Conhecimento',
    'Desenvolvimento Pessoal',
    'Saúde e Bem-estar',
    'Economia e Negócios',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> listasFiltradas = todasListasDeTeds
        .where((lista) =>
            lista.toLowerCase().contains(widget.filtroDeBusca.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: listasFiltradas.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            title: Text(listasFiltradas[index]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}
