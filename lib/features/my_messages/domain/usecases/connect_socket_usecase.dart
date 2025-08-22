import '../../../../core/services/socket_service/socket_service.dart';

class ConnectSocketUseCase {
  final SocketService socketService;

  ConnectSocketUseCase(this.socketService);

  void call({required String token, required String userId}) {
    socketService.connect(token: token, userId: userId);
  }
}
