import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../models/product.dart';

class ProductRepository {
  Future<Product> findByTittle(String tittle) async {
    final response =
        await get(Uri.parse('http://localhost:8080/products?title=$tittle'));
    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
    final responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception('Produto não encontrado');
    }
    return Product.fromMap(responseData.first);
  }
}
