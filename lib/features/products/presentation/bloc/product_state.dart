// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, loaded, success, failure }

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final String? msz;
  final List<Product> product;
  final bool isLoading;
  final bool hasMaxedPosts;
  final int totalPosts;
  const ProductState({
    this.productStatus = ProductStatus.initial,
    this.product = const [],
    this.msz,
    this.isLoading = false,
    this.hasMaxedPosts = false,
    this.totalPosts = 0,
  });

  @override
  List<Object?> get props => [
    productStatus,
    product,
    msz,
    isLoading,
    hasMaxedPosts,
    totalPosts,
  ];

  ProductState copyWith({
    ProductStatus? productStatus,
    String? msz,
    List<Product>? product,
    bool? isLoading,
    bool? hasMaxedPosts,
    int? totalPosts,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      msz: msz ?? this.msz,
      product: product ?? this.product,
      hasMaxedPosts: hasMaxedPosts ?? this.hasMaxedPosts,
      isLoading: isLoading ?? this.isLoading,
      totalPosts: totalPosts ?? this.totalPosts,
    );
  }
}
