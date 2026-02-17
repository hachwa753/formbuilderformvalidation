import 'package:equatable/equatable.dart';
import 'package:flutter_api_fetch/features/products/domain/model/product.dart';
import 'package:flutter_api_fetch/features/products/domain/repo/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'product_event.dart';
part 'product_state.dart';

@Injectable()
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo repo;
  int page = 1;
  int limit = 6;
  ProductBloc(this.repo) : super(ProductState()) {
    // print("bloc created");
    on<FetchProductEvent>(_fetchProduct);
    on<DeletePost>(_deletePost);
    on<LoadMoreProduct>(_loadMorePosts);
  }

  void _fetchProduct(
    FetchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    await Future.delayed(Duration(milliseconds: 50));
    try {
      page = 1;
      final response = await repo.getAllProducts(page, limit);
      final products = response["data"] as List<Product>;
      final totalCount = response["totalCount"] as int;
      emit(
        state.copyWith(
          product: products,
          totalPosts: totalCount,
          productStatus: ProductStatus.loaded,
          hasMaxedPosts: products.length < limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          msz: "Failed to load images",
        ),
      );
    }
  }

  void _loadMorePosts(LoadMoreProduct event, Emitter<ProductState> emit) async {
    await Future.delayed(Duration(milliseconds: 50));
    if (state.hasMaxedPosts || state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    try {
      page++;
      final response = await repo.getAllProducts(page, limit);
      final newProducts = response["data"] as List<Product>;
      // final totalCount = response["totalCount"] as int;

      emit(
        state.copyWith(
          product: List.from(state.product)..addAll(newProducts),
          productStatus: ProductStatus.loaded,
          isLoading: false,
          hasMaxedPosts: newProducts.length < limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          msz: "Failed to load images",
        ),
      );
    }
  }

  void _deletePost(DeletePost event, Emitter<ProductState> emit) async {
    try {
      await repo.deleteData(event.id);
      final updatedList = state.product.where((e) => e.id != event.id).toList();

      emit(
        state.copyWith(
          product: updatedList,
          productStatus: ProductStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          msz: "Failed to load images",
        ),
      );
    }
  }
}
