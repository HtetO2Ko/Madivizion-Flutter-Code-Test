import '../../../../home/domain/entities/product.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final Product product;

  ProductDetailSuccess(this.product);
}

class ProductDetailNotFound extends ProductDetailState {}

class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError(this.message);
}
