import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/failuer.dart';
import 'package:ecommerce_app/data/model/products/product.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<Product>>> getProducts(
      {String? subCategory, String? category, String? brand});
}
