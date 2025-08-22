import 'dart:developer';

import '../../../../core/services/socket_service/socket_service.dart';

class ListenToMessagesUseCase {
  final SocketService socketService;

  ListenToMessagesUseCase(this.socketService);

  void call(OnMessageReceived onMessage) {
    socketService.onMessageReceived(onMessage);
  }

  void listenToReadStatus(
    void Function(String messageId, String readBy) onRead,
  ) {
    log('📥 message_read event received:  <onRead.messageId> b readBy');

    socketService.listenToReadStatus(onRead);
  }
}
