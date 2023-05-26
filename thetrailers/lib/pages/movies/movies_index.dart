import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/pages/movies/movies_create.dart';
import 'package:thetrailers/pages/movies/movies_edit.dart';
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
floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _createMovie(context),
      ),
    );
  }

  Widget _moviesIndex(List<Movie> list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Expanded(child: Text(list[index].title)),
              _editMovie(list[index], context),
              _deleteMovie(list[index].id, context)
            ],
          ),
        );
      },
    );
  }

  Future<void> _createMovie(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MoviesCreate(),
    ));
    setState(() {});
  }

  Widget _editMovie(Movie movie, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MoviesEdit(movie: movie),
        ));
        setState(() {});
      },
      child: const Icon(Icons.edit),
    );
  }

  Widget _deleteMovie(int id, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool gelukt = await MovieService().delete(id);
        if (gelukt) {
          setState(() {});
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Movies - Delete'),
                  content: const Text('Verwijderen is mislukt'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Ok'))
                  ],
                );
              },
            );
          }
        }
      },
      child: const Icon(Icons.delete_outline),
    );
  }
}
