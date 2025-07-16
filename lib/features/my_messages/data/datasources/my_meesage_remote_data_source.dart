import 'dart:developer';
import 'package:cityswitch_app/features/my_messages/data/models/get_all_my_meesages_model/get_all_my_meesages_model.dart';
import 'package:cityswitch_app/features/my_messages/domain/entities/my_meesage_entitie.dart';
import '../../../../core/api/api_service.dart';
import '../models/my_meesage/my_meesage_model..dart';

abstract class MyMeesageRemoteDataSource {
  Future<MyMeesageModel> sendMyMeesage({
    required MyMeesageEntitie myMeesageEntitie,
  });
  Future<List<GetAllMyMeesagesModel>> getAllMyMessages({
    required String userId,
  });
}

class MyMeesageDataSourceImp extends MyMeesageRemoteDataSource {
  final ApiService apiService;

  MyMeesageDataSourceImp({required this.apiService});

  @override
  Future<MyMeesageModel> sendMyMeesage({
    required MyMeesageEntitie myMeesageEntitie,
  }) async {
    try {
      var data = await apiService.postMyMeesage(
        myMeesageEntitie: myMeesageEntitie,
      );

      if (data.statusCode == 201) {
        final store = MyMeesageModel.fromJson(data.data);

        return store;
      } else {
        throw Exception('Unexpected data format');
      }
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }

  @override
  Future<List<GetAllMyMeesagesModel>> getAllMyMessages({
    required String userId,
  }) async {
    try {
      var response = await apiService.getAllMyMessages(userId: userId);

      if (response.statusMessage == "OK") {
        final messagesList =
            (response.data as List)
                .map(
                  (item) => GetAllMyMeesagesModel.fromJson(
                    item as Map<String, dynamic>,
                  ),
                )
                .toList();

        return messagesList;
      } else {
        throw Exception('Unexpected data format');
      }
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }
}
