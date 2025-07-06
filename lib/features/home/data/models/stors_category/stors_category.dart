import '../../../domain/entities/stores_category_entites.dart';
import 'sub_category.dart';

class StorsCategoryModel extends StorsCategoryEntites {
  String? id;
  String? name;
  List<SubCategoryModel>? subCategories;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  StorsCategoryModel({
    this.id,
    this.name,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory StorsCategoryModel.fromJson(Map<String, dynamic> json) =>
      StorsCategoryModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        subCategories:
            (json['subCategories'] as List<dynamic>?)
                ?.map(
                  (e) => SubCategoryModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
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
    '_id': id,
    'name': name,
    'subCategories': subCategories?.map((e) => e.toJson()).toList(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
