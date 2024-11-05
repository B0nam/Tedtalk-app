import 'package:flutter/material.dart';
import '../widgets/ted_summary.dart';
import '../widgets/ted_search_bar.dart';
import '../widgets/ted_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchFilter = '';

  void updateFilter(String newFilter) {
    setState(() {
      searchFilter = newFilter;
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
          const TedSummary(hoursWatched: 10, tedTalksWatched: 5),
          TedSearchBar(onFilterChange: updateFilter),
          Expanded(
            child: TedList(searchFilter: searchFilter),
          ),
        ],
      ),
    );
  }
}
