import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/core/usecase/usecase.dart';
import 'package:cityswitch_app/features/my_store_details/domain/usecases/edit_my_store%20_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/local_data/app_local_data_key.dart';
import '../../../../../core/utils/style/app_colers.dart';
import '../../../../../core/utils/widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../auth/domain/entities/user_entites.dart';
import '../../../data/models/edit_my_store_model/edit_my_store_model.dart';
import '../../../data/models/image_update/image_update.dart';
import '../../../domain/entities/edit_my_store_entite.dart';

part 'edit_my_store_state.dart';

class EditMyStoreCubit extends Cubit<EditMyStoreState> {
  EditMyStoreCubit(this.editMyStoreUseCase) : super(EditMyStoreInitial());
  final EditMyStoreUseCase editMyStoreUseCase;

  EditMyStoreEntite editMyStoreEntite = EditMyStoreEntite();
  Future<String?> getUserId() async {
    var box = Hive.box<UserEntites>(AppHiveKey.userBoxKey);

    return box.values.first.data!.id!;
  }

  ImageUpdateModel imageUpdateModel = ImageUpdateModel();
  Future<void> editMyStore({required BuildContext context}) async {
    // editMyStoreEntite.setLocation(storeLocation);
    if (imageUpdateModel.totalDisplayedImages == 5) {
      emit(EditMyStoreLoading());
      if (editMyStoreEntite.category?.length != null) {
        emit(EditMyStoreLoading());
        if (editMyStoreEntite.subCategory?.length != null) {
          emit(EditMyStoreLoading());

          if (editMyStoreEntite.tags?.length == 3) {
            emit(EditMyStoreLoading());

            editMyStoreEntite.setOwnerId(await getUserId());
            log(editMyStoreEntite.toMap().toString());

            var result = await editMyStoreUseCase.call(editMyStoreEntite);
            result.fold(
              (failure) {
                log(name: "failure", failure.message);
                //     AppValidators.updateMessagesFromErrors(failure.message);

                emit(EditMyStoreFailurel(errMessage: failure.message));
              },
              (store) {
                emit(EditMyStoreSuccess(editMyStoreModel: store));
              },
            );
          } else {
            emit(EditTagsValidator(" * Please select 3 Tags"));

            showSnackBar(context, "Please select 3 Tags", AppColors.orangeDark);
          }
        } else {
          emit(EditSubCategoryValidator(msg: " * Please select a subcategory"));

          showSnackBar(
            context,
            "Please select a subcategory",
            AppColors.orangeDark,
          );
        }
      } else {
        emit(EditCategoryValidator(msg: " * Please select a category"));

        showSnackBar(context, "Please select a category", AppColors.orangeDark);
      }
    } else {
      emit(EditImagesValidator(" * Please select 5 photos"));
      showSnackBar(context, "Please select 5 photos", AppColors.orangeDark);
    }
  }
}
