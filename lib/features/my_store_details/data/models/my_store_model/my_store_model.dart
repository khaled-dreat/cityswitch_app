import '../../../domain/entities/my_data_store.dart';
import 'location.dart';

class MyStoreModel extends MyStoreEntite {
  LocationModel? location;
  String? id;
  String? name;
  String? description;
  String? category;
  List<String>? tags;
  String? ownerId;
  List<String>? images;
  int? rating;
  bool? active;
  DateTime? createdAt;
  int? v;
  String? subCategory;
  String? phoneNum;

  MyStoreModel({
    this.location,
    this.id,
    this.name,
    this.description,
    this.category,
    this.tags,
    this.ownerId,
    this.images,
    this.rating,
    this.active,
    this.createdAt,
    this.v,
    this.subCategory,
    this.phoneNum,
  });

  factory MyStoreModel.fromJson(Map<String, dynamic> json) => MyStoreModel(
    location:
        json['location'] == null
            ? null
            : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    id: json['_id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    category: json['category'] as String?,
    tags: json['Tags'] != null ? List<String>.from(json['Tags']) : null,

    images: json['images'] != null ? List<String>.from(json['images']) : null,

    ownerId: json['ownerId'] as String?,
    rating: json['rating'] as int?,
    active: json['active'] as bool?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    v: json['__v'] as int?,
    subCategory: json['subCategory'] as String?,
    phoneNum: json['phoneNum'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    '_id': id,
    'name': name,
    'description': description,
    'category': category,
    'Tags': tags,
    'ownerId': ownerId,
    'images': images,
    'rating': rating,
    'active': active,
    'createdAt': createdAt?.toIso8601String(),
    '__v': v,
    'subCategory': subCategory,
    'phoneNum': phoneNum,
  };
}
