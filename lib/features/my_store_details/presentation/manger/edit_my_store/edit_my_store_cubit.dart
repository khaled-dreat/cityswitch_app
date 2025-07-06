import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/local_data/app_local_data_key.dart';
import '../../../../../core/utils/style/app_colers.dart';
import '../../../../../core/utils/widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../add_store/data/models/add_store/location.dart';
import '../../../../add_store/data/models/add_store/m_add_store.dart';
import '../../../../add_store/data/models/search_addresses/search_addresses.dart';
import '../../../../add_store/domain/entities/add_store.dart';
import '../../../../add_store/presentation/manger/add_store/add_store_cubit.dart';
import '../../../../auth/domain/entities/user_entites.dart';
import '../../../domain/usecases/edit_my_store _use_case.dart';
part 'edit_my_store_state.dart';

class EditMyStoreCubit extends Cubit<EditMyStoreState> {
  EditMyStoreCubit(this.editMyStoreUseCase) : super(AddMarketInitial());

  final EditMyStoreUseCase editMyStoreUseCase;

  AddStoreEntite addStoreEntite = AddStoreEntite();

  LocationModel storeLocation = LocationModel();

  Future<void> getUserId() async {
    var box = Hive.box<UserEntites>(AppHiveKey.userBoxKey);

    addStoreEntite.ownerId = box.values.first.data!.id!;
  }

  Future<void> addStore({required BuildContext context}) async {
    addStoreEntite.setLocation(storeLocation);
    getUserId();

    if (addStoreEntite.images?.length == 5) {
      emit(AddStoreLoading());
      if (addStoreEntite.category?.length != null) {
        emit(AddStoreLoading());
        if (addStoreEntite.subCategory?.length != null) {
          emit(AddStoreLoading());

          if (addStoreEntite.tags?.length == 3) {
            emit(AddStoreLoading());

            log("StoresCategoriesSuccess");
            var result = await editMyStoreUseCase.call(addStoreEntite);

            result.fold(
              (failure) {
                log(name: "failure", failure.message);
                //     AppValidators.updateMessagesFromErrors(failure.message);

                emit(AddStoreFailure(errMessage: failure.message));
              },
              (store) {
                emit(AddStoreSuccess(store: store));
              },
            );
          } else {
            emit(AddTagsValidator(" * Please select 3 Tags"));

            showSnackBar(context, "Please select 3 Tags", AppColors.orangeDark);
          }
        } else {
          emit(AddSubCategoryValidator(msg: " * Please select a subcategory"));

          showSnackBar(
            context,
            "Please select a subcategory",
            AppColors.orangeDark,
          );
        }
      } else {
        emit(AddCategoryValidator(msg: " * Please select a category"));

        showSnackBar(context, "Please select a category", AppColors.orangeDark);
      }
    } else {
      emit(AddImagesValidator(" * Please select 5 photos"));
      showSnackBar(context, "Please select 5 photos", AppColors.orangeDark);
    }
  }
}
