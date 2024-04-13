import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';

import '../models/user.dart';

class UserDioRepository {
  Future<List<User>> findAll() async {
    try {
      final userResult = await Dio().get('http://localhost:8080/users');
      return userResult.data.map<User>((user) {
        return User.fromMap(user);
      }).toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<User> findById(int id) async {
    try {
      final userResult = await Dio().get('http://localhost:8080/users/$id');
      if (userResult.data == null) {
        throw Exception();
      }
      return User.fromMap(userResult.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(User user) async {
    try {
      await Dio().post('http://localhost:8080/users', data: user.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(User user) async {
    try {
      await Dio()
          .post('http://localhost:8080/users/${user.id}', data: user.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().post('http://localhost:8080/users/$id');
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}
