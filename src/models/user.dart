import 'dart:convert';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  String toJson() => jsonEncode(toMap());
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] ?? 0,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '');
  }
  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));
}
