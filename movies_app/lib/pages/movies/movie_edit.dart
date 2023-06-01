import 'package:flutter/material.dart';
import 'package:movies_app/services/movie_services.dart';
import 'package:movies_app/models/movie.dart';

class MovieEditPage extends StatefulWidget {
  final VoidCallback updateMovieList;
  final Movie movie;

  MovieEditPage({required this.updateMovieList, required this.movie});

  @override
  _MovieEditPageState createState() => _MovieEditPageState();
}

class _MovieEditPageState extends State<MovieEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.movie.title;
    _yearController.text = widget.movie.year;
  }

  Future<void> _updateMovie(String title, String year) async {
    final updatedMovie = Movie(
      id: widget.movie.id,
      title: title,
      year: year,
    );
    await MovieService().updateMovie(updatedMovie);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Movie updated successfully')),
    );

    widget.updateMovieList(); // Call the updateMovieList function in main.dart

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final title = _titleController.text;
                    final year = _yearController.text;

                    _updateMovie(title, year);
                  }
                },
                child: Text('Update Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}