import 'champion.dart';

class Hobby  {
  final int id;
  final String naam;
  final List<Champion>? champions;

  Hobby({
    required this.id,
    required this.naam,
    this.champions,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json['id'],
      naam: json['naam'],
    );
  }

  @override
  bool operator==(Object o) {
    if (o is Hobby) {
      return  o.id == this.id;
    }
    else {
      return false;
    }
  }
}
