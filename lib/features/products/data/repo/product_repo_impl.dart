import 'package:flutter_api_fetch/features/products/data/source/api_source.dart';
import 'package:flutter_api_fetch/features/products/domain/repo/product_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  final ApiSource apiSource;
  ProductRepoImpl(this.apiSource);

  @override
  Future<Map<String, dynamic>> getAllProducts(int page, int limit) async {
    return apiSource.fetchAllProducts(page, limit);
  }

  @override
  Future<void> deleteData(int id) {
    return apiSource.deletePost(id);
  }
}
