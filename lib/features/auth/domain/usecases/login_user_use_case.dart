import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/auth/auth_model.dart';
import '../entities/user_entites.dart';
import '../repositories/auth_repo.dart';

class LoginUserUseCase extends UseCase<UserEntites, AuthModel> {
  final AuthRepo authRepo;

  LoginUserUseCase({required this.authRepo});

  @override
  Future<Either<Failure, UserEntites>> call([AuthModel? param]) async {
    return await authRepo.loginUser(authModel: param!);
  }
}
