import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/models/trailer.dart';
import 'package:thetrailers/services/movie_service.dart';
// import 'package:thetrailers/services/trailer_service.dart';
import 'package:flutter/material.dart';
import 'package:thetrailers/services/trailer_service.dart';

class MoviesTrailersPage extends StatefulWidget {
  MoviesTrailersPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MoviesTrailersPage> createState() => _MoviesTrailersPageState();
}

class _MoviesTrailersPageState extends State<MoviesTrailersPage> {
  Future<void> _createMovie(BuildContext context) async {
    // await Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => const MoviesCreate()),
    // );
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Index'),
      ),
      body: FutureBuilder<List<Trailer>>(
        future: TrailerService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return _MoviesTrailers(snapshot.data!, context);
        },
      ),
    );
  }

  Widget _MoviesTrailers(List<Trailer> list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(list[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        );
      },
    );
  }
}
