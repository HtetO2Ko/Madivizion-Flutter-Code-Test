import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/domain/repositories/product_repository.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;

  ProductDetailBloc({required this.productRepository})
    : super(ProductDetailInitial()) {
    on<ProductDetailRequested>(_onProductDetailRequested);
  }

  Future<void> _onProductDetailRequested(
    ProductDetailRequested event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    try {
      final product = await productRepository.getProductById(event.productId);

      if (product == null) {
        emit(ProductDetailNotFound());
        return;
      }

      emit(ProductDetailSuccess(product));
    } catch (e) {
      emit(ProductDetailError('Unable to load product details.'));
    }
  }
}
