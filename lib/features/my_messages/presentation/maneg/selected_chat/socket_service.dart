// lib/core/services/socket_service.dart
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket socket;

  SocketService._internal();

  void connect(String userId) {
    socket = IO.io("http://192.168.0.80:3000/", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': userId},
    });

    socket.connect();

    socket.onConnect((_) {
      print('🔌 Socket connected');
    });

    socket.onDisconnect((_) {
      print('❌ Socket disconnected');
    });

    socket.onError((err) {
      print('⚠️ Socket error: $err');
    });
  }

  void onReceiveMessage(Function(dynamic) callback) {
    socket.on('receiveMessage', callback);
  }

  void sendMessage(String senderId, String receiverId, String text) {
    socket.emit('sendMessage', {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
    });
  }

  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}
