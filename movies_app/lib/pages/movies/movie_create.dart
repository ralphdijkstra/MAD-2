import 'package:flutter/material.dart';
import 'package:movies_app/services/movie_services.dart';
import 'package:movies_app/models/movie.dart';

class MovieCreatePage extends StatefulWidget {
  final VoidCallback updateMovieList;

  MovieCreatePage({required this.updateMovieList});

  @override
  _MovieCreatePageState createState() => _MovieCreatePageState();
}

class _MovieCreatePageState extends State<MovieCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  Future<void> _createMovie(String title, String year) async {
    final movie = Movie(id: 0, title: title, year: year);
    await MovieService().createMovie(movie);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Movie created successfully')),
    );

    widget.updateMovieList(); // Call the updateMovieList function in main.dart

    Navigator.pop(context);
    _titleController.clear();
    _yearController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Movie'),
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

                    _createMovie(title, year);
                  }
                },
                child: Text('Create Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}