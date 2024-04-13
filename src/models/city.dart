import 'dart:convert';

class City {
  City({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory City.fromMap(Map<String, dynamic> map) {
    return City(id: map['id'] ?? 0, name: map['name'] ?? '');
  }
  factory City.fromJson(String json) => City.fromMap(jsonDecode(json));
}
