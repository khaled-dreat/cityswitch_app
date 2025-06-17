import 'dart:developer';
import 'package:cityswitch_app/features/auth/data/models/auth/auth_model.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/constant/app_failure.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_user_remote_data_source.dart';

class AuthRepoEmpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoEmpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, UserEntites>> registerationUser({
    required AuthModel authModel,
  }) async {
    UserEntites user;
    try {
      user = await authRemoteDataSource.registerationUser(authModel: authModel);

      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntites>> loginUser({
    required AuthModel authModel,
  }) async {
    UserEntites user;
    try {
      user = await authRemoteDataSource.loginUser(authModel: authModel);

      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
