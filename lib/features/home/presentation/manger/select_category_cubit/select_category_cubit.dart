import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/stores_category_entites.dart';

class SelectCategoryDropDownCubit extends Cubit<String?> {
  SelectCategoryDropDownCubit() : super(null);

  void selectCategory(String category) {
    emit(category);
  }
}

class SelectSubCategoryDropDownCubit extends Cubit<String?> {
  SelectSubCategoryDropDownCubit() : super(null);

  void selectCategory(String? category) {
    emit(category);
  }
}

class SelectedCategoryCubit extends Cubit<StorsCategoryEntites?> {
  SelectedCategoryCubit() : super(null);

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
