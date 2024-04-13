import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../models/user.dart';

class UserRepository {
  Future<List<User>> findAll() async {
    final userResult = await get(Uri.parse('http://localhost:8080/users'));
    if (userResult.statusCode != HttpStatus.ok) {
      throw Exception();
    }
    final userData = jsonDecode(userResult.body);
    return userData.map<User>((user) {
      return User.fromMap(user);
    }).toList();
  }

  Future<User> findById(int id) async {
    final userResult = await get(Uri.parse('http://localhost:8080/users/$id'));
    if (userResult.statusCode != HttpStatus.ok) {
      throw Exception();
    }
    if (userResult.body == '{}') {
      throw Exception();
    }
    return User.fromJson(userResult.body);
  }

  Future<void> insert(User user) async {
    final response = await post(Uri.parse('http://localhost:8080/users'),
        body: user.toJson(), headers: {'content-type': 'application/json'});
    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
  }

  Future<void> update(User user) async {
    final response = await put(
        Uri.parse('http://localhost:8080/users/${user.id}'),
        body: user.toJson(),
        headers: {'content-type': 'application/json'});
    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final response = await delete(Uri.parse('http://localhost:8080/users/$id'));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
  }
}
