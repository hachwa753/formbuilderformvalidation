import 'package:flutter_api_fetch/features/products/data/source/api_source.dart';
import 'package:flutter_api_fetch/features/products/data/source/local_source.dart';
import 'package:flutter_api_fetch/features/products/domain/model/product.dart';

import 'package:flutter_api_fetch/features/products/domain/repo/product_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  final ApiSource apiSource;
  final LocalSource localSource;
  ProductRepoImpl(this.apiSource, this.localSource);

  @override
  Future<Map<String, dynamic>> getAllProducts(int page, int limit) async {
    try {
      final cachedProducts = localSource.getCachedPosts();
      if (page == 1 && cachedProducts.isNotEmpty) {
        //background fetch
        _fetchAndUpdate(page, limit);
        //return cached products immediately
        final results = await apiSource.fetchAllProducts(page, limit);
        return {"data": cachedProducts, "totalCount": results["totalCount"]};
      }
      // else
      //other pages or empty cache fetch normally
      final products = await _fetchAndUpdate(page, limit);
      final results = await apiSource.fetchAllProducts(page, limit);
      return {"data": products, "totalCount": results["totalCount"]};
    } catch (e) {
      throw Exception("Failed to fetch products");
    }
  }

  @override
  Future<void> deleteData(int id) {
    return apiSource.deletePost(id);
  }

  //get cached Products instantly

  Future<List<Product>> _fetchAndUpdate(int page, int limit) async {
    try {
      final results = await apiSource.fetchAllProducts(page, limit);
      final List<Product> products = results["data"];
      await localSource.savePosts(products);
      //returned full cached list after update
      return localSource.getCachedPosts();
    } catch (e) {
      throw Exception("Failed to fetch error");
    }
  }

  @override
  List<Product> getCachedProducts() {
    return localSource.getCachedPosts();
  }
}
