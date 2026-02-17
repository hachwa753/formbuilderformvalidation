abstract class ProductRepo {
  Future<Map<String, dynamic>> getAllProducts(int page, int limit);
  Future<void> deleteData(int id);
}
