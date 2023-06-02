import 'package:flutter/material.dart';
import 'package:movies_app/pages/movies/movies_index.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatefulWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  State<MoviesApp> createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MovieListPage());
  }
}
