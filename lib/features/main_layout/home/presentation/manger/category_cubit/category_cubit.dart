import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/model/categories_models/category.dart';
import 'package:ecommerce_app/domain/repos/HomeRepo/home_repo.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.homeRepo) : super(CategoryInitial());
  final HomeRepo homeRepo;

  Future<void> loadCategory() async {
    emit(CategoryLoading());
    var result = await homeRepo.getCategory();
    result.fold((failure) {
      print("❌ Failed to get categories: ${failure.errorMassage}");
      emit(CategoryError(failure.errorMassage));
    }, (category) {
      print("✅ Categories fetched successfully: ${category.length}");
      emit(CategorySuccess(category));
    });
  }
}
