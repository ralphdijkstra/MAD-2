import 'package:flutter/material.dart';
import 'package:movies_app/models/trailer.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/pages/trailers/trailer_create.dart';
import 'package:movies_app/pages/trailers/trailer_edit.dart';
import 'package:movies_app/services/trailer_services.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieTrailersPage extends StatefulWidget {
  final Movie movie;
  final bool signedIn;

  MovieTrailersPage({required this.movie, required this.signedIn});

  @override
  _MovieTrailersPageState createState() => _MovieTrailersPageState();
}

class _MovieTrailersPageState extends State<MovieTrailersPage> {
  List<Trailer>? _trailers = [];

  Future<void> _launchYouTubeVideo(String url) async {
    final Map<String, String> queryParameters = <String, String>{
      'v': url,
    };

    final Uri uri = Uri(
        scheme: "https",
        host: "youtube.com",
        path: "watch",
        queryParameters: queryParameters);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTrailers();
  }

  Future<void> _fetchTrailers() async {
    try {
      final trailers = await TrailerService().fetchTrailers(widget.movie.id);
      setState(() {
        _trailers = trailers;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  void _deleteTrailer(int? trailerId) {
    if (trailerId != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this trailer?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  await TrailerService().deleteTrailer(trailerId);
                  Navigator.pop(context);
                  _fetchTrailers();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Trailer deleted successfully')),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: ListView.builder(
        itemCount: _trailers?.length ?? 0,
        itemBuilder: (context, index) {
          final Trailer? trailer = _trailers?[index];
          return ListTile(
            title: Text(trailer?.title ?? ''),
            onTap: () {
              if (trailer != null) {
                _launchYouTubeVideo(trailer.url);
              }
            },
            trailing: widget.signedIn
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrailerEditPage(
                                updateTrailerList: _fetchTrailers,
                                trailer: trailer!,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTrailer(trailer?.id),
                      ),
                    ],
                  )
                : null,
          );
        },
      ),
      floatingActionButton: widget.signedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrailerCreatePage(
                      movieId: widget.movie.id,
                      updateTrailerList: _fetchTrailers,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
