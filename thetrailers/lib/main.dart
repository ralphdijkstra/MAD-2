import 'package:thetrailers/pages/movies/movies_index.dart';
import 'package:thetrailers/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.blue,
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.accessibility_new_rounded)),
                Tab(icon: Icon(Icons.hourglass_top)),
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
