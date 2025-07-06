import 'package:cityswitch_app/features/home/domain/repositories/maps_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../../home/domain/entities/stors_entites.dart';
import '../repositories/edit_my_store_repo.dart';

class StoresByUserIdUseCase extends UseCase<StorsEntites, String> {
  final EditMyStoreRepo editMyStoreRepo;

  StoresByUserIdUseCase({required this.editMyStoreRepo});

  @override
  Future<Either<Failure, StorsEntites>> call([String? id]) async {
    return await editMyStoreRepo.fechMyStore(id: id!);
  }
}
