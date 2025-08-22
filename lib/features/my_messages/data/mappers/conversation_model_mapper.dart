import 'package:cityswitch_app/features/my_messages/data/models/my_conversation/my_conversation.dart';

import '../../domain/entities/my_conversation_entity/conversation_entity.dart';
import '../../domain/entities/my_conversation_entity/last_message_entity.dart';
import '../../domain/entities/my_conversation_entity/other_user_entity.dart';
import '../../domain/entities/my_conversation_entity/message_entity.dart';

import '../models/my_conversation/datum.dart';
import '../models/my_conversation/last_message.dart';
import '../models/my_conversation/other_user.dart';

extension DatumToEntity on Datum {
  MyConversationEntity toEntity() => MyConversationEntity(
    id: id ?? '',
    lastMessage: lastMessage?.toLastMessageEntity() ?? _emptyLastMessage(),
    unreadCount: unreadCount ?? 0,
    otherUser: otherUser?.toEntity() ?? _emptyOtherUser(),
    lastMessages:
        lastMessages?.map((msg) => msg.toMessageEntity()).toList() ?? [],
  );

  LastMessageEntity _emptyLastMessage() => LastMessageEntity(
    id: '',
    sender: '',
    receiver: '',
    text: '',
    isRead: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  OtherUserEntity _emptyOtherUser() =>
      OtherUserEntity(id: '', name: '', profileImg: '');
}

extension LastMessageToLastMessageEntity on LastMessage {
  LastMessageEntity toLastMessageEntity() => LastMessageEntity(
    id: id ?? '',
    sender: sender ?? '',
    receiver: receiver ?? '',
    text: text ?? '',
    isRead: isRead ?? false,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );
}

extension MyConversationModelMapper on MyConversationModel {
  List<MyConversationEntity> toEntityList() {
    return data?.map((datum) => datum.toEntity()).toList() ?? [];
  }
}

extension LastMessageToMessageEntity on LastMessage {
  MessageEntity toMessageEntity() => MessageEntity(
    id: id ?? '',
    sender: sender ?? '',
    receiver: receiver ?? '',
    text: text ?? '',
    isRead: isRead ?? false,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );
}

extension OtherUserToEntity on OtherUser {
  OtherUserEntity toEntity() => OtherUserEntity(
    id: id ?? '',
    name: name ?? '',
    profileImg: profileImg ?? '',
  );
}
