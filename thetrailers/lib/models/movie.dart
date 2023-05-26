import 'trailer.dart';

class Movie {
  final int id;
  final String title;
  final String year;
  final List<Trailer>? trailers;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    this.trailers,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      year: json['year'] as String,
    );
  }
}
