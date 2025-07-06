import 'location.dart';

class SearchStoreModel {
  LocationModel? location;
  String? id;
  String? name;
  String? description;
  String? category;
  String? subCategory;
  List<dynamic>? tags;
  String? ownerId;
  List<dynamic>? images;
  int? rating;
  bool? active;
  DateTime? createdAt;
  int? v;

  SearchStoreModel({
    this.location,
    this.id,
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.tags,
    this.ownerId,
    this.images,
    this.rating,
    this.active,
    this.createdAt,
    this.v,
  });

  factory SearchStoreModel.fromJson(Map<String, dynamic> json) =>
      SearchStoreModel(
        location:
            json['location'] == null
                ? null
                : LocationModel.fromJson(
                  json['location'] as Map<String, dynamic>,
                ),
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        category: json['category'] as String?,
        subCategory: json['subCategory'] as String?,
        tags: json['Tags'] as List<dynamic>?,
        ownerId: json['ownerId'] as String?,
        images: json['images'] as List<dynamic>?,
        rating: json['rating'] as int?,
        active: json['active'] as bool?,
        createdAt:
            json['createdAt'] == null
                ? null
                : DateTime.parse(json['createdAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    '_id': id,
    'name': name,
    'description': description,
    'category': category,
    'subCategory': subCategory,
    'Tags': tags,
    'ownerId': ownerId,
    'images': images,
    'rating': rating,
    'active': active,
    'createdAt': createdAt?.toIso8601String(),
    '__v': v,
  };
}
