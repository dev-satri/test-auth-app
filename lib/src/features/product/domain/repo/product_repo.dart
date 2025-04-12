import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/product/data/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts();
  addProduct();
  updateProduct();
  Future<Either<Failure, Map<String, dynamic>>> deleteProduct(String id);
}
