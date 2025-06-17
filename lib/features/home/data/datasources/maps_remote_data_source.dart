import 'dart:developer';

import '../../../../core/api/api_service.dart';
import '../../domain/entities/maps_entites.dart';
import '../../domain/entities/store_categories_entites.dart';
import '../models/stores/stores.dart';
import '../models/stores_categories/m_stores_categories.dart';

abstract class StoresRemoteDataSource {
  Future<List<StoresCategoriesEntites>> fechCategore();
  Future<List<StorsEntites>> fechstoresByCategoreId({required String id});
}

class StoresDataSourceImp extends StoresRemoteDataSource {
  final ApiService apiService;

  StoresDataSourceImp({required this.apiService});
  @override
  Future<List<StoresCategoriesEntites>> fechCategore() async {
    try {
      var data = await apiService.get(endPoint: apiService.categories);
      if (data is List) {
        return data
            .map((item) => StoresCategoriesModel.fromJson(item))
            .toList();
      } else if (data is Map<String, dynamic> && data.containsKey('items')) {
        return (data['items'] as List)
            .map((item) => StoresCategoriesModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Unexpected data format');
      }
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }

  @override
  Future<List<StorsEntites>> fechstoresByCategoreId({
    required String id,
  }) async {
    try {
      var data = await apiService.getByID(
        endPoint: apiService.storesByCategoreId,
        id: id,
      );
      if (data is List) {
        return data.map((item) => StorsModel.fromJson(item)).toList();
      } else if (data is Map<String, dynamic> && data.containsKey('items')) {
        return (data['items'] as List)
            .map((item) => StorsModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Unexpected data format');
      }
    } catch (e) {
      log('Error in fechStors: $e');
      rethrow;
    }
  }
}
