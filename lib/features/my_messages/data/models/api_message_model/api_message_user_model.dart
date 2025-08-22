class ApiMessageUserModel {
  final String id;
  final String name;
  final String profileImg;
  final bool isOnline; // ✅ أضفه هنا

  ApiMessageUserModel({
    required this.id,
    required this.name,
    required this.profileImg,
    required this.isOnline, // ✅ لا تنسَ هذا
  });

  factory ApiMessageUserModel.fromJson(Map<String, dynamic> json) =>
      ApiMessageUserModel(
        id: json['_id'],
        name: json['name'],
        profileImg: json['profileImg'],
        isOnline: json['isOnline'] ?? false, // ✅ اجعل له قيمة افتراضية
      );
}
