import 'package:flutter_api_fetch/features/products/domain/model/product.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocalSource {
  final Box<Product> productBox = Hive.box<Product>("productBox");

  // get all cahed posts
  List<Product> getCachedPosts() => productBox.values.toList();

  //insert or update posts
  Future<void> savePosts(List<Product> products) async {
    //insert or update by unique id
    products.map((product) => productBox.put(product.id, product)).toList();
  }

  // clear cache
  Future<void> clearCache() async => await productBox.clear();
}
