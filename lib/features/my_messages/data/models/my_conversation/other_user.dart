class OtherUser {
  String? id;
  String? name;
  String? profileImg;

  OtherUser({this.id, this.name, this.profileImg});

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    profileImg: json['profileImg'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'profileImg': profileImg,
  };
}
