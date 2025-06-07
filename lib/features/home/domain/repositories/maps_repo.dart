import 'package:cityswitch_app/features/home/domain/entities/maps_entites.dart';
import 'package:cityswitch_app/features/home/domain/entities/store_categories_entites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/constant/app_failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<StorsEntites>>> featuredStors();
  Future<Either<Failure, List<StoresCategoriesEntites>>> fechStoreCategories();
}
