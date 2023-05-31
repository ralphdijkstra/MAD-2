import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/views/video_player_screen.dart';

class MovieTrailersPage extends StatelessWidget {
  final List<Trailer> movieTrailers;

  MovieTrailersPage({required this.movieTrailers});

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
          final thumbnailUrl = YoutubePlayer.getThumbnail(
            videoId: trailer.url,
            quality: ThumbnailQuality.medium,
          );

          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(trailer.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoId: trailer.url),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
