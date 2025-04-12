import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/product/data/model/product_model.dart';
import 'package:frontend/src/features/product/data/source/remote_source.dart';
import 'package:frontend/src/features/product/domain/repo/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._productRemoteSource);

  final ProductRemoteSource _productRemoteSource;

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    return await _productRemoteSource.fetchProducts();
  }

  @override
  addProduct() {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteProduct(String id) async {
    return await _productRemoteSource.deleteProduct(id);
  }

  @override
  updateProduct() {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
