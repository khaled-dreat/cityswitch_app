import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../home/domain/entities/stors_entites.dart';

part 'market_details_state.dart';

class MarketDetailsCubit extends Cubit<StorsEntites> {
  MarketDetailsCubit(super.initialState);

  void selectedMarketDetails({required StorsEntites storsEntites}) {
    emit(storsEntites);
  }
}
