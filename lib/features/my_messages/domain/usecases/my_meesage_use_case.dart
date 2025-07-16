import 'package:cityswitch_app/features/my_messages/domain/entities/my_meesage_entitie.dart';
import 'package:cityswitch_app/features/my_messages/domain/repositories/my_meesage_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/my_meesage/my_meesage_model..dart';

class MyMeesageUseCase extends UseCase<MyMeesageModel, MyMeesageEntitie> {
  final MyMeesageRepo myMeesageRepo;

  MyMeesageUseCase({required this.myMeesageRepo});

  @override
  Future<Either<Failure, MyMeesageModel>> call([
    MyMeesageEntitie? param,
  ]) async {
    return await myMeesageRepo.sendMyMeesage(myMeesageEntitie: param!);
  }
}
