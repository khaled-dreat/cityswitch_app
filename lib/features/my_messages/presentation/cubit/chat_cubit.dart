import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/my_messages.dart';

part './chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    loadContacts();
  }

  List<Contact> _contacts = [];
  final Map<String, List<Message>> _conversations = {
    'Ahmed Mohamed': [
      Message(text: 'Hi Ahmed', isMe: true, time: '10:25'),
      Message(text: 'Hi, how are you?', isMe: false, time: '10:30'),
    ],
    'Fatima Ali': [
      Message(text: 'Do you need any help?', isMe: true, time: '09:10'),
      Message(text: 'Thank you for the help', isMe: false, time: '09:15'),
    ],
  };

  void loadContacts() {
    _contacts = [
      Contact(
        name: 'Ahmed Mohamed',
        lastMessage: 'Hi, how are you?',
        time: '10:30',
        avatar: '👨‍💼',
        isOnline: true,
        unreadCount: 2,
      ),
      Contact(
        name: 'Fatima Ali',
        lastMessage: 'Thank you for the help',
        time: '09:15',
        avatar: '👩‍🦰',
        isOnline: true,
      ),
      // أضف الباقي حسب حاجتك
    ];
    emit(ContactsLoaded(_contacts));
  }

  void openChat(Contact contact) {
    final messages = _conversations[contact.name] ?? [];
    emit(ChatOpened(contact, messages));
  }

  void backToContacts() {
    emit(ContactsLoaded(_contacts));
  }
}
