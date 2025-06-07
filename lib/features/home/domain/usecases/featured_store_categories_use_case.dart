import 'package:cityswitch_app/features/home/domain/entities/store_categories_entites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../repositories/maps_repo.dart';

class FeaturedStoresCategoriesUseCase
    extends UseCase<List<StoresCategoriesEntites>, NoParam> {
  final HomeRepo homeRepo;

  FeaturedStoresCategoriesUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<StoresCategoriesEntites>>> call([
    NoParam? param,
  ]) async {
    return await homeRepo.fechStoreCategories();
  }
}
