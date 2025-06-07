import 'package:cityswitch_app/features/home/domain/repositories/maps_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../entities/maps_entites.dart';

class FeaturedMapsUseCase extends UseCase<List<StorsEntites>, NoParam> {
  final HomeRepo mapsRepo;

  FeaturedMapsUseCase({required this.mapsRepo});

  @override
  Future<Either<Failure, List<StorsEntites>>> call([NoParam? param]) async {
    return await mapsRepo.featuredStors();
  }
}
