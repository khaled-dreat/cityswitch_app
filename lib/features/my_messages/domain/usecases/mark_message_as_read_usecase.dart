import '../../../../core/services/socket_service/socket_service.dart';

class MarkMessageAsReadUsecase {
  final SocketService socketService;

  MarkMessageAsReadUsecase({required this.socketService});

  void call({required String messageId}) {
    socketService.markMessageAsRead(messageId);
  }
}
