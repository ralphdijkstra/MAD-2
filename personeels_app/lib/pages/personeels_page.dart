import 'package:flutter/material.dart';

class PersoneelsPage extends StatefulWidget {
  const PersoneelsPage({Key? key, required this.setSignedIn}) : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<PersoneelsPage> createState() => _PersoneelsPageState();
}

class _PersoneelsPageState extends State<PersoneelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personeels Index'), actions: [
        IconButton(
          onPressed: () {
            widget.setSignedIn(false);
            },
          icon: Icon(Icons.logout),
        ),
      ]),
      body: ListView(
        children: const [
          // Combobox met functies
          Text('Zet hier een combobox met alle functies'),
          // Lijst met employees
          SizedBox(height: 10,),
          Text('Zet hier een lijst met alle employees met deze functie'),
        ],
      ),
    );
  }
}

