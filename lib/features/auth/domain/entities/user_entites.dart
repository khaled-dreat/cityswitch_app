import 'dart:developer';

import 'package:hive/hive.dart';
import '../../data/models/user_model/user_data.dart';
part 'entity.g.dart';

@HiveType(typeId: 0)
class UserEntites {
  @HiveField(0)
  UserData? data;
  @HiveField(1)
  String? token;

  UserEntites({this.data, this.token});

  factory UserEntites.fromJson(Map<String, dynamic> json) {
    return UserEntites(
      data:
          json['data'] == null
              ? null
              : UserData.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'token': token};
}
