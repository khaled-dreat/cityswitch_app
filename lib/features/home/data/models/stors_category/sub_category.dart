class SubCategoryModel {
  String? name;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubCategoryModel({this.name, this.id, this.createdAt, this.updatedAt});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        name: json['name'] as String?,
        id: json['_id'] as String?,
        createdAt:
            json['createdAt'] == null
                ? null
                : DateTime.parse(json['createdAt'] as String),
        updatedAt:
            json['updatedAt'] == null
                ? null
                : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
