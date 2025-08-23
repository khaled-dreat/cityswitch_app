import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../features/add_store/domain/entities/add_store.dart';
import '../../features/my_messages/domain/entities/my_conversation_entity/message_entity.dart';
import '../../features/my_messages/domain/entities/send_message_entity/send_message_entity.dart';
import '../../features/my_store_details/domain/entities/edit_my_store_entite.dart';

class ApiService {
  final Dio _dio;

  final baseUrl = "https://cityswitch-app-backend.onrender.com/";
  final searchAddressesUrl = "https://nominatim.openstreetmap.org/search?";
  final stores = "stores";
  final categories = "categories";
  final signup = "auth/signup";
  final login = "auth/login";
  final myStoreByID = "stores/by-owner/";
  final addStore = "stores/addStore";
  final editmyStore = "stores/update/by-owner/";
  final sendMyMeesage = "api/messages/send";
  final allMyMessages = "api/messages/conversations";

  ApiService(this._dio);

  Future<dynamic> getAllMyMessages({required String token}) async {
    final response = await _dio.get(
      '$baseUrl$allMyMessages', // => .../api/messages/conversations
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<dynamic> getChatbyReceiverId({
    required String token,
    required String receiverId,
  }) async {
    try {
      final url = '$baseUrl/api/messages/conversation/$receiverId';
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log(response.data.toString());
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMyMeesage({
    required SendMessageEntity sendMessageEntity,
    required String token,
  }) async {
    final response = await _dio.post(
      '$baseUrl$sendMyMeesage', // => .../api/messages/send
      data: sendMessageEntity.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<dynamic> put({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.put(
        baseUrl + endPoint,
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> searchStores({
    String? keyword,
    String? category,
    String? subCategory,
  }) async {
    try {
      // بناء الـ query parameters
      Map<String, dynamic> queryParams = {};
      if (keyword != null && keyword.isNotEmpty) {
        queryParams['keyword'] = keyword;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (subCategory != null && subCategory.isNotEmpty) {
        queryParams['subCategory'] = subCategory;
      }
      // كوّن الـ Uri للتصحيح
      final uri = Uri.parse(
        '${baseUrl}stores/search',
      ).replace(queryParameters: queryParams);

      log(name: "queryParams", "'Request URL: $uri'");
      // اطبع الـ URL النهائي

      var response = await _dio.get(
        '${baseUrl}stores/search?',
        queryParameters: queryParams,
      );

      return response.data;
    } catch (e) {
      print('Error during search request: $e');
      rethrow;
    }
  }

  Future<dynamic> postAddStore({
    required String endPoint,
    required AddStoreEntite addStoreEntite,
  }) async {
    final formData = FormData();

    // إضافة البيانات النصية
    formData.fields.addAll([
      MapEntry('name', addStoreEntite.name!),
      MapEntry('phoneNum', addStoreEntite.phoneNum!),
      if (addStoreEntite.description != null)
        MapEntry('description', addStoreEntite.description!),
      MapEntry('category', addStoreEntite.category!),
      if (addStoreEntite.subCategory != null)
        MapEntry('subCategory', addStoreEntite.subCategory!),
      MapEntry('ownerId', addStoreEntite.ownerId!),
      if (addStoreEntite.tags != null)
        MapEntry('Tags', jsonEncode(addStoreEntite.tags)),
      if (addStoreEntite.location != null) ...[
        MapEntry(
          'location',
          jsonEncode({
            'lat': addStoreEntite.location!.lat,
            'lng': addStoreEntite.location!.lng,
          }),
        ),
      ],
    ]);
    // إضافة الصور
    if (addStoreEntite.images != null) {
      for (var image in addStoreEntite.images!) {
        final fileName = image.path.split('/').last;
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(image.path, filename: fileName),
          ),
        );
      }
    }
    try {
      formData.fields.forEach((field) {
        log('${field.key}: ${field.value}');
      });
      var response = await _dio.post(
        baseUrl + endPoint,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        data: formData,
      );

      return response;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  Future<dynamic> get({required String endPoint}) async {
    try {
      var response = await _dio.get(baseUrl + endPoint);

      return response.data;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  Future<dynamic> searchAddresses({required String endPoint}) async {
    try {
      var response = await _dio.get(
        "https://nominatim.openstreetmap.org/search?q=$endPoint&countrycodes=de&format=json&addressdetails=1&",
      );

      return response.data;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  Future<dynamic> getByUserID({
    required String endPoint,
    required String id,
  }) async {
    try {
      var response = await _dio.get(baseUrl + endPoint + id);

      return response.data;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  Future<dynamic> updateStore({
    required EditMyStoreEntite editMyStoreEntite,
  }) async {
    try {
      final data = editMyStoreEntite.toMap();
      final response = await _dio.put(
        '${baseUrl}$editmyStore${editMyStoreEntite.ownerId}',
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      return response;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  Future<dynamic> post({required String endPoint, required Object data}) async {
    log(data.toString());
    try {
      var response = await _dio.post(
        baseUrl + endPoint,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: data,
      );

      return response.data;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  static void checkConnectitivy() async {
    await Connectivity().checkConnectivity();
  }
}
