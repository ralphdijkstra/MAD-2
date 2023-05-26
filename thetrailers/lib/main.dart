import 'package:thetrailers/pages/movies/movies_index.dart';
import 'package:thetrailers/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.blue,
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.movie)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HomePage(),
              MoviesIndex(),
            ],
          ),
        ),
      ),
    );
  }
}
