import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieApi {
  static const String apiUrl = 'http://10.0.2.2:8000/api/movies';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  Future<void> deleteMovie(int movieId) async {
    final url = Uri.parse('$apiUrl/$movieId');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception('Failed to delete movie');
    }
  }

    Future<void> createMovie(String title, String year) async {
    final url = Uri.parse('$apiUrl/movies');
    final response = await http.post(
      url,
      body: {
        'title': title,
        'year': year,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create movie');
    }
  }
}
