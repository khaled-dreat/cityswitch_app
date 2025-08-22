// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:cityswitch_app/core/utils/routes/app_routes.dart';
import 'package:cityswitch_app/features/my_messages/presentation/maneg/selected_chat/selected_chat_cubit.dart';
import 'package:cityswitch_app/features/my_messages/presentation/widgets/build_message_bubble.dart';

import '../../../../core/user_session/user_session_app.dart';
import '../../domain/entities/my_conversation_entity/conversation_entity.dart';
import '../maneg/chat_cubit/messages_cubit.dart';

class Contact {
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isOnline;
  final int unreadCount;

  Contact({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    this.isOnline = false,
    this.unreadCount = 0,
  });
}

class Message {
  final String text;
  final bool isMe;
  final String time;

  Message({required this.text, required this.isMe, required this.time});
}

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _currentIndex = 0;
  String? selectedContact;
  final List<Contact> contacts = [
    Contact(
      name: 'khaled',
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
    Contact(
      name: 'Mahmoud Hassan',
      lastMessage: 'I will contact you later',
      time: 'Yesterday',
      avatar: '👨‍🎓',
      unreadCount: 1,
    ),
    Contact(
      name: 'Sarah Ahmed',
      lastMessage: 'Great! See you tomorrow',
      time: 'Yesterday',
      avatar: '👩‍💻',
      isOnline: true,
    ),
    Contact(
      name: 'Yousef Ibrahim',
      lastMessage: 'Files have been sent',
      time: 'Sunday',
      avatar: '👨‍🔬',
    ),
  ];

  final Map<String, List<Message>> conversations = {
    'khaled': [
      Message(text: 'Hi Ahmed', isMe: true, time: '10:25'),
      Message(text: 'Hi, how are you?', isMe: false, time: '10:30'),
      Message(
        text: 'I am good, thanks God. And you?',
        isMe: true,
        time: '10:31',
      ),
    ],
    'Fatima Ali': [
      Message(text: 'Do you need any help?', isMe: true, time: '09:10'),
      Message(text: 'Thank you for the help', isMe: false, time: '09:15'),
    ],
  };
  @override
  void initState() {
    context.read<MessagesCubit>().connectSocket(
      userId: AppUserSession().userId!,
      token: AppUserSession().token!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _buildContactsList(),
    );
  }

  Widget _buildContactsList() {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.edit, color: Colors.blue[600], size: 20),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search conversations...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
          ),

          // Contacts List
          BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoaded) {
                final contacts = state.messages;

                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts.elementAt(index);
                      return _buildContactItem(contact);
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(MyConversationEntity contact) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        onTap: () async {
          context.read<SelectedChatCubit>().emit(contact);
          AppRoutes.go(context, ChatView.nameRoute);
        },
        leading: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.network(
                "http://192.168.0.80:3000/${contact.otherUser!.profileImg}",
                fit: BoxFit.fill,
                errorBuilder:
                    (context, error, stackTrace) => Icon(Icons.person),
              ),
            ),
            if (false)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          contact.otherUser!.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            contact.lastMessage!.text,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatCustomDate(contact.lastMessage!.createdAt.toString()),
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            if (contact.unreadCount! > 0)
              Container(
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${contact.unreadCount}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

String formatCustomDate(String dateStr) {
  final dateTime = DateTime.parse(dateStr).toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(Duration(days: 1));
  final target = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (target == today) {
    // اليوم
    return DateFormat('HH:mm').format(dateTime);
  } else if (target == tomorrow) {
    // غدًا
    return 'Tomorrow';
  } else {
    // تاريخ فقط
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static const String nameRoute = "ChatView";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // التمرير للأسفل بعد بناء الواجهة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final cMessages = context.read<MessagesCubit>();
    final selectedChat = context.watch<SelectedChatCubit>().state;

    // إرسال رسالة mark as read
    cMessages.markMessageAsRead(selectedChat.lastMessage!.id);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedChat = context.watch<SelectedChatCubit>().state;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Chat Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[400]!, Colors.blue[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      "http://192.168.0.80:3000/${selectedChat.otherUser!.profileImg}",
                      fit: BoxFit.fill,
                      errorBuilder:
                          (context, error, stackTrace) => Icon(Icons.person),
                    ),
                  ),

                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedChat.otherUser!.name.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          selectedChat.otherUser!.isOnline!
                              ? 'Online now'
                              : 'Offline',
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.videocam, color: Colors.grey[600]),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.call, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // 🟢 Messages list
            Expanded(
              child: BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  if (state is MessagesLoaded) {
                    final selectedUserId =
                        context.watch<SelectedChatCubit>().state.otherUser!.id;

                    final updatedConversation = state.messages.firstWhere(
                      (conv) => conv.otherUser!.id == selectedUserId,
                      orElse: () => selectedChat,
                    );

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16),
                      itemCount: updatedConversation.lastMessages?.length ?? 0,
                      itemBuilder: (context, index) {
                        final message =
                            updatedConversation.lastMessages![index];
                        return BuildMessageBubble(message: message);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),

            // Message input
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SendMeesageWidget(
                receiverId: selectedChat.otherUser!.id,
                onMessageSent: _scrollToBottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendMeesageWidget extends StatefulWidget {
  const SendMeesageWidget({
    super.key,
    required this.receiverId,
    required this.onMessageSent,
  });

  final String receiverId;
  final VoidCallback onMessageSent; // ✅ دالة يتم استدعاؤها بعد الإرسال

  @override
  State<SendMeesageWidget> createState() => _SendMeesageWidgetState();
}

class _SendMeesageWidgetState extends State<SendMeesageWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Write a letter...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        BlocListener<MessagesCubit, MessagesState>(
          listener: (context, state) {
            if (state is MessagesLoaded) {
              controller.clear(); // تنظيف الحقل
              widget.onMessageSent(); // ✅ التمرير لأسفل بعد الإرسال
              setState(() {});
            }
          },
          child: InkWell(
            onTap: () {
              if (controller.text.isNotEmpty) {
                context.read<MessagesCubit>().sendMessage(
                  text: controller.text,
                  receiverId: widget.receiverId,
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
