import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  final baseUrl = "http://192.168.0.80:3000/";
  final stores = "stores";
  final categories = "categories";
  final signup = "auth/signup";
  final login = "auth/login";
  final storesByCategoreId = "stores/category/";

  ApiService(this._dio);

  Future<dynamic> get({required String endPoint}) async {
    try {
      var response = await _dio.get(baseUrl + endPoint);

      return response.data;
    } catch (e) {
      //   log('Error during GET request: $e');
      rethrow;
    }
  }

  Future<dynamic> getByID({
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
