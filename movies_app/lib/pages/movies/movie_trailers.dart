import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/trailer.dart';
import 'package:movies_app/pages/trailers/trailer_create.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieTrailersPage extends StatelessWidget {
  final Movie movie;
  final bool signedIn;

  const MovieTrailersPage({
    required this.movie,
    required this.signedIn,
  });

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
    final List<Trailer>? trailers = movie.trailers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Trailers'),
      ),
      body: ListView.builder(
        itemCount: trailers?.length ?? 0,
        itemBuilder: (context, index) {
          final Trailer? trailer = trailers?[index];
          return ListTile(
            title: Text(trailer?.title ?? ''),
            onTap: () {
              if (trailer != null) {
                _launchYouTubeVideo(trailer.url);
              }
            },
            trailing: signedIn
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Handle delete functionality
                        },
                      ),
                    ],
                  )
                : null,
          );
        },
      ),
      floatingActionButton: signedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrailerCreatePage(movie: movie),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
