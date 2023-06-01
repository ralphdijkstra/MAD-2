import 'package:flutter/material.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/pages/movies/movies_index.dart';

void main() {
  runApp(const PersoneelsApp());
}

class PersoneelsApp extends StatefulWidget {
  const PersoneelsApp({Key? key}) : super(key: key);

  @override
  State<PersoneelsApp> createState() => _PersoneelsAppState();
}

class _PersoneelsAppState extends State<PersoneelsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MovieListPage());
  }
}
