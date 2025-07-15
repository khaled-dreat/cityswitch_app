import 'dart:developer';
import 'package:cityswitch_app/features/add_store/data/models/add_store/m_add_store.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:cityswitch_app/features/my_store_details/domain/entities/edit_my_store_entite.dart';
import '../../../../../../core/api/api_service.dart';
import '../../domain/entities/my_data_store.dart';
import '../models/edit_my_store_model/edit_my_store_model.dart';
import '../models/my_store_model/my_store_model.dart';
import '../models/search_addresses/search_addresses.dart';

abstract class EditMyStoreRemoteDataSource {
  Future<EditMyStoreModel> editMyStore({
    required EditMyStoreEntite editMyStoreEntite,
  });
  Future<MyStoreEntite> fechMyStore({required String id});

  Future<List<SearchAddressesModel>> getSearchAddresses({
    required String endPoint,
  });
}

class EditMyStoreRemoteDataSourceImp extends EditMyStoreRemoteDataSource {
  final ApiService apiService;

  EditMyStoreRemoteDataSourceImp({required this.apiService});

  @override
  Future<MyStoreEntite> fechMyStore({required String id}) async {
    try {
      var data = await apiService.getByUserID(
        endPoint: apiService.myStoreByID,
        id: id,
      );

      if (data is List && data.isNotEmpty) {
        var store = MyStoreModel.fromJson(data.first as Map<String, dynamic>);
        log(store.toMap().toString());
        return store;
      } else {
        throw Exception('No store data found or invalid format');
      }
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }

  @override
  Future<EditMyStoreModel> editMyStore({
    required EditMyStoreEntite editMyStoreEntite,
  }) async {
    try {
      var data = await apiService.updateStore(
        editMyStoreEntite: editMyStoreEntite,
      );

      if (data.statusMessage == "OK") {
        final store = EditMyStoreModel.fromJson(data.data);

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
  Future<List<SearchAddressesModel>> getSearchAddresses({
    required String endPoint,
  }) async {
    try {
      var data = await apiService.searchAddresses(endPoint: endPoint);

      final List<SearchAddressesModel> addresses =
          (data as List<dynamic>)
              .map(
                (item) =>
                    SearchAddressesModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return addresses;
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }
}
