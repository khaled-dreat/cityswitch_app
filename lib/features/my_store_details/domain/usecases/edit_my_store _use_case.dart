import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../../add_store/data/models/add_store/m_add_store.dart';
import '../../../add_store/domain/entities/add_store.dart';
import '../repositories/edit_my_store_repo.dart';

class EditMyStoreUseCase extends UseCase<AddStoreModel, AddStoreEntite> {
  final EditMyStoreRepo editMyStoreRepo;

  EditMyStoreUseCase({required this.editMyStoreRepo});

  @override
  Future<Either<Failure, AddStoreModel>> call([AddStoreEntite? param]) async {
    return await editMyStoreRepo.editMyStore(addStoreModel: param!);
  }
}
