import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/model/products/product.dart';
import 'package:ecommerce_app/domain/repos/ProductsRepo/products_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;
  ProductsCubit(this.productsRepo) : super(ProductsInitial());

  Future<void> loadProducts(
      {String? subCategory, String? category, String? brand}) async {
    emit(ProductsLoading());
    var result = await productsRepo.getProducts(
        subCategory: subCategory, category: category, brand: brand);
    result.fold((failure) {
      print("❌ Failed to get Products: ${failure.errorMassage}");
      emit(ProductsError(failure.errorMassage));
    }, (products) {
      if (products.isEmpty) {
        print("⚠️ No products found.");
        emit(ProductsEmpty());
      }else
        print("✅ products fetched successfully: ${products.length}");
        emit(ProductsSuccess(products));
      });
  }
}
