import 'hobby.dart';

class Champion {
  final int id;
  final String naam;
  final String klas;
  final List<Hobby>? hobbies;

  Champion({
    required this.id,
    required this.naam,
    required this.klas,
    this.hobbies,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      id: json['id'],
      naam: json['naam'],
      klas: json['klas'],
    );
  }

}
