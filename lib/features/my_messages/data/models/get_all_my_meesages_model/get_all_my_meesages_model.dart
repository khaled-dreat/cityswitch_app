import 'message_model.dart';

class GetAllMyMeesagesModel {
  List<String>? id;
  List<MessageModel>? messages;
  String? lastMessage;
  DateTime? lastMessageTime;
  int? unreadCount;
  String? contactId;
  String? contactName;
  String? contactImage;

  GetAllMyMeesagesModel({
    this.id,
    this.messages,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount,
    this.contactId,
    this.contactName,
    this.contactImage,
  });

  factory GetAllMyMeesagesModel.fromJson(Map<String, dynamic> json) {
    return GetAllMyMeesagesModel(
      id: (json['_id'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastMessage: json['lastMessage'] as String?,
      lastMessageTime:
          json['lastMessageTime'] == null
              ? null
              : DateTime.parse(json['lastMessageTime'] as String),
      unreadCount: json['unreadCount'] as int?,
      contactId: json['contactId'] as String?,
      contactName: json['contactName'] as String?,
      contactImage: json['contactImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'messages': messages?.map((e) => e.toJson()).toList(),
    'lastMessage': lastMessage,
    'lastMessageTime': lastMessageTime?.toIso8601String(),
    'unreadCount': unreadCount,
    'contactId': contactId,
    'contactName': contactName,
    'contactImage': contactImage,
  };
}
