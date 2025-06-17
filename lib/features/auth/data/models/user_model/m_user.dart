// ignore_for_file: overridden_fields

import '../../../domain/entities/user_entites.dart';
import 'user_data.dart';

class UserModel extends UserEntites {
  @override
  UserData? data;
  String? token;

  UserModel({this.data, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data:
        json['data'] == null
            ? null
            : UserData.fromJson(json['data'] as Map<String, dynamic>),
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'token': token};
}
