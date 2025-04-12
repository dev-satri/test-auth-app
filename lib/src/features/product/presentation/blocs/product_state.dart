import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/product/data/model/product_model.dart';

class ProductState {
  ProductState({this.productModel, this.isFetching = true, this.failure});
  final List<ProductModel>? productModel;
  final bool isFetching;
  final Failure? failure;

  ProductState copyWith({
    List<ProductModel>? productModel,
    bool? isFetching,
    Failure? failure,
  }) {
    return ProductState(
      productModel: productModel ?? this.productModel,
      isFetching: isFetching ?? this.isFetching,
      failure: failure ?? this.failure,
    );
  }
}
