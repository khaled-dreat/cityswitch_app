import 'dart:convert';
import 'dart:io';

import '../../data/models/add_store/location.dart';

class AddStoreEntite {
  String? name;
  String? description;
  String? category;
  String? subCategory;
  List<String>? tags;
  String? ownerId;
  LocationModel? location;
  List<File>? images;
  String? phoneNum;
  String? postCode;

  AddStoreEntite({
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.tags,
    this.ownerId,
    this.location,
    this.images,
  });

  void setName(String? value) => name = value!;
  void setPostCode(String? value) => postCode = value!;
  void setPhoneNum(String? value) => phoneNum = value!;
  void setDescription(String? value) => description = value;
  void setCategory(String? value) => category = value!;
  void setSubCategory(String? value) => subCategory = value;
  void setTags(List<String> value) => tags = value;
  void setOwnerId(String? value) => ownerId = value!;
  void setLocation(LocationModel value) => location = value;
  void setImages(List<File>? value) => images = value;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'Tags': tags,
      'ownerId': ownerId,
      'location': location,
      // الصور لا تتحول إلى Map هنا لأنها ملفات
    };
  }
}
