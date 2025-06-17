import 'package:hive/hive.dart';

part '../../../domain/entities/user_data.g.dart'; // هنا اسم الملف الذي سيحتوي على الـ Adapter

@HiveType(typeId: 1)
class UserData {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? password;

  @HiveField(3)
  String? role;

  @HiveField(4)
  bool? active;

  @HiveField(5)
  List<dynamic>? wishlist;

  @HiveField(6)
  String? id;

  @HiveField(7)
  List<dynamic>? addresses;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  @HiveField(10)
  int? v;

  UserData({
    this.name,
    this.email,
    this.password,
    this.role,
    this.active,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  // JSON methods (API use only)
  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json['name'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    role: json['role'] as String?,
    active: json['active'] as bool?,
    wishlist: json['wishlist'] as List<dynamic>?,
    id: json['_id'] as String?,
    addresses: json['addresses'] as List<dynamic>?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    updatedAt:
        json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'role': role,
    'active': active,
    'wishlist': wishlist,
    '_id': id,
    'addresses': addresses,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
