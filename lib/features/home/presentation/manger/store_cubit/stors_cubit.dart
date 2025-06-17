import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/features/home/domain/usecases/stores_by_categore_Id_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/maps_entites.dart';

part 'stros_state.dart';

class StorsCubit extends Cubit<StorsState> {
  StorsCubit(this.storesByCategoreIdUseCase) : super(StorsInitial());

  final StoresByCategoreIdUseCase storesByCategoreIdUseCase;

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
  }
}
