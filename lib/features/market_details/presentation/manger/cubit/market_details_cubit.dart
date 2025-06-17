import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/features/home/domain/entities/maps_entites.dart';
import 'package:equatable/equatable.dart';

part 'market_details_state.dart';

class MarketDetailsCubit extends Cubit<StorsEntites> {
  MarketDetailsCubit(super.initialState);

  void selectedMarketDetails({required StorsEntites storsEntites}) {
    emit(storsEntites);
  }
}
