import 'package:cityswitch_app/core/utils/constant/app_failure.dart';
import 'package:cityswitch_app/features/my_messages/data/datasources/my_meesage_remote_data_source.dart';
import 'package:cityswitch_app/features/my_messages/data/models/get_all_my_meesages_model/get_all_my_meesages_model.dart';
import 'package:cityswitch_app/features/my_messages/domain/entities/my_meesage_entitie.dart';
import 'package:cityswitch_app/features/my_messages/domain/repositories/my_meesage_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/my_meesage/my_meesage_model..dart';

class MyMeesageRepoEmp extends MyMeesageRepo {
  final MyMeesageDataSourceImp myMeesageDataSourceImp;

  MyMeesageRepoEmp({required this.myMeesageDataSourceImp});

  @override
  Future<Either<Failure, MyMeesageModel>> sendMyMeesage({
    required MyMeesageEntitie myMeesageEntitie,
  }) async {
    MyMeesageModel meesage;
    try {
      meesage = await myMeesageDataSourceImp.sendMyMeesage(
        myMeesageEntitie: myMeesageEntitie,
      );

      return right(meesage);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetAllMyMeesagesModel>>> getAllMyMessages({
    required String userId,
  }) async {
    List<GetAllMyMeesagesModel> getAllMyMeesagesModel;
    try {
      getAllMyMeesagesModel = await myMeesageDataSourceImp.getAllMyMessages(
        userId: userId,
      );

      return right(getAllMyMeesagesModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
