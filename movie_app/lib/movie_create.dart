import 'package:flutter/material.dart';
import 'movie_api.dart';

class MovieCreatePage extends StatefulWidget {
  @override
  _MovieCreatePageState createState() => _MovieCreatePageState();
}

class _MovieCreatePageState extends State<MovieCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final MovieApi _movieApi = MovieApi();

  Future<void> _createMovie(String title, String year) async {
    await _movieApi.createMovie(title, year);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Movie created successfully')),
    );
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

                    _titleController.clear();
                    _yearController.clear();
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
