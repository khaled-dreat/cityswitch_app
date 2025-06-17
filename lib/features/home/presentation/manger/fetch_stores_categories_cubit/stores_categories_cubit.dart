// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/features/home/domain/entities/store_categories_entites.dart';
import 'package:equatable/equatable.dart';

import 'package:cityswitch_app/features/home/domain/usecases/featured_store_categories_use_case.dart';

part 'stores_categories_state.dart';

class StoresCategoriesCubit extends Cubit<StoresCategoriesState> {
  StoresCategoriesCubit(this.featuredMapsUseCase)
    : super(StoresCategoriesInitial());
  final StoresCategoriesUseCase featuredMapsUseCase;

  Future<void> fetchStoresCategories() async {
    emit(StoresCategoriesLoading());
    var result = await featuredMapsUseCase.call();
    result.fold(
      (failure) {
        emit(StoresCategoriesFailure(errMessage: failure.message));
      },
      (storesCategories) {
        emit(StoresCategoriesSuccess(storesCategories: storesCategories));
      },
    );
  }
}
