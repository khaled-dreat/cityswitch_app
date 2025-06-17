// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cityswitch_app/features/auth/data/models/add_user_failure/m_add_user_failure.dart';
import 'package:dio/dio.dart';

import '../../../features/auth/data/models/add_user_failure/m_error.dart';

abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  final ErrorModel? errorModel;

  ServerFailure({this.errorModel, required super.message});
  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(message: "no Internet");
      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'Opps There was an Error, Please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure(
        message: 'Your request was not found, please try later',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        message: 'There is a problem with server, please try later',
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      log(response.toString());
      return ServerFailure(message: response.toString());
    } else {
      return ServerFailure(message: 'There was an error , please try again');
    }
  }
}
