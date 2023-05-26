import 'dart:convert';
import 'package:champions/models/champion.dart';
import 'package:champions/models/hobby.dart';
import 'package:http/http.dart' as http;

class HobbyService {
  Future<List<Hobby>> getAll() async {
    List<Hobby> hobbies = [];
    final response =
        await http.get(Uri.parse('https://flutapi.summaict.nl/api/hobbies'));
    if (response.statusCode != 200) {
      throw Exception(
          'Fout bij het ophalen van alle hobbies (${response.statusCode}).');
    }

    final List<dynamic> data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      final hobby = Hobby(
          id: data[i]['id'],
          naam: data[i]['naam'],
          champions: []);

      final List<dynamic> champions = data[i]['champions'];
      for (int j = 0; j < champions.length; j++) {
        final champion = Champion(
            id: champions[j]['id'], naam: champions[j]['naam'], klas: champions[j]['klas'], hobbies: []);
        hobby.champions!.add(champion);
      }
      hobbies.add(hobby);
    }

    return hobbies;
  }

  Future<Hobby> post(Hobby hobby) async {
    final response =
        await http.post(Uri.parse('https://flutapi.summaict.nl/api/hobbies'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'naam': hobby.naam,
            }));

    if (response.statusCode != 201) {
      throw Exception('Het is niet gelukt om de hobby toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Hobby(
        id: result['id'], naam: result['naam']);
  }

  Future<Hobby> put(int id, Hobby hobby) async {
    final response = await http.put(
        Uri.parse('https://flutapi.summaict.nl/api/hobbies/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': hobby.id,
          'naam': hobby.naam,
        }));

    if (response.statusCode != 200) {
      throw Exception('Het is niet gelukt om de hobby toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Hobby(
        id: result['id'], naam: result['naam']);
  }

  Future<bool> delete(int hobbyId) async {
    final response = await http.delete(
        Uri.parse('https://flutapi.summaict.nl/api/hobbies/$hobbyId'));

    return response.statusCode == 200;
  }
}