import 'dart:convert';
import 'package:thetrailers/models/movie.dart';
import 'package:thetrailers/models/trailer.dart';
import 'package:http/http.dart' as http;

class MovieService {
  Future<List<Movie>> getAll() async {
    List<Movie> movies = [];
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/movies'));
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
        trailers: [],
      );

      final List<dynamic> trailers = data[i]['trailers'];
      for (int j = 0; j < trailers.length; j++) {
        final trailer = Trailer(
            id: trailers[j]['id'], title: trailers[j]['title'], url: trailers[j]['url'], movies: []);
        movie.trailers!.add(trailer);
      }
      movies.add(movie);
    }

    return movies;
  }

  Future<Movie> post(Movie movie) async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/movies'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'title': movie.title,
              'year': movie.year,
            }));

    if (response.statusCode != 201) {
      throw Exception('Het is niet gelukt om de movie toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Movie(
        id: result['id'], title: result['title'], year: result['year']);
  }

  Future<Movie> put(int id, Movie movie) async {
    final response =
        await http.put(Uri.parse('http://10.0.2.2:8000/api/movies/$id'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'id': movie.id,
              'title': movie.title,
              'year': movie.year,
            }));

    if (response.statusCode != 200) {
      throw Exception('Het is niet gelukt om de movie toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Movie(
        id: result['id'], title: result['title'], year: result['year']);
  }

  Future<bool> delete(int movieId) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:8000/api/movies/$movieId'));

    return response.statusCode == 200;
  }
}
