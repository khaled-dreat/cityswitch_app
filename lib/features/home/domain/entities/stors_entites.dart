import '../../../add_store/data/models/add_store/location.dart';

class StorsEntites {
  final String? name;
  final String? description;
  final String? category;
  final String? phoneNum;
  final String? subCategory;
  final List<String> tags;
  final List<String>? images;
  final LocationModel? location;
  final int? rating;
  final bool? active;
  final String? id;
  final DateTime? createdAt;
  final int? v;

  StorsEntites({
    this.name,
    this.description,
    this.category,
    this.phoneNum,
    this.subCategory,
    List<String>? tags,
    this.images,
    this.location,
    this.rating,
    this.active,
    this.id,
    this.createdAt,
    this.v,
  }) : tags = tags ?? [];
}
