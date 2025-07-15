import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/core/utils/widgets/toast/app_toast.dart';
import 'package:cityswitch_app/features/add_store/data/models/add_store/store.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:cityswitch_app/features/add_store/domain/usecases/fetch_search_addresses_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';

import '../../../../../core/utils/widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../auth/domain/entities/user_entites.dart';
import '../../../data/models/add_store/location.dart';
import '../../../data/models/add_store/m_add_store.dart';
import '../../../data/models/search_addresses/search_addresses.dart';
import '../../../domain/usecases/add_store _use_case.dart';

part 'add_store_state.dart';

class AddStoreCubit extends Cubit<AddStoreState> {
  AddStoreCubit(this.addStoreUseCase, this.fetchSearchAddressesUseCase)
    : super(AddMarketInitial());

  final AddStoreUseCase addStoreUseCase;
  final FetchSearchAddressesUseCase fetchSearchAddressesUseCase;

  AddStoreEntite addStoreEntite = AddStoreEntite();

  LocationModel storeLocation = LocationModel();

  Future<void> getUserId() async {
    var box = Hive.box<UserEntites>(AppHiveKey.userBoxKey);

    addStoreEntite.ownerId = box.values.first.data!.id!;
  }

  Future<void> fetchSearchAddresses({required String endPoint}) async {
    emit(AddStoreLoading());

    // var result = await fetchSearchAddressesUseCase.call(endPoint);

    // result.fold(
    //   (failure) {
    //     emit(SearchAddressesFailure(errMessage: failure.message));
    //     //  log();
    //     //      log(name: "failure", failure.message);
    //     //      AppValidators.updateMessagesFromErrors(failure.message);

    //     //      emit(AddUserFailure(errMessage: failure.message));
    //   },
    //   (user) {
    //     emit(SearchAddressesSuccess(searchAddressesModel: user));
    //     log(user.length.toString());
    //     // log(user.toJson().toString());
    //     //    emit(RegisterationSuccess(user: user));
    //   },
    // );
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
            var result = await addStoreUseCase.call(addStoreEntite);

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
