import 'package:flutter/material.dart';

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
    'Ahmed Mohamed': [
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: selectedContact == null ? _buildContactsList() : _buildChatView(),
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return _buildContactItem(contact);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(Contact contact) {
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
        onTap: () {
          setState(() {
            selectedContact = contact.name;
          });
        },
        leading: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(contact.avatar, style: TextStyle(fontSize: 24)),
              ),
            ),
            if (contact.isOnline)
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
          contact.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            contact.lastMessage,
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
              contact.time,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            if (contact.unreadCount > 0)
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

  Widget _buildChatView() {
    final messages = conversations[selectedContact] ?? [];

    return SafeArea(
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
                    setState(() {
                      selectedContact = null;
                    });
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[400]!, Colors.blue[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      contacts
                          .firstWhere((c) => c.name == selectedContact)
                          .avatar,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedContact!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Online now',
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

          // Messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message Input
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a letter...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.blue[600] : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                color: message.isMe ? Colors.white70 : Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
