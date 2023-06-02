import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationName: 'movies_app',
              applicationVersion: '1.0.0',
              applicationLegalese: 'Copyright © 2023 - Ralph Dijkstra',
            );
          },
          child: const Text('Show About Dialog'),
        ),
      ),
    );
  }
}
