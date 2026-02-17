import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api_fetch/core/network/dio_client.dart';
import 'package:flutter_api_fetch/features/products/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ApiSource {
  final Dio dio = DioClient().client;

  Future<Map<String, dynamic>> fetchAllProducts(int page, int limit) async {
    try {
      final response = await dio.get(
        '/posts',
        queryParameters: {"_page": page, "_limit": limit},
      );
      if (response.statusCode == 200) {
        // print(response.data);
        final List data = response.data as List;

        final totalCount = int.parse(
          response.headers.value('x-total-count') ?? "0",
        );
        // log(data.toString());
        return {
          "data": data.map((e) => Product.fromMap(e)).toList(),
          "totalCount": totalCount,
        };
      } else {
        throw Exception("Failed to fetch posts: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to fetch posts: ${e.message}");
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await dio.delete('/posts/$id');
    } on DioException catch (e) {
      throw Exception("Failed to fetch posts: ${e.message}");
    }
  }
}
