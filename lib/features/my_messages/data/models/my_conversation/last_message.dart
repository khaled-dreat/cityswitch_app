class LastMessage {
  String? id;
  String? sender;
  String? receiver;
  String? text;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LastMessage({
    this.id,
    this.sender,
    this.receiver,
    this.text,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json['_id'] as String?,
    sender: json['sender'] as String?,
    receiver: json['receiver'] as String?,
    text: json['text'] as String?,
    isRead: json['isRead'] as bool?,
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

  Map<String, dynamic> toJson() => {
    '_id': id,
    'sender': sender,
    'receiver': receiver,
    'text': text,
    'isRead': isRead,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
