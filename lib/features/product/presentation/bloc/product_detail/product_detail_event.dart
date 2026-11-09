abstract class ProductDetailEvent {}

class ProductDetailRequested extends ProductDetailEvent {
  final String productId;

  ProductDetailRequested(this.productId);
}
