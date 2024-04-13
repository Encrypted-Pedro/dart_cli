import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';

import '../models/bound.dart';

class BoundDioRepository {
  Future<List<Bound>> findAll() async {
    try {
      final userResult = await Dio().get('http://localhost:8080/bound');
      return userResult.data.map<Bound>((user) {
        return Bound.fromMap(user);
      }).toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Bound> findById(int id) async {
    try {
      final boundResult = await Dio().get('http://localhost:8080/bound/$id');
      if (boundResult.data == null) {
        throw Exception();
      }
      return Bound.fromMap(boundResult.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Bound bound) async {
    try {
      await Dio().post('http://localhost:8080/bound', data: bound.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Bound bound) async {
    try {
      await Dio()
          .put('http://localhost:8080/bound/${bound.id}', data: bound.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().delete('http://localhost:8080/bound/$id');
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}
