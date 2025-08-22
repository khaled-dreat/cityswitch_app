// ignore_for_file: public_member_api_docs, sort_constructors_first
class OtherUserEntity {
  final String id;
  final String name;
  final String profileImg;
  final bool? isOnline; // ← أضف هذا المتغير

  OtherUserEntity({
    required this.id,
    required this.name,
    required this.profileImg,
    this.isOnline,
  });
}
