import 'dart:developer';

import '../../../../core/api/api_service.dart';
import '../../domain/entities/stores_category_entites.dart';
import '../../domain/entities/stors_entites.dart';

import '../models/stores/stores.dart';
import '../models/stors_category/stors_category.dart';

abstract class StoresRemoteDataSource {
  Future<List<StorsCategoryEntites>> fechCategore();
  Future<List<StorsEntites>> fechSearchstores({
    String? keyword,
    String? category,
    String? subCategory,
  });
}

class StoresDataSourceImp extends StoresRemoteDataSource {
  final ApiService apiService;

  StoresDataSourceImp({required this.apiService});

  @override
  Future<List<StorsEntites>> fechSearchstores({
    String? keyword,
    String? category,
    String? subCategory,
  }) async {
    try {
      var data = await apiService.searchStores(
        category: category,
        keyword: keyword,
        subCategory: subCategory,
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

  @override
  Future<List<StorsCategoryEntites>> fechCategore() async {
    try {
      var data = await apiService.get(endPoint: apiService.categories);
      if (data is List) {
        return data.map((item) => StorsCategoryModel.fromJson(item)).toList();
      } else if (data is Map<String, dynamic> && data.containsKey('items')) {
        return (data['items'] as List)
            .map((item) => StorsCategoryModel.fromJson(item))
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
