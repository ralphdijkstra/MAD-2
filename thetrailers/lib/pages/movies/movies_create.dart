import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/services/movie_service.dart';
import 'package:flutter/material.dart';


class MoviesCreate extends StatefulWidget {
  const MoviesCreate({Key? key}) : super(key: key);

  @override
  State<MoviesCreate> createState() => _MoviesCreateState();
}

class _MoviesCreateState extends State<MoviesCreate> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Movies - Create')),
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

                // Year
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
                            id: 0,
                            title: _titleController.text,
                            year: _yearController.text);
                        movie = await MovieService().post(movie);
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
