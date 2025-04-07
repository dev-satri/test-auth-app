import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_event.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on<FetchAllProductEvent>(_fetchProduct);
  }

  void _fetchProduct(FetchAllProductEvent event, Emitter<ProductState> emit) {}
}
