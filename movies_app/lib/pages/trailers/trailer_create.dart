import 'package:flutter/material.dart';
import 'package:movies_app/services/trailer_services.dart';
import 'package:movies_app/models/trailer.dart';

class TrailerCreatePage extends StatefulWidget {
  final int movieId;
  final VoidCallback updateTrailerList;

  TrailerCreatePage({required this.movieId, required this.updateTrailerList});

  @override
  _TrailerCreatePageState createState() => _TrailerCreatePageState();
}

class _TrailerCreatePageState extends State<TrailerCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  Future<void> _createTrailer(String title, String url) async {
    final trailer = Trailer(id: 0, title: title, url: url,);
    await TrailerService().createTrailer(trailer, widget.movieId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trailer created successfully')),
    );

    widget.updateTrailerList(); // Call the updateTrailerList function in main.dart

    Navigator.pop(context);
    _titleController.clear();
    _urlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trailer'),
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
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'Url',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a url';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final title = _titleController.text;
                    final url = _urlController.text;

                    _createTrailer(title, url);
                  }
                },
                child: Text('Create Trailer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}