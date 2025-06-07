import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/features/home/domain/usecases/featured_maps_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/maps_entites.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<MapState> {
  HomeCubit(this.featuredMapsUseCase) : super(HomeInitial());

  final FeaturedMapsUseCase featuredMapsUseCase;

  Future<void> fetchStors() async {
    emit(MapLoading());
    var result = await featuredMapsUseCase.call();
    result.fold(
      (failure) {
        emit(MapFailure(errMessage: failure.message));
      },
      (stors) {
        emit(MapSuccess(stors: stors));
      },
    );
  }
}
