import 'package:cityswitch_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:cityswitch_app/features/home/domain/entities/stores_category_entites.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:cityswitch_app/core/utils/constant/app_failure.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/maps_repo.dart';
import '../models/search_store/m_search_parmeter.dart';

class HomeRepoEmpl extends HomeRepo {
  final StoresRemoteDataSource homeRemoteDataSource;

  HomeRepoEmpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<StorsEntites>>> fechSearchstores({
    SearchParmeterModel? searchParmeterModel,
  }) async {
    List<StorsEntites> storesList;
    try {
      storesList = await homeRemoteDataSource.fechSearchstores(
        keyword: searchParmeterModel?.keyword,
        category: searchParmeterModel?.category,
        subCategory: searchParmeterModel?.subCategory,
      );

      return right(storesList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StorsCategoryEntites>>> fechCategore() async {
    List<StorsCategoryEntites> storsList;
    try {
      storsList = await homeRemoteDataSource.fechCategore();

      return right(storsList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
