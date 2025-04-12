import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/services/network/api_endpoints.dart';
import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/core/services/network/network_service.dart';
import 'package:frontend/src/features/product/data/model/product_model.dart';

class ProductRemoteSource {
  const ProductRemoteSource(this._networkService);
  final NetworkService _networkService;

  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    final response = await _networkService.get(ApiEndpoints.allProducts);
    return response.fold((error) => Left(error), (result) {
      final List<ProductModel> products =
          (result as List<dynamic>)
              .map((e) => ProductModel.fromJson(e))
              .toList();
      return Right(products);
    });
  }
}
