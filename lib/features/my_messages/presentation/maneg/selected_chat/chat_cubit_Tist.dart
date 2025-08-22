import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'socket_service.dart';

part 'chat_state_tist.dart';

class ChatCubitTist extends Cubit<ChatStateTest> {
  ChatCubitTist() : super(ChatInitial());

  void connectToSocket(String userId) {
    SocketService().connect(userId);

    SocketService().onReceiveMessage((data) {
      emit(ChatReceivedMessage(data));
    });
  }

  void sendMessage(String senderId, String receiverId, String text) {
    SocketService().sendMessage(senderId, receiverId, text);
  }

  void disconnect() {
    SocketService().dispose();
  }
}
