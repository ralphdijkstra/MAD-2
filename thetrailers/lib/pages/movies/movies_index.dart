import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/services/movie_service.dart';
import 'package:flutter/material.dart';

class MoviesIndex extends StatefulWidget {
  const MoviesIndex({Key? key}) : super(key: key);

  @override
  State<MoviesIndex> createState() => _MoviesIndexState();
}

class _MoviesIndexState extends State<MoviesIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Index'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: MovieService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return _moviesIndex(snapshot.data!, context);
        },
      ),
    );
  }
}

  Widget _moviesIndex(List<Movie> list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          // leading: _championHobbies(list[index], context),
          title: Row(
            children: [
              Expanded(child: Text(list[index].title)),
              // _editChampion(list[index], context),
              // _deleteChampion(list[index].id, context)
            ],
          ),
          // subtitle: Text('Aantal hobbies: ${list[index].hobbies?.length ?? 0}'),
        );
      },
    );
  }


