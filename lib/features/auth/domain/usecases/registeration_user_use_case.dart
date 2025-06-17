import 'package:cityswitch_app/features/auth/data/models/auth/auth_model.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../repositories/auth_repo.dart';

class RegisterationUserUseCase extends UseCase<UserEntites, AuthModel> {
  final AuthRepo authRepo;

  RegisterationUserUseCase({required this.authRepo});

  @override
  Future<Either<Failure, UserEntites>> call([AuthModel? param]) async {
    return await authRepo.registerationUser(authModel: param!);
  }
}
