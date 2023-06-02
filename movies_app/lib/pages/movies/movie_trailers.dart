import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movies_app/models/movie.dart';

class MovieTrailersPage extends StatelessWidget {
  final List<Trailer> movieTrailers;

  const MovieTrailersPage({required this.movieTrailers});

  Future<void> _launchYouTubeVideo(String url) async {
    final Map<String, String> _queryParameters = <String, String>{
      'v': url,
    };
    
    final Uri uri = Uri(
        scheme: "https",
        host: "youtube.com",
        path: "watch",
        queryParameters: _queryParameters);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Trailers'),
      ),
      body: ListView.builder(
        itemCount: movieTrailers.length,
        itemBuilder: (context, index) {
          final trailer = movieTrailers[index];
          return ListTile(
            title: Text(trailer.title),
            // subtitle: Text(trailer.description),
            onTap: () {
              // _launchYouTubeVideo('www.youtube.com/watch?v=${trailer.url}');
              _launchYouTubeVideo(trailer.url);
            },
          );
        },
      ),
    );
  }
}
