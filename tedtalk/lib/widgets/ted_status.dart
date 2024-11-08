import 'package:flutter/material.dart';

class TedStatus extends StatefulWidget {
  const TedStatus({Key? key}) : super(key: key);

  @override
  _TedStatusState createState() => _TedStatusState();
}

class _TedStatusState extends State<TedStatus> {
  int hoursWatched = 10;
  int tedTalksWatched = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hours Watched: $hoursWatched',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'TED Talks Watched: $tedTalksWatched',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
