import '../../../add_store/data/models/add_store/location.dart';

class StorsEntites {
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
  StorsEntites({
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
}
