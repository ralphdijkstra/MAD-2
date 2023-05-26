class Movie {
  final int id;
  final String title;
  final String year;

  Movie({
    required this.id,
    required this.title,
    required this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      year: json['year'] as String,
    );
  }

}
