class MyMeesageModel {
  String? sender;
  String? receiver;
  String? text;
  bool? isRead;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyMeesageModel({
    this.sender,
    this.receiver,
    this.text,
    this.isRead,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyMeesageModel.fromJson(Map<String, dynamic> json) {
    return MyMeesageModel(
      sender: json['sender'] as String?,
      receiver: json['receiver'] as String?,
      text: json['text'] as String?,
      isRead: json['isRead'] as bool?,
      id: json['_id'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'receiver': receiver,
    'text': text,
    'isRead': isRead,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
