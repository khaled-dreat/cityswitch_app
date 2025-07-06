part of './chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ContactsLoaded extends ChatState {
  final List<Contact> contacts;

  ContactsLoaded(this.contacts);
}

class ChatOpened extends ChatState {
  final Contact contact;
  final List<Message> messages;

  ChatOpened(this.contact, this.messages);
}
