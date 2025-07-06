import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:cityswitch_app/features/auth/data/models/auth/auth_model.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/add_store/m_add_store.dart';
import '../repositories/add_store_repo.dart';

class AddStoreUseCase extends UseCase<AddStoreModel, AddStoreEntite> {
  final AddStoreRepo addStoreRepo;

  AddStoreUseCase({required this.addStoreRepo});

  @override
  Future<Either<Failure, AddStoreModel>> call([AddStoreEntite? param]) async {
    return await addStoreRepo.addStore(addStoreModel: param!);
  }
}
