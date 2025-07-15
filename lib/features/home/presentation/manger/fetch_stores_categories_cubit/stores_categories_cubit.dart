// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:cityswitch_app/features/home/domain/usecases/featured_store_categories_use_case.dart';

import '../../../domain/entities/stores_category_entites.dart';

part 'stores_categories_state.dart';

class StoresCategoriesCubit extends Cubit<StoresCategoriesState> {
  StoresCategoriesCubit(this.storesCategoriesUseCase)
    : super(StoresCategoriesInitial());
  final StoresCategoriesUseCase storesCategoriesUseCase;
  List<StorsCategoryEntites>? getstoresCategories;
  Future<void> fetchStoresCategories() async {
    emit(StoresCategoriesLoading());
    var result = await storesCategoriesUseCase.call();
    result.fold(
      (failure) {
        emit(StoresCategoriesFailure(errMessage: failure.message));
      },
      (storesCategories) {
        emit(StoresCategoriesSuccess(storesCategories: storesCategories));
        getstoresCategories = storesCategories;
      },
    );
  }
}
