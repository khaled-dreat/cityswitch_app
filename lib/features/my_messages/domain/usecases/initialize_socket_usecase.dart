import '../../../../core/services/socket_service/socket_service.dart';
import '../entities/my_conversation_entity/message_entity.dart';

class InitializeSocketListenerUseCase {
  final SocketService socketService;

  InitializeSocketListenerUseCase(this.socketService);

  void call(Function(MessageEntity) onMessageReceived) {
    socketService.onMessageReceived(onMessageReceived);
  }
}
