import 'package:flutter/material.dart';

class TedSummary extends StatelessWidget {
  final int hoursWatched;
  final int tedTalksWatched;

  const TedSummary({Key? key, required this.hoursWatched, required this.tedTalksWatched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horas assistidas: $hoursWatched',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'TED Talks assistidos: $tedTalksWatched',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
