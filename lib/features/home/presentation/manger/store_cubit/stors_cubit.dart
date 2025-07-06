// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cityswitch_app/features/home/domain/usecases/search_store_use_case.dart';
import 'package:cityswitch_app/features/my_store_details/domain/usecases/stores_by_user_Id_use_case.dart';

import '../../../data/models/search_store/m_search_parmeter.dart';
import '../../../domain/entities/stors_entites.dart';

part 'stros_state.dart';

class StorsCubit extends Cubit<StorsState> {
  StorsCubit(this.searchStoresUseCase) : super(StorsInitial());

  final SearchStoresUseCase searchStoresUseCase;

  Future<void> fetchSearchStores({
    required SearchParmeterModel searchParmeterModel,
  }) async {
    emit(StorsLoading());
    var result = await searchStoresUseCase.call(searchParmeterModel);
    result.fold(
      (failure) {
        emit(StorsFailure(errMessage: failure.message));
      },
      (stors) {
        emit(StorsSuccess(stors: stors));
      },
    );
  }

  /*
  Future<void> fetchstoresByCategoreId({required String id}) async {
    emit(StorsLoading());
    var result = await storesByCategoreIdUseCase.call(id);
    result.fold(
      (failure) {
        emit(StorsFailure(errMessage: failure.message));
      },
      (stors) {
        emit(StorsSuccess(stors: stors));
      },
    );
  }*/
}
