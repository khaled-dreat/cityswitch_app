part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class GetMyContactsLoading extends ChatState {}

class GetMyContactsSuccess extends ChatState {
  final List<GetAllMyMeesagesModel> getAllMyMeesagesModel;

  GetMyContactsSuccess({required this.getAllMyMeesagesModel});
}

class GetMyContactsFailurel extends ChatState {
  final String errMessage;

  GetMyContactsFailurel({required this.errMessage});
}

class ContactsLoaded extends ChatState {
  final List<Contact> contacts;

  ContactsLoaded(this.contacts);
}

class ChatOpened extends ChatState {
  final Contact contact;
  final List<Message> messages;

  ChatOpened(this.contact, this.messages);
}
