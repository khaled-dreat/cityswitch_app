import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../entities/stores_category_entites.dart';
import '../repositories/maps_repo.dart';

class StoresCategoriesUseCase
    extends UseCase<List<StorsCategoryEntites>, NoParam> {
  final HomeRepo homeRepo;

  StoresCategoriesUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<StorsCategoryEntites>>> call([
    NoParam? param,
  ]) async {
    return await homeRepo.fechCategore();
  }
}
