import '../../../domain/entities/store_categories_entites.dart';

class StoresCategoriesModel extends StoresCategoriesEntites {
  String? id;
  String? name;
  bool? active;
  DateTime? createdAt;
  int? v;

  StoresCategoriesModel({
    this.id,
    this.name,
    this.active,
    this.createdAt,
    this.v,
  });

  factory StoresCategoriesModel.fromJson(Map<String, dynamic> json) {
    return StoresCategoriesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      active: json['active'] as bool?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'active': active,
    'createdAt': createdAt?.toIso8601String(),
    '__v': v,
  };
}
