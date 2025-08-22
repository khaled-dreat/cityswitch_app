import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_entity.dart';

import '../entities/my_conversation_entity/conversation_entity.dart';
import '../entities/my_conversation_entity/message_entity.dart';
import '../entities/send_message_entity/send_message_entity.dart';

abstract class MessageRepository {
  Future<List<MyConversationEntity>> getMessagesWithUser({
    required String token,
  });
  Future<ApiMessageEntity> sendMessage({
    required SendMessageEntity message,
    required String token,
  });
  void sendMessageSocket({required String receiverId, required String text});
  void onMessageReceived(void Function(MessageEntity) callback);
  void connectSocket({required String token, required String userId});
  void disconnectSocket();
  Future<List<MessageEntity>> getUnreadMessages();
}
