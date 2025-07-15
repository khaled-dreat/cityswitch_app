import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/domain/entities/stores_category_entites.dart';

class EditSelectCategoryDropDownCubit extends Cubit<String?> {
  EditSelectCategoryDropDownCubit() : super(null);

  void selectCategory(String category) {
    emit(category);
  }
}

class EditSelectSubCategoryDropDownCubit extends Cubit<String?> {
  EditSelectSubCategoryDropDownCubit() : super(null);

  void selectCategory(String? category) {
    emit(category);
  }
}

class EditSelectedCategoryCubit extends Cubit<StorsCategoryEntites?> {
  EditSelectedCategoryCubit() : super(null);

  void findSubCategoryById(List<StorsCategoryEntites> categories, String id) {
    try {
      StorsCategoryEntites storesCategories = categories.firstWhere(
        (category) => category.id == id,
      );
      emit(storesCategories);
    } catch (e) {
      // لم يتم العثور على العنصر
      return null;
    }
  }
}
