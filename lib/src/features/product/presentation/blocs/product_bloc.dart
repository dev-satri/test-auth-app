import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/src/features/product/domain/repo/product_repo.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_event.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._productRepository) : super(ProductState()) {
    on<FetchAllProductEvent>(_fetchProduct);
  }

  final ProductRepository _productRepository;

  void _fetchProduct(
    FetchAllProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isFetching: true));
    final response = await _productRepository.fetchProducts();
    response.fold(
      (error) {
        emit(state.copyWith(isFetching: false, failure: error));
      },
      (result) {
        emit(state.copyWith(isFetching: false, productModel: result));
      },
    );
  }
}
