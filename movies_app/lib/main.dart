import 'package:flutter/material.dart';
import 'package:movies_app/pages/movies/movies_index.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListPage(),
    );
  }
}
