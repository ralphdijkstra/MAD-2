import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thetrailers/models/movie.dart';

class MovieService {
  Future<List<Movie>> getAll() async {
    List<Movie> movies = [];
    final response =
    await http.get(Uri.parse('http://127.0.0.1:8000/api/movies'));
    if (response.statusCode != 200) {
      throw Exception(
          'Fout bij het ophalen van alle movies (${response.statusCode}).');
    }

    final List<dynamic> data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      final movie = Movie(
          id: data[i]['id'],
          title: data[i]['title'],
          year: data[i]['year'],
          posterUrl: data[i]['poster_url']);
      movies.add(movie);
    } 

    return movies;
  }

}
