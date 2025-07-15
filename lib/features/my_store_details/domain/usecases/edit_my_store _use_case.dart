import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';

import '../../data/models/edit_my_store_model/edit_my_store_model.dart';

import '../entities/edit_my_store_entite.dart';
import '../repositories/edit_my_store_repo.dart';

class EditMyStoreUseCase extends UseCase<EditMyStoreModel, EditMyStoreEntite> {
  final EditMyStoreRepo editMyStoreRepo;

  EditMyStoreUseCase({required this.editMyStoreRepo});

  @override
  Future<Either<Failure, EditMyStoreModel>> call([
    EditMyStoreEntite? param,
  ]) async {
    return await editMyStoreRepo.editMyStore(editMyStoreEntite: param!);
  }
}
