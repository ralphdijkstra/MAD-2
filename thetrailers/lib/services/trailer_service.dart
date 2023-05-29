import 'dart:convert';
import 'package:thetrailers/models/trailer.dart';
import 'package:thetrailers/models/movie.dart';
import 'package:http/http.dart' as http;

class TrailerService {
  Future<List<Trailer>> getAll() async {
    List<Trailer> trailers = [];
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/trailers'));
    if (response.statusCode != 200) {
      throw Exception(
          'Fout bij het ophalen van alle trailers (${response.statusCode}).');
    }

    final List<dynamic> data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      final trailer = Trailer(
        id: data[i]['id'],
        title: data[i]['title'],
        url: data[i]['url'],
        movies: [],
      );

      // final List<dynamic> movies = data[i]['movies'];
      // for (int j = 0; j < movies.length; j++) {
      //   final movie = Movie(
      //       id: movies[j]['id'], title: movies[j]['title'], year: movies[j]['year'], trailers: []);
      //   trailer.movies!.add(movie);
      // }
      trailers.add(trailer);
    }

    return trailers;
  }

  Future<Trailer> post(Trailer trailer) async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/trailers'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'title': trailer.title,
              'url': trailer.url,
            }));

    if (response.statusCode != 201) {
      throw Exception('Het is niet gelukt om de trailer toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Trailer(
        id: result['id'], title: result['title'], url: result['url']);
  }

  Future<Trailer> put(int id, Trailer trailer) async {
    final response =
        await http.put(Uri.parse('http://10.0.2.2:8000/api/trailers/$id'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'id': trailer.id,
              'title': trailer.title,
              'url': trailer.url,
            }));

    if (response.statusCode != 200) {
      throw Exception('Het is niet gelukt om de trailer toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Trailer(
        id: result['id'], title: result['title'], url: result['url']);
  }

  Future<bool> delete(int trailerId) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:8000/api/trailers/$trailerId'));

    return response.statusCode == 200;
  }
}
