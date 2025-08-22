part of 'chat_cubit_Tist.dart';

abstract class ChatStateTest extends Equatable {
  const ChatStateTest();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatStateTest {}

class ChatReceivedMessage extends ChatStateTest {
  final dynamic message;
  ChatReceivedMessage(this.message);

  @override
  List<Object> get props => [message];
}
