import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  late IO.Socket socket;
  final String token;
  final String userId;

  SocketCubit({required this.token, required this.userId})
    : super(const SocketState(isConnected: false, messages: []));
  void connect() {
    socket = IO.io(
      'http://192.168.0.80:3000/',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'token': token, 'userId': userId})
          .build(),
    );

    socket.connect();

    // ✅ أضف هذه الأسطر مباشرة بعد connect()
    socket.onConnectError((data) {
      log('❌ Connect error: $data');
    });

    socket.onError((data) {
      log('❌ General error: $data');
    });

    socket.onConnect((_) {
      log('✅ Connected to socket');

      // 🔑 أرسل التوكن للمصادقة بعد الاتصال
      socket.emit('authenticate', token);

      // يمكنك ترك join أو تركه للسيرفر إن لزم
      socket.emit('join', 'user_$userId');

      emit(state.copyWith(isConnected: true));
    });

    socket.on('new_message', (data) {
      log('📩 رسالة جديدة: $data');
      final updatedMessages = List<Map<String, dynamic>>.from(state.messages)
        ..add(data);
      emit(state.copyWith(messages: updatedMessages));
    });

    socket.on('message_sent', (data) {
      log('✅ تم إرسال الرسالة: $data');
      final updatedMessages = List<Map<String, dynamic>>.from(state.messages)
        ..add(data);
      emit(state.copyWith(messages: updatedMessages));
    });

    socket.on('message_read', (data) {
      log('📖 تم قراءة الرسالة: $data');
    });

    socket.on('authenticated', (data) {
      log('✅ المصادقة ناجحة: $data');
    });

    socket.on('auth_error', (err) {
      log('❌ خطأ في المصادقة: $err');
    });

    socket.onDisconnect((_) {
      log('🔌 Disconnected from socket');
      emit(state.copyWith(isConnected: false));
    });
  }

  void sendMessage(String receiverId, String text) {
    if (socket.connected) {
      socket.emit('send_message', {'receiverId': receiverId, 'text': text});
    } else {
      log('🚫 لم يتم الاتصال بعد، لا يمكن الإرسال');
    }
  }

  void disposeSocket() {
    socket.disconnect();
  }
}
