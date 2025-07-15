import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/features/my_store_details/domain/entities/edit_my_store_entite.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/local_data/app_local_data_key.dart';
import '../../../../../core/utils/style/app_colers.dart';
import '../../../../../core/utils/widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../add_store/domain/entities/add_store.dart';
import '../../../../auth/domain/entities/user_entites.dart';
import '../../../../home/domain/entities/stors_entites.dart';
import '../../../data/models/image_update/image_update.dart';
import '../../../domain/entities/my_data_store.dart';
import '../../../domain/usecases/stores_by_user_Id_use_case.dart';

part 'my_store_state.dart';

class MyStoreCubit extends Cubit<MyStoreState> {
  final StoresByUserIdUseCase storesByUserIdUseCase;
  bool _fetched = false;
  bool hasStore = false; // ← تستخدمها لاحقًا في الـ Wrapper

  MyStoreCubit(this.storesByUserIdUseCase) : super(MyStoreInitial());

  Future<void> fetchMyStoresByUserIdOnce() async {
    if (_fetched) return;
    _fetched = true;

    emit(MyStoreLoading());

    final id = await getUserId();
    if (id == null) {
      emit(const MyStoreFailurel(errMessage: "User ID not found."));
      return;
    }

    final result = await storesByUserIdUseCase.call(id);
    result.fold(
      (failure) {
        emit(MyStoreFailurel(errMessage: failure.message));
      },
      (stores) {
        hasStore = stores.name != null && stores.name!.isNotEmpty;
        emit(MyStoreSuccess(myStore: stores));
      },
    );
  }

  Future<String?> getUserId() async {
    final box = Hive.box<UserEntites>(AppHiveKey.userBoxKey);
    return box.isNotEmpty ? box.values.first.data?.id : null;
  }
}
