import '../../../../core/services/socket_service/socket_service.dart';

class DisconnectSocketUsecase {
  final SocketService socketService;

  DisconnectSocketUsecase(this.socketService);

  void call() {
    socketService.dispose();
  }
}
