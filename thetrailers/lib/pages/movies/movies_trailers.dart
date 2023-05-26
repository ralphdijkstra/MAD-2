import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/models/trailer.dart';
import 'package:thetrailers/services/movie_service.dart';
// import 'package:thetrailers/services/trailer_service.dart';
import 'package:flutter/material.dart';

class MoviesTrailersPage extends StatefulWidget {
  MoviesTrailersPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MoviesTrailersPage> createState() => _MoviesTrailersPageState();
}

class _MoviesTrailersPageState extends State<MoviesTrailersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title)),
      body: Column(),
    );
  }
}
