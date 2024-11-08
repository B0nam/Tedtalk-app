import 'package:flutter/material.dart';

class TedSearchBar extends StatelessWidget {
  final Function(String) updateFilter;

  const TedSearchBar({Key? key, required this.updateFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: TextField(
        onChanged: updateFilter,
        decoration: InputDecoration(
          hintText: 'Search TED Talks...',
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
