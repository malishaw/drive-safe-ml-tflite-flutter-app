import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_mobile/screens/first_screen.dart';
import 'package:rock_paper_scissors_mobile/screens/scanner_screen.dart';
import 'package:rock_paper_scissors_mobile/screens/startpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drive Safe',
      home: FirstScreen(),
    );
  }
}
