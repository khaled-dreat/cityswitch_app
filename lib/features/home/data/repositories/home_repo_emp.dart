import 'package:cityswitch_app/features/home/data/datasources/maps_remote_data_source.dart';
import 'package:cityswitch_app/features/home/domain/entities/maps_entites.dart';
import 'package:cityswitch_app/core/utils/constant/app_failure.dart';
import 'package:cityswitch_app/features/home/domain/entities/store_categories_entites.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/maps_repo.dart';

class HomeRepoEmpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoEmpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<StorsEntites>>> featuredStors() async {
    List<StorsEntites> storsList;
    try {
      storsList = await homeRemoteDataSource.fechStors();

      return right(storsList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StoresCategoriesEntites>>>
  fechStoreCategories() async {
    List<StoresCategoriesEntites> storesCategoriesList;
    try {
      storesCategoriesList = await homeRemoteDataSource.fechStoreCategories();

      return right(storesCategoriesList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
