import 'package:flutter/material.dart';
import 'package:movies_app/pages/about_page.dart';
import 'package:movies_app/pages/home_page.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/pages/movies/movies_index.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatefulWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  State<MoviesApp> createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _signedIn = false;
  late Widget _homePage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _homePage = LoginPage(
      setSignedIn: setSignedIn,
      setHomePage: setHomePage,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void setSignedIn(bool signedIn) {
    setState(() {
      _signedIn = signedIn;
      if (_signedIn) {
        _homePage = HomePage();
      } else {
        _homePage = LoginPage(
          setSignedIn: setSignedIn,
          setHomePage: setHomePage,
        );
      }
    });
  }

  void setHomePage(Widget homePage) {
    setState(() {
      _homePage = homePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_signedIn ? 'Movies App (Signed In)' : 'Movies App'),
          actions: _signedIn
              ? [
                  IconButton(
                    onPressed: () {
                      setSignedIn(false);
                    },
                    icon: Icon(Icons.logout),
                  ),
                ]
              : null,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.movie), text: 'Movies'),
              Tab(icon: Icon(Icons.info), text: 'About'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _homePage,
            MovieListPage(signedIn: _signedIn),
            AboutPage(),
          ],
        ),
      ),
    );
  }
}
