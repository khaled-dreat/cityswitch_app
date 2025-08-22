import 'dart:developer';

import 'package:cityswitch_app/features/my_msg_test/socket_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'socket_cubit.dart';

class ChatView extends StatelessWidget {
  final String receiverId;

  const ChatView({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    final socketCubit = context.read<SocketCubit>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('الدردشة')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SocketCubit, SocketState>(
              builder: (context, state) {
                final messages = state.messages;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final msg = messages[index];
                    final isMine = msg['sender'] == socketCubit.userId;
                    return Align(
                      alignment:
                          isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isMine ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(msg['text'] ?? ''),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final msg = controller.text.trim();
                    log('📤 نحاول إرسال الرسالة: $msg');
                    socketCubit.sendMessage(receiverId, msg);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
