import '../../../domain/entities/maps_entites.dart';
import 'location.dart';

class StorsModel extends StorsEntites {
  Location? location;
  String? id;
  String? name;
  String? description;
  String? category;
  List<String>? images;
  int? rating;
  DateTime? createdAt;

  StorsModel({
    this.location,
    this.id,
    this.name,
    this.description,
    this.category,
    this.images,
    this.rating,
    this.createdAt,
  });

  factory StorsModel.fromJson(Map<String, dynamic> json) => StorsModel(
    location:
        json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
    id: json['_id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    category: json['category'] as String?,
    images:
        json['images'] != null
            ? List<String>.from(json['images'] as List)
            : null,
    rating: json['rating'] as int?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    '_id': id,
    'name': name,
    'description': description,
    'category': category,
    'images': images,
    'rating': rating,
    'createdAt': createdAt?.toIso8601String(),
  };
}
