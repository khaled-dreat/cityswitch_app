import 'dart:developer';

import 'package:cityswitch_app/features/auth/data/models/auth/auth_model.dart';

import '../../../../core/api/api_service.dart';
import '../../domain/entities/user_entites.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntites> registerationUser({required AuthModel authModel});
  Future<UserEntites> loginUser({required AuthModel authModel});
}

class AuthDataSourceImp extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthDataSourceImp({required this.apiService});

  @override
  Future<UserEntites> registerationUser({required AuthModel authModel}) async {
    try {
      var data = await apiService.post(
        endPoint: apiService.signup,
        data: authModel.toJson(),
      );
      log(name: "data", data.toString());
      final user = UserEntites.fromJson(data);

      return user;
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }

  @override
  Future<UserEntites> loginUser({required AuthModel authModel}) async {
    try {
      var data = await apiService.post(
        endPoint: apiService.login,
        data: authModel.toJson(),
      );
      final user = UserEntites.fromJson(data);

      return user;
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }
}
