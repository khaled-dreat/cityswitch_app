import 'dart:developer';

import 'package:cityswitch_app/features/add_store/data/models/add_store/m_add_store.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';

import '../../../../../../core/api/api_service.dart';
import '../../../home/data/models/stores/stores.dart';
import '../../../home/domain/entities/stors_entites.dart';
import '../models/search_addresses/search_addresses.dart';

abstract class EditMyStoreRemoteDataSource {
  Future<AddStoreModel> editMyStore({required AddStoreEntite addStoreEntite});
  Future<StorsEntites> fechMyStore({required String id});

  Future<List<SearchAddressesModel>> getSearchAddresses({
    required String endPoint,
  });
}

class EditMyStoreRemoteDataSourceImp extends EditMyStoreRemoteDataSource {
  final ApiService apiService;

  EditMyStoreRemoteDataSourceImp({required this.apiService});

  @override
  Future<StorsEntites> fechMyStore({required String id}) async {
    try {
      var data = await apiService.getByUserID(
        endPoint: apiService.myStoreByID,
        id: id,
      );
      var store = StorsModel.fromJson(data);
      return store;
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }

  @override
  Future<AddStoreModel> editMyStore({
    required AddStoreEntite addStoreEntite,
  }) async {
    try {
      var data = await apiService.postAddStore(
        endPoint: apiService.addStore,
        addStoreEntite: addStoreEntite,
      );

      if (data.statusCode == 201) {
        final store = AddStoreModel.fromJson(data.data);

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
