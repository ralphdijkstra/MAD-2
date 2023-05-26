import 'movie.dart';

class Trailer {
  final int id;
  final String title;
  final String url;
  final List<Movie>? movies;

  Trailer({
    required this.id,
    required this.title,
    required this.url,
    this.movies,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }
}
