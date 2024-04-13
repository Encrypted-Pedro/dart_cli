import 'package:dio/dio.dart';

import '../models/product.dart';

class ProductDioRepository {
  Future<Product> findByTittle(String tittle) async {
    try {
      final response = await Dio().get('http://localhost:8080/products',
          queryParameters: {'title': tittle});

      if (response.data.isEmpty) {
        throw Exception('Produto não encontrado');
      }
      return Product.fromMap(response.data.first);
    } on DioException {
      throw Exception();
    }
  }
}
