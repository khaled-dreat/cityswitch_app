import '../../../../core/services/socket_service/socket_service.dart';
import '../entities/my_conversation_entity/message_entity.dart';

class ListenToSocketMessagesUseCase {
  final SocketService socketService;

  ListenToSocketMessagesUseCase({required this.socketService});

  void call(Function(MessageEntity) onMessageReceived) {
    socketService.onMessageReceived(onMessageReceived);
  }
}
