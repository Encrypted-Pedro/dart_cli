import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../models/bound.dart';

class BoundRepository {
  Future<List<Bound>> findAll() async {
    final userResult = await get(Uri.parse('http://localhost:8080/bound'));
    if (userResult.statusCode != HttpStatus.ok) {
      throw Exception();
    }
    final boundData = jsonDecode(userResult.body);
    return boundData.map<Bound>((user) {
      return Bound.fromMap(user);
    }).toList();
  }

  Future<Bound> findById(int id) async {
    final boundResult = await get(Uri.parse('http://localhost:8080/bound/$id'));
    if (boundResult.statusCode != HttpStatus.ok) {
      throw Exception();
    }
    if (boundResult.body == '{}') {
      throw Exception();
    }
    return Bound.fromJson(boundResult.body);
  }

  Future<void> insert(Bound bound) async {
    final response = await post(Uri.parse('http://localhost:8080/bound'),
        body: bound.toJson(), headers: {'content-type': 'application/json'});
    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
  }

  Future<void> update(Bound bound) async {
    final response = await put(
        Uri.parse('http://localhost:8080/bound/${bound.id}'),
        body: bound.toJson(),
        headers: {'content-type': 'application/json'});
    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final response = await delete(Uri.parse('http://localhost:8080/bound/$id'));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
  }
}
