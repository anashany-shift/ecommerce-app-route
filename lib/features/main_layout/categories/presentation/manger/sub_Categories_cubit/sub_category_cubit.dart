import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/model/sub_category_model/SubCategory.dart';
import 'package:ecommerce_app/domain/repos/subCategoriesRepo/sub_category_repo.dart';
import 'package:meta/meta.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  final SubCategoryRepo subCategoryRepo;
  SubCategoryCubit(this.subCategoryRepo) : super(SubCategoryInitial());
  Future<void> loadSubCategory(catId) async {
    emit(SubCategoryLoading());
    var result = await subCategoryRepo.getSubCategory(catId);
    result.fold((failure) {
      print("❌ Failed to get Subcategories: ${failure.errorMassage}");
      emit(SubCategoryError(failure.errorMassage));
    }, (category) {
      print("✅ SubCategories fetched successfully: ${category.length}");
      emit(SubCategorySuccess(category));
    });
  }
}



