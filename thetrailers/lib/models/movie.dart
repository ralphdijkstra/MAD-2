class Movie {
  final int id;
  final String title;
  final String year;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      posterUrl: json['poster_url'],
    );
  }
}