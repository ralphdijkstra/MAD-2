import 'package:flutter/material.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/pages/movies/movies_index.dart';

void main() {
  runApp(const PersoneelsApp());
}

class PersoneelsApp extends StatefulWidget {
  const PersoneelsApp({Key? key}) : super(key: key);

  @override
  State<PersoneelsApp> createState() => _PersoneelsAppState();
}

class _PersoneelsAppState extends State<PersoneelsApp> {
  bool _signedIn = false;

  void setSignedIn(bool signedIn) {
    setState(() {
      _signedIn = signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_signedIn);
    return MaterialApp(
      home: _signedIn
          ? MovieListPage(setSignedIn: setSignedIn)
          : LoginPage(setSignedIn: setSignedIn),
    );
  }
}