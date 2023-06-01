class Movie {
  final int id;
  final String title;
  final String year;
  final String? posterUrl;
  final List<Trailer>? trailers;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    this.posterUrl,
    this.trailers,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final trailers = json['trailers'] as List<dynamic>;
    return Movie(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      posterUrl: json['poster_url'],
      trailers: trailers.map((trailerJson) => Trailer.fromJson(trailerJson)).toList(),
    );
  }
}

class Trailer {
  final int id;
  final String title;
  final String url;

  Trailer({
    required this.id,
    required this.title,
    required this.url,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}