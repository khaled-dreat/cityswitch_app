import 'package:cityswitch_app/core/utils/constant/app_failure.dart';
import 'package:cityswitch_app/features/add_store/data/datasources/add_store_remote_data_source.dart';
import 'package:cityswitch_app/features/add_store/data/models/add_store/m_add_store.dart';
import 'package:cityswitch_app/features/add_store/data/models/search_addresses/search_addresses.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:cityswitch_app/features/my_store_details/data/datasources/edit_my_store_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/edit_my_store_repo.dart';

class EditMyStoreRepoEmpl extends EditMyStoreRepo {
  final EditMyStoreRemoteDataSource editMyStoreRemoteDataSource;

  EditMyStoreRepoEmpl({required this.editMyStoreRemoteDataSource});

  @override
  Future<Either<Failure, AddStoreModel>> editMyStore({
    required AddStoreEntite addStoreModel,
  }) async {
    AddStoreModel user;
    try {
      user = await editMyStoreRemoteDataSource.editMyStore(
        addStoreEntite: addStoreModel,
      );

      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StorsEntites>> fechMyStore({
    required String id,
  }) async {
    StorsEntites storsEntites;
    try {
      storsEntites = await editMyStoreRemoteDataSource.fechMyStore(id: id);

      return right(storsEntites);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
