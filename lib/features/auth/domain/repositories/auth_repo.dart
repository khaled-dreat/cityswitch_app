import 'package:cityswitch_app/features/auth/data/models/auth/auth_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../entities/user_entites.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntites>> registerationUser({
    required AuthModel authModel,
  });
  Future<Either<Failure, UserEntites>> loginUser({
    required AuthModel authModel,
  });
}
