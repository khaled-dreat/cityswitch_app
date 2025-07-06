import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/local_data/app_local_data_key.dart';
import '../../../../auth/domain/entities/user_entites.dart';
import '../../../../home/domain/entities/stors_entites.dart';
import '../../../domain/usecases/stores_by_user_Id_use_case.dart';

part 'my_store_state.dart';

class MyStoreCubit extends Cubit<MyStoreState> {
  MyStoreCubit(this.storesByCategoreIdUseCase) : super(MyStoreInitial());
  final StoresByUserIdUseCase storesByCategoreIdUseCase;
  Future<String?> getUserId() async {
    var box = Hive.box<UserEntites>(AppHiveKey.userBoxKey);

    return box.values.first.data!.id!;
  }

  void saveMyStoreData(StorsEntites userEntites, String boxName) async {
    var box = Hive.box<StorsEntites>(boxName);
    await box.put(boxName, userEntites);
  }

  Future<void> fetchMyStoresByUserId() async {
    var id = await getUserId();
    emit(MyStoreLoading());
    var result = await storesByCategoreIdUseCase.call(id);
    result.fold(
      (failure) {
        emit(MyStoreFailurel(errMessage: failure.message));
      },
      (stors) {
        emit(MyStoreSuccess(myStore: stors));
        saveMyStoreData(stors, AppHiveKey.storeBoxKey);
      },
    );
  }
}
