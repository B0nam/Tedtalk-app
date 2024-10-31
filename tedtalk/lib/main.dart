import 'package:flutter/material.dart';
import 'package:tedtalk/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TedTalk App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(235, 0, 39, 1),
        ),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
