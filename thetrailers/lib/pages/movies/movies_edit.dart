import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/services/movie_service.dart';
import 'package:flutter/material.dart';

class MoviesEdit extends StatefulWidget {
  const MoviesEdit({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<MoviesEdit> createState() => _MoviesEditState();
}

class _MoviesEditState extends State<MoviesEdit> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.movie.title;
    _yearController.text = widget.movie.year;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Movies - Edit')),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vul title in';
                    }
                    return null;
                  },
                ),

                // Years
                TextFormField(
                  controller: _yearController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Year',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vul year in';
                    }
                    return null;
                  },
                ),

                // Save / Cancel
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Verbeter de fouten')),
                          );
                        }
                        ;
                        var movie = Movie(
                            id: widget.movie.id,
                            title: _titleController.text,
                            year: _yearController.text);
                        movie = await MovieService()
                            .put(widget.movie.id, movie);
                        Navigator.pop(context);
                      },
                      child: Text('Bewaren'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Annuleren'),
                    ),
                  ],
                )
              ],
            )));
  }
}
