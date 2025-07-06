import 'package:cityswitch_app/core/utils/constant/app_failure.dart';
import 'package:cityswitch_app/features/add_store/data/datasources/add_store_remote_data_source.dart';
import 'package:cityswitch_app/features/add_store/data/models/add_store/m_add_store.dart';
import 'package:cityswitch_app/features/add_store/data/models/search_addresses/search_addresses.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/add_store_repo.dart';

class AddStoreRepoEmpl extends AddStoreRepo {
  final AddStoreDataSourceImp addStoreDataSourceImp;

  AddStoreRepoEmpl({required this.addStoreDataSourceImp});

  @override
  Future<Either<Failure, AddStoreModel>> addStore({
    required AddStoreEntite addStoreModel,
  }) async {
    AddStoreModel user;
    try {
      user = await addStoreDataSourceImp.addStore(
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
  Future<Either<Failure, List<SearchAddressesModel>>> getSearchAddresses({
    required String endPoint,
  }) async {
    List<SearchAddressesModel> addresses;
    try {
      addresses = await addStoreDataSourceImp.getSearchAddresses(
        endPoint: endPoint,
      );

      return right(addresses);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
