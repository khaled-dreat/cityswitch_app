import '../../data/models/stores/location.dart';

class StorsEntites {
  Location? location;
  String? id;
  String? name;
  String? description;
  String? category;
  List<String>? images;
  int? rating;
  DateTime? createdAt;
  StorsEntites({
    this.location,
    this.id,
    this.name,
    this.description,
    this.category,
    this.images,
    this.rating,
    this.createdAt,
  });
}
