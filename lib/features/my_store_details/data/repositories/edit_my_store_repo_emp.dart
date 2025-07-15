import 'package:cityswitch_app/core/utils/constant/app_failure.dart';
import 'package:cityswitch_app/features/my_store_details/data/datasources/edit_my_store_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/edit_my_store_entite.dart';
import '../../domain/entities/my_data_store.dart';
import '../../domain/repositories/edit_my_store_repo.dart';
import '../models/edit_my_store_model/edit_my_store_model.dart';

class EditMyStoreRepoEmpl extends EditMyStoreRepo {
  final EditMyStoreRemoteDataSource editMyStoreRemoteDataSource;

  EditMyStoreRepoEmpl({required this.editMyStoreRemoteDataSource});

  @override
  Future<Either<Failure, EditMyStoreModel>> editMyStore({
    required EditMyStoreEntite editMyStoreEntite,
  }) async {
    EditMyStoreModel user;
    try {
      user = await editMyStoreRemoteDataSource.editMyStore(
        editMyStoreEntite: editMyStoreEntite,
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
  Future<Either<Failure, MyStoreEntite>> fechMyStore({
    required String id,
  }) async {
    MyStoreEntite storsEntites;
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
