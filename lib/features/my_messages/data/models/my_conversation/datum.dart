import 'last_message.dart';
import 'other_user.dart';

class Datum {
  String? id;
  LastMessage? lastMessage;
  int? unreadCount;
  OtherUser? otherUser;
  List<LastMessage>? lastMessages;

  Datum({
    this.id,
    this.lastMessage,
    this.unreadCount,
    this.otherUser,
    this.lastMessages,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['_id'] as String?,
    lastMessage:
        json['lastMessage'] == null
            ? null
            : LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
    unreadCount: json['unreadCount'] as int?,
    otherUser:
        json['otherUser'] == null
            ? null
            : OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>),
    lastMessages:
        (json['lastMessages'] as List<dynamic>?)
            ?.map((e) => LastMessage.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'lastMessage': lastMessage?.toJson(),
    'unreadCount': unreadCount,
    'otherUser': otherUser?.toJson(),
    'lastMessages': lastMessages?.map((e) => e.toJson()).toList(),
  };
}
