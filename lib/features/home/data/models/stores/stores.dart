import '../../../../add_store/data/models/add_store/location.dart';
import '../../../domain/entities/stors_entites.dart';

class StorsModel extends StorsEntites {
  @override
  final List<String> tags;

  StorsModel({
    String? name,
    String? description,
    String? phoneNum,
    String? category,
    String? subCategory,
    List<String>? tags,
    List<String>? images,
    LocationModel? location,
    int? rating,
    bool? active,
    String? id,
    DateTime? createdAt,
    int? v,
  }) : tags = tags ?? [],
       super(
         name: name,
         description: description,
         phoneNum: phoneNum,
         category: category,
         subCategory: subCategory,
         tags: tags ?? [],
         images: images,
         location: location,
         rating: rating,
         active: active,
         id: id,
         createdAt: createdAt,
         v: v,
       );

  factory StorsModel.fromJson(Map<String, dynamic> json) => StorsModel(
    name: json['name'] as String?,
    description: json['description'] as String?,
    category: json['category'] as String?,
    subCategory: json['subCategory'] as String?,
    tags:
        ((json['Tags'] ?? json['tags']) as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
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
