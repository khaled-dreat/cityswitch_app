part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MyConversationEntity> messages;

  MessagesLoaded({required this.messages});
}

class MessagesUnread extends MessagesState {
  final List<MessageEntity> messages;

  MessagesUnread({required this.messages});
}

class MessagesError extends MessagesState {
  final String error;

  MessagesError({required this.error});
}
