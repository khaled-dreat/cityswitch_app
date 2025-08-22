import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../features/my_messages/domain/entities/my_conversation_entity/message_entity.dart';

typedef OnMessageReceived = void Function(MessageEntity message);

class SocketService {
  late IO.Socket _socket;

  OnMessageReceived? _onMessageReceived;

  SocketService();

  void connect({required String token, required String userId}) {
    _socket = IO.io(
      'http://192.168.0.80:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({
            'Authorization': 'Bearer $token',
            'user-id': userId, // يمكنك تغييره إذا لم يكن الخادم يستعمله
          })
          .build(),
    );

    _socket.connect();

    // إرسال حدث المصادقة بعد الاتصال:
    _socket.onConnect((_) {
      _socket.emit('authenticate', token);
    });
    _socket.on('authenticated', (data) {
      log('🟢 Authenticated with server');
    });

    _socket.on('auth_error', (data) {
      log('🔴 Authentication Error: $data');
    });
    _socket.on('new_message', (data) {
      log('📥 New message: $data'); // ✅ هذه موجودة
      if (_onMessageReceived != null) {
        try {
          if (data is String) {
            _onMessageReceived!(MessageEntity.fromJson(data));
          } else if (data is Map<String, dynamic>) {
            // ✅ أضف هذه الطباعة
            log('🧪 Trying to parse MessageEntity from: $data');
            _onMessageReceived!(MessageEntity.fromMap(data));
          } else {
            log('❗ Unknown data format: $data');
          }
        } catch (e, stack) {
          log('❌ Error parsing message: $e\n$stack');
        }
      }
    });

    _socket.onDisconnect((_) {
      log('🔌 Socket Disconnected');
    });

    _socket.onError((data) {
      log('❌ Socket error: $data');
    });
  }

  // إرسال رسالة
  void sendMessage({required String receiverId, required String text}) {
    _socket.emit('send_message', {'receiverId': receiverId, 'text': text});
    log('📤 Message sent to $receiverId: $text');
  }

  void markMessageAsRead(String messageId) {
    _socket.emit('mark_read', {'messageId': messageId});
  }

  void listenToReadStatus(
    void Function(String messageId, String readBy) onRead,
  ) {
    log('📥 message_read event received:  <onRead.messageId> b readBy');

    _socket.on('message_read', (data) {
      final messageId = data['messageId'];
      final readBy = data['readBy'];
      log('📩 Received message_read for $messageId by $readBy');
      onRead(messageId, readBy);
    });
  }

  // تعيين دالة استقبال الرسائل

  void onMessageReceived(OnMessageReceived callback) {
    _onMessageReceived = callback;
  }

  void listenToUserStatus({
    required void Function(String userId) onUserOnline,
    required void Function(String userId) onUserOffline,
  }) {
    _socket.on('user_online', (data) {
      onUserOnline(data['userId']);
    });
    _socket.on('user_offline', (data) {
      onUserOffline(data['userId']);
    });
  }

  void dispose() {
    _socket.dispose();
  }
}
