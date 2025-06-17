import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'wrapper_state.dart';

class WrapperCubit extends Cubit<WrapperState> {
  final String boxName;

  WrapperCubit({required this.boxName}) : super(WrapperInitial());

  Future<void> checkUserStatus() async {
    var box = await Hive.openBox<UserEntites>(boxName);
    bool exists = box.containsKey(AppHiveKey.userBoxKey);

    if (exists) {
      emit(UserExists());
    } else {
      emit(UserDoesNotExist());
    }
  }
}
