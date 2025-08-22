import 'dart:convert';

class MyMeesageModel {
  final String id;
  final String sender;
  final String receiver;
  final String text;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  MyMeesageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'text': text,
      'isRead': isRead,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory MyMeesageModel.fromMap(Map<String, dynamic> map) {
    return MyMeesageModel(
      id: map['id'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      text: map['text'] as String,
      isRead: map['isRead'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyMeesageModel.fromJson(String source) =>
      MyMeesageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
