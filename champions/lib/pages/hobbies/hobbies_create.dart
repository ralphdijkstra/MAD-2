import 'package:champions/models/hobby.dart';
import 'package:champions/services/hobby_service.dart';
import 'package:flutter/material.dart';


class HobbiesCreate extends StatefulWidget {
  const HobbiesCreate({Key? key}) : super(key: key);

  @override
  State<HobbiesCreate> createState() => _HobbiesCreateState();
}

class _HobbiesCreateState extends State<HobbiesCreate> {
  final _formKey = GlobalKey<FormState>();
  final _naamController = TextEditingController();

  @override
  void dispose() {
    _naamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hobbies - Create')),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                // Naam
                TextFormField(
                  controller: _naamController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Naam',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vul naam in';
                    }
                    return null;
                  },
                ),

                // Save / Cancel
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Verbeter de fouten')),
                          );
                        }
                        ;
                        var hobby = Hobby(
                            id: 0,
                            naam: _naamController.text);
                        hobby = await HobbyService().post(hobby);
                        Navigator.pop(context);
                      },
                      child: Text('Bewaren'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Annuleren'),
                    ),
                  ],
                )
              ],
            )));
  }
}
