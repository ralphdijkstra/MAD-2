import 'package:flutter/material.dart';
import 'package:movies_app/services/trailer_services.dart';
import 'package:movies_app/models/trailer.dart';

class TrailerEditPage extends StatefulWidget {
  final VoidCallback updateTrailerList;
  final Trailer trailer;

  TrailerEditPage({required this.updateTrailerList, required this.trailer});

  @override
  _TrailerEditPageState createState() => _TrailerEditPageState();
}

class _TrailerEditPageState extends State<TrailerEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.trailer.title;
    _urlController.text = widget.trailer.url;
  }

  Future<void> _updateTrailer(String title, String url) async {
    final updatedTrailer = Trailer(
      id: widget.trailer.id,
      title: title,
      url: url,
    );
    await TrailerService().updateTrailer(updatedTrailer);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trailer updated successfully')),
    );

    widget.updateTrailerList(); // Call the updateTrailerList function in main.dart

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Trailer'),
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

                    _updateTrailer(title, url);
                  }
                },
                child: Text('Update Trailer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}