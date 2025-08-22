import '../../../../core/services/socket_service/socket_service.dart';
import '../../domain/entities/api_message_entity/api_message_entity.dart';
import '../../domain/entities/my_conversation_entity/conversation_entity.dart';
import '../../domain/entities/my_conversation_entity/message_entity.dart';
import '../../domain/entities/send_message_entity/send_message_entity.dart';
import '../../domain/repositories/my_meesage_repo.dart';
import '../datasources/my_meesage_remote_data_source.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagesRemoteDataSource remoteDataSource;
  final SocketService socketService;

  MessageRepositoryImpl({
    required this.remoteDataSource,
    required this.socketService,
  });

  @override
  Future<List<MyConversationEntity>> getMessagesWithUser({
    required String token,
  }) async {
    return await remoteDataSource.fetchConversation(token: token);
  }

  @override
  Future<ApiMessageEntity> sendMessage({
    required SendMessageEntity message,
    required String token,
  }) async {
    return await remoteDataSource.sendMessage(message: message, token: token);
  }

  @override
  void sendMessageSocket({required String receiverId, required String text}) {
    socketService.sendMessage(receiverId: receiverId, text: text);
  }

  @override
  void onMessageReceived(void Function(MessageEntity) callback) {
    socketService.onMessageReceived(callback);
  }

  @override
  void connectSocket({required String token, required String userId}) {
    socketService.connect(token: token, userId: userId);
  }

  @override
  void disconnectSocket() {
    socketService.dispose();
  }

  @override
  Future<List<MessageEntity>> getUnreadMessages() async {
    return await remoteDataSource.getUnreadMessages();
  }
}
