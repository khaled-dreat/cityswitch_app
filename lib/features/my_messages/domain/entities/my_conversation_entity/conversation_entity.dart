import 'last_message_entity.dart';
import 'message_entity.dart';
import 'other_user_entity.dart';

class MyConversationEntity {
  final String? id;
  final LastMessageEntity? lastMessage;
  final int? unreadCount;
  final OtherUserEntity? otherUser;
  final List<MessageEntity>? lastMessages;

  MyConversationEntity({
    this.lastMessages,
    this.id,
    this.lastMessage,
    this.unreadCount,
    this.otherUser,
  });

  MyConversationEntity copyWith({
    String? id,
    LastMessageEntity? lastMessage,
    int? unreadCount,
    OtherUserEntity? otherUser,
    List<MessageEntity>? lastMessages,
  }) {
    return MyConversationEntity(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      otherUser: otherUser ?? this.otherUser,
      lastMessages: lastMessages ?? this.lastMessages,
    );
  }
}
