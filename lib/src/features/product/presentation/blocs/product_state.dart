import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/product/data/model/product_model.dart';

class ProductState {
  ProductState({
    this.productModel,
    this.isFetching = true,
    this.failure,
    this.deleteResponse,
    this.deleting = false,
  });
  final List<ProductModel>? productModel;
  final bool isFetching;
  final Failure? failure;
  final Map<String, dynamic>? deleteResponse;
  final bool deleting;

  ProductState copyWith({
    List<ProductModel>? productModel,
    bool? isFetching,
    Failure? failure,
    Map<String, dynamic>? deleteResponse,
    bool? deleting,
  }) {
    return ProductState(
      productModel: productModel ?? this.productModel,
      isFetching: isFetching ?? this.isFetching,
      failure: failure ?? this.failure,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      deleting: deleting ?? this.deleting,
    );
  }

  ProductState initial() {
    return ProductState(
      deleteResponse: null,
      failure: null,
      deleting: false,
      productModel: null,
      isFetching: true,
    );
  }
}
