import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/api_manger.dart';
import 'package:ecommerce_app/data/model/products/ProductResponse.dart';

import '../../core/errors/failuer.dart';
import '../../domain/repos/ProductsRepo/products_repo.dart';
import '../model/products/product.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ApiManger apiManger;

  ProductsRepoImpl(this.apiManger);
  @override
  Future<Either<Failure, List<Product>>> getProducts(
      {String? subCategory, String? category, String? brand}) async {

    try {
      Map<String,dynamic>params={};
      if(subCategory!=null){
        params["subcategory[in]"]=subCategory;
      }
      if(category!=null){
        params["category[in]"]=category;
      }
      if(brand!=null){
        params["brand"]=brand;
      }



      var response = await apiManger.get(endPoint:'api/v1/products',queryParam: params);
      var productResponse=ProductResponse.fromJson(response);
      return right(productResponse.data??[] );
    }  catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure(e.toString()));
      }

    }
  }
}
