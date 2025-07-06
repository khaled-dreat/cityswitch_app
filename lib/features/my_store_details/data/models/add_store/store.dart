import 'location.dart';

class Store {
  String? name;
  String? description;
  String? category;
  String? subCategory;
  List<String>? tags;
  List<String>? images;
  LocationModel? location;
  int? rating;
  bool? active;
  String? id;
  DateTime? createdAt;
  int? v;

  Store({
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.tags,
    this.images,
    this.location,
    this.rating,
    this.active,
    this.id,
    this.createdAt,
    this.v,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    name: json['name'] as String?,
    description: json['description'] as String?,
    category: json['category'] as String?,
    subCategory: json['subCategory'] as String?,
    tags: (json['Tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList(),

    location:
        json['location'] == null
            ? null
            : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    rating: json['rating'] as int?,
    active: json['active'] as bool?,
    id: json['_id'] as String?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'category': category,
    'subCategory': subCategory,
    'Tags': tags,
    'images': images,
    'location': location?.toJson(),
    'rating': rating,
    'active': active,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    '__v': v,
  };
}
