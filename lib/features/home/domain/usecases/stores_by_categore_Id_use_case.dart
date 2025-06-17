import 'package:cityswitch_app/features/home/domain/repositories/maps_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../entities/maps_entites.dart';

class StoresByCategoreIdUseCase extends UseCase<List<StorsEntites>, String> {
  final HomeRepo mapsRepo;

  StoresByCategoreIdUseCase({required this.mapsRepo});

  @override
  Future<Either<Failure, List<StorsEntites>>> call([String? id]) async {
    return await mapsRepo.fechstoresByCategoreId(id: id!);
  }
}
