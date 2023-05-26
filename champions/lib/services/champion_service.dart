import 'dart:convert';
import 'package:champions/models/champion.dart';
import 'package:champions/models/hobby.dart';
import 'package:http/http.dart' as http;

class ChampionService {
  Future<List<Champion>> getAll() async {
    List<Champion> champions = [];
    final response =
        await http.get(Uri.parse('https://flutapi.summaict.nl/api/champions'));
    if (response.statusCode != 200) {
      throw Exception(
          'Fout bij het ophalen van alle champions (${response.statusCode}).');
    }

    final List<dynamic> data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      final champion = Champion(
          id: data[i]['id'],
          naam: data[i]['naam'],
          klas: data[i]['klas'],
          hobbies: []);

      final List<dynamic> hobbies = data[i]['hobbies'];
      for (int j = 0; j < hobbies.length; j++) {
        final hobby = Hobby(
            id: hobbies[j]['id'], naam: hobbies[j]['naam'], champions: []);
        champion.hobbies!.add(hobby);
      }
      champions.add(champion);
    }

    return champions;
  }

  Future<Champion> post(Champion champion) async {
    final response =
        await http.post(Uri.parse('https://flutapi.summaict.nl/api/champions'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'naam': champion.naam,
              'klas': champion.klas,
            }));

    if (response.statusCode != 201) {
      throw Exception('Het is niet gelukt om de champion toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Champion(
        id: result['id'], naam: result['naam'], klas: result['klas']);
  }

  Future<Champion> put(int id, Champion champion) async {
    final response = await http.put(
        Uri.parse('https://flutapi.summaict.nl/api/champions/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': champion.id,
          'naam': champion.naam,
          'klas': champion.klas,
        }));

    if (response.statusCode != 200) {
      throw Exception('Het is niet gelukt om de champion toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Champion(
        id: result['id'], naam: result['naam'], klas: result['klas']);
  }

  Future<bool> delete(int championId) async {
    final response = await http.delete(
        Uri.parse('https://flutapi.summaict.nl/api/champions/$championId'));

    return response.statusCode == 200;
  }

  Future<bool> addHobbyToChampion(int championId, int hobbyId) async {
    final response = await http.post(Uri.parse(
        'https://flutapi.summaict.nl/api/champions/${championId}/hobbies/${hobbyId}'));

    return response.statusCode == 200;
  }

  Future<bool> deleteHobbyFromChampion(int championId, int hobbyId) async {
    final response = await http.delete(Uri.parse(
        'https://flutapi.summaict.nl/api/champions/${championId}/hobbies/${hobbyId}'));

    return response.statusCode == 200;
  }
}
