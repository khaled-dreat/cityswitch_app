import 'package:dartz/dartz.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/get_all_my_meesages_model/get_all_my_meesages_model.dart';
import '../../data/models/my_meesage/my_meesage_model..dart';
import '../entities/my_meesage_entitie.dart';

abstract class MyMeesageRepo {
  Future<Either<Failure, MyMeesageModel>> sendMyMeesage({
    required MyMeesageEntitie myMeesageEntitie,
  });

  Future<Either<Failure, List<GetAllMyMeesagesModel>>> getAllMyMessages({
    required String userId,
  });
}
