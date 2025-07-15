import 'dart:convert';
import 'dart:io';

import '../../data/models/my_store_model/location.dart';

class MyStoreEntite {
  String? name;
  String? description;
  String? category;
  String? subCategory;
  List<String>? tags;
  String? ownerId;
  LocationModel? location;
  List<String>? images;
  String? phoneNum;
  String? postCode;

  MyStoreEntite({
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.tags,
    this.ownerId,
    this.location,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'Tags': tags,
      'phoneNum': phoneNum,
      'ownerId': ownerId,
      'location': location,
      // الصور لا تتحول إلى Map هنا لأنها ملفات
    };
  }
}
