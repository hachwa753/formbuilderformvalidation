import 'package:flutter_api_fetch/features/products/domain/model/product.dart';

abstract class ProductRepo {
  Future<Map<String, dynamic>> getAllProducts(int page, int limit);
  List<Product> getCachedProducts();
  Future<void> deleteData(int id);
}
