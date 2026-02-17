part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {}

class LoadMoreProduct extends ProductEvent {}

class DeletePost extends ProductEvent {
  final int id;

  const DeletePost(this.id);
}
