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