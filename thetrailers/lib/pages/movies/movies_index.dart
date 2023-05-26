import 'package:flutter/material.dart';
import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/pages/movies/movies_create.dart';
import 'package:thetrailers/pages/movies/movies_edit.dart';
import 'package:thetrailers/pages/movies/movies_trailers.dart';
import 'package:thetrailers/services/movie_service.dart';

class MoviesIndex extends StatefulWidget {
  const MoviesIndex({Key? key}) : super(key: key);

  @override
  State<MoviesIndex> createState() => _MoviesIndexState();
}

class _MoviesIndexState extends State<MoviesIndex> {
  Future<void> _createMovie(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MoviesCreate()),
    );
    setState(() {});
  }

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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: _movieTrailers(list[index], context),
            title: Text(list[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _editMovie(list[index], context),
                const SizedBox(width: 10),
                _deleteMovie(list[index].id, context),
              ],
            ),
            subtitle:
                Text('Aantal trailers: ${list[index].trailers?.length ?? 0}'),
          ),
        );
      },
    );
  }

  Widget _editMovie(Movie movie, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MoviesEdit(movie: movie)),
        );
        setState(() {});
      },
      child: const Icon(Icons.edit),
    );
  }

  Widget _deleteMovie(int id, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Movies - Delete'),
              content:
                  const Text('Are you sure you want to delete this movie?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    bool success = await MovieService().delete(id);
                    if (success) {
                      Navigator.of(context).pop(); // Close the dialog
                      setState(() {}); // Update the UI
                    } else {
                      Navigator.of(context).pop(); // Close the dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Movies - Delete'),
                            content: const Text('Deletion failed.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Delete'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.delete_outline),
    );
  }

    Widget _movieTrailers(Movie movie, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MoviesTrailersPage(movie: movie),
        ));
        setState(() {});
      },
      child: const Icon(Icons.account_box_outlined),
    );
  }
}
