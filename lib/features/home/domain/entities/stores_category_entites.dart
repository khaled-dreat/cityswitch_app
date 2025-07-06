import '../../data/models/stors_category/sub_category.dart';

class StorsCategoryEntites {
  String? id;
  String? name;
  List<SubCategoryModel>? subCategories;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  StorsCategoryEntites({
    this.id,
    this.name,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
