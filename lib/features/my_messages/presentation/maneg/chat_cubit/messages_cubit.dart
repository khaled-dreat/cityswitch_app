// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_entity.dart';
import 'package:cityswitch_app/features/my_messages/domain/usecases/get_conversation_usecase.dart';
import 'package:cityswitch_app/features/my_messages/domain/usecases/send_message_usecase.dart';

import '../../../../../core/user_session/user_session_app.dart';
import '../../../domain/entities/api_message_entity/api_message_user_entity.dart';
import '../../../domain/entities/my_conversation_entity/conversation_entity.dart';
import '../../../domain/entities/my_conversation_entity/last_message_entity.dart';
import '../../../domain/entities/my_conversation_entity/message_entity.dart';
import '../../../domain/entities/my_conversation_entity/other_user_entity.dart';
import '../../../domain/entities/send_message_entity/send_message_entity.dart';
import '../../../domain/usecases/connect_socket_usecase.dart';
import '../../../domain/usecases/disconnect_socket_usecase.dart';
import '../../../domain/usecases/initialize_socket_usecase.dart';
import '../../../domain/usecases/listen_to_messages_usecase.dart';
import '../../../domain/usecases/mark_message_as_read_usecase.dart';
import '../../../domain/usecases/send_message_socket_usecase.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  // final MessageRepository messageRepository;
  // final SocketService socketService;
  final GetConversationUseCase getConversationUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final SendMessageSocketUsecase sendMessageSocketUsecase;
  final ConnectSocketUseCase connectSocketUseCase;
  final ListenToMessagesUseCase listenToMessagesUseCase;
  final MarkMessageAsReadUsecase markMessageAsReadUsecase;
  final DisconnectSocketUsecase disconnectSocketUsecase;
  final InitializeSocketListenerUseCase initializeSocketListenerUseCase;

  MessagesCubit({
    required this.getConversationUseCase,
    required this.sendMessageUseCase,
    required this.sendMessageSocketUsecase,
    required this.connectSocketUseCase,
    required this.listenToMessagesUseCase,
    required this.markMessageAsReadUsecase,
    required this.disconnectSocketUsecase,
    required this.initializeSocketListenerUseCase,
  }) : super(MessagesInitial());

  List<MyConversationEntity> _messages = [];
  List<MyConversationEntity> get messages => _messages;
  final token = AppUserSession().token;
  final userId = AppUserSession().userId;

  Future<void> fetchConversation() async {
    emit(MessagesLoading());
    try {
      _messages = await getConversationUseCase.call(token: token!);

      emit(MessagesLoaded(messages: _messages));
    } catch (e) {
      emit(MessagesError(error: e.toString()));
    }
  }

  List<MyConversationEntity> addMessageToConversations({
    required ApiMessageEntity newMessage,
    required List<MyConversationEntity> oldConversations,
    required String currentUserId,
  }) {
    final updatedList = [...oldConversations];

    final index = updatedList.indexWhere((conversation) {
      final otherUserId = conversation.otherUser!.id;
      return otherUserId == newMessage.sender.id ||
          otherUserId == newMessage.receiver.id;
    });

    final isIncoming = newMessage.sender.id != currentUserId;

    // تحويل الرسالة الجديدة إلى MessageEntity
    final newMessageEntity = MessageEntity(
      id: newMessage.id,
      sender: newMessage.sender.id,
      receiver: newMessage.receiver.id,
      text: newMessage.text,
      isRead: newMessage.isRead,
      createdAt: newMessage.createdAt,
      updatedAt: newMessage.updatedAt,
    );

    if (index != -1) {
      final conversation = updatedList[index];

      // إضافة الرسالة الجديدة
      final updatedMessages = [...?conversation.lastMessages, newMessageEntity];

      // ترتيب الرسائل حسب تاريخ الإنشاء من الأقدم إلى الأحدث
      updatedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      updatedList[index] = MyConversationEntity(
        id: conversation.id,
        lastMessage: LastMessageEntity(
          id: newMessage.id,
          sender: newMessage.sender.id,
          receiver: newMessage.receiver.id,
          text: newMessage.text,
          isRead: newMessage.isRead,
          createdAt: newMessage.createdAt,
          updatedAt: newMessage.updatedAt,
        ),
        unreadCount:
            isIncoming
                ? conversation.unreadCount! + 1
                : conversation.unreadCount,
        otherUser: conversation.otherUser,
        lastMessages: updatedMessages,
      );
    } else {
      final otherUser = isIncoming ? newMessage.sender : newMessage.receiver;

      final newConversation = MyConversationEntity(
        id: '', // مؤقتًا
        lastMessage: LastMessageEntity(
          id: newMessage.id,
          sender: newMessage.sender.id,
          receiver: newMessage.receiver.id,
          text: newMessage.text,
          isRead: newMessage.isRead,
          createdAt: newMessage.createdAt,
          updatedAt: newMessage.updatedAt,
        ),
        unreadCount: isIncoming ? 1 : 0,
        otherUser: OtherUserEntity(
          id: otherUser.id,

          name: otherUser.name,
          profileImg: otherUser.profileImg ?? '',
        ),
        lastMessages: [newMessageEntity], // ✅ النوع الصحيح
      );

      updatedList.insert(0, newConversation);
    }

    return updatedList;
  }

  Future<void> sendMessage({
    required String text,
    required String receiverId,
  }) async {
    try {
      SendMessageEntity message = SendMessageEntity(
        senderId: userId!,
        receiverId: receiverId,
        text: text,
      );
      final newMessage = await sendMessageUseCase.call(
        message: message,
        token: token!,
      );
      _messages = addMessageToConversations(
        newMessage: newMessage,
        oldConversations: _messages,
        currentUserId: userId!,
      );
      emit(MessagesLoaded(messages: List.from(_messages)));

      // إرسال عبر WebSocket
      sendMessageSocketUsecase.call(receiverId: receiverId, text: text);
    } catch (e) {
      emit(MessagesError(error: 'Failed to send message: $e'));
    }
  }

  void _handleSocketMessage(MessageEntity message) {
    log('📩 WebSocket Message Received: $message');

    final apiMessage = ApiMessageEntity(
      id: message.id,
      sender: ApiMessageUserEntity(
        id: message.sender,
        name: '', // لأن WebSocket لا يرسل الاسم والصورة غالبًا
        profileImg: '',
      ),
      receiver: ApiMessageUserEntity(
        id: message.receiver,
        name: '',
        profileImg: '',
      ),
      text: message.text,
      isRead: message.isRead,
      createdAt: message.createdAt,
      updatedAt: message.updatedAt,
    );

    _messages = addMessageToConversations(
      newMessage: apiMessage,
      oldConversations: _messages,
      currentUserId: userId!,
    );
    emit(MessagesLoaded(messages: List.from(_messages)));
  }

  bool _hasStartedListeningToReadStatus = false;

  void connectSocket({required String userId, required String token}) {
    connectSocketUseCase.call(token: token, userId: userId);

    // الاستماع للرسائل الجديدة دائمًا
    listenToMessagesUseCase.call(_handleSocketMessage);

    // ✅ تأكد من عدم تكرار التسجيل للاستماع لحالة القراءة
    if (!_hasStartedListeningToReadStatus) {
      _hasStartedListeningToReadStatus = true;

      listenToMessagesUseCase.listenToReadStatus((messageId, readBy) {
        log('📥 message_read event received: $messageId by $readBy');
        _updateMessagesAsRead(messageId, readBy);
      });
    }
  }

  void _updateMessagesAsRead(String messageId, String readBy) {
    log(
      '🟡 [START] _updateMessagesAsRead called for messageId=$messageId by userId=$readBy',
    );

    for (var i = 0; i < _messages.length; i++) {
      final conv = _messages[i];
      log(
        '🔍 Checking conversation ${conv.id} with otherUser=${conv.otherUser?.id}',
      );

      // ✅ فقط المحادثة التي تحتوي على الرسالة المطلوبة
      final containsTargetMessage =
          conv.lastMessages?.any((msg) => msg.id == messageId) ?? false;

      if (!containsTargetMessage) {
        log('⏭ Skipping conversation ${conv.id} (no target message)');
        continue;
      }

      log('✅ Updating messages for conversation ${conv.id}');

      // تحديث الرسائل المقروءة
      final updatedMessages =
          conv.lastMessages?.map((msg) {
            if (msg.receiver == readBy && !msg.isRead) {
              log('🟦 Marking message ${msg.id} as read');
              return msg.copyWith(isRead: true);
            }
            return msg;
          }).toList();

      // تحديث آخر رسالة إن كانت هي الهدف
      final updatedLastMessage =
          (conv.lastMessage?.id == messageId &&
                  conv.lastMessage?.receiver == readBy &&
                  conv.lastMessage?.isRead == false)
              ? conv.lastMessage!.copyWith(isRead: true)
              : conv.lastMessage;

      // تحديث المحادثة
      _messages[i] = conv.copyWith(
        lastMessages: updatedMessages,
        lastMessage: updatedLastMessage,
        unreadCount: 0,
      );
    }

    emit(MessagesLoaded(messages: List.from(_messages)));
    log('🟢 [DONE] emit(MessagesLoaded) after read update');
  }

  Future<void> markMessageAsRead(String messageId) async {
    try {
      log('📩 markMessageAsRead called for messageId: $messageId');

      // أرسل حدث mark_read عبر WebSocket
      markMessageAsReadUsecase.call(messageId: messageId);

      // ✅ تحديث محلي مباشر دون انتظار socket event
      _updateMessagesAsRead(messageId, userId!); // ← أضف هذا السطر
    } catch (e) {
      emit(MessagesError(error: 'Failed to mark as read: $e'));
    }
  }

  final Set<String> _onlineUsers = {};
  Set<String> get onlineUsers => _onlineUsers;

  void _initUserStatusListeners() {
    listenToMessagesUseCase.socketService.listenToUserStatus(
      onUserOnline: (userId) {
        _onlineUsers.add(userId);
        emit(MessagesLoaded(messages: List.from(_messages))); // لإعادة البناء
      },
      onUserOffline: (userId) {
        _onlineUsers.remove(userId);
        emit(MessagesLoaded(messages: List.from(_messages)));
      },
    );
  }

  // Future<void> getUnreadMessages() async {
  //   emit(MessagesLoading());
  //   try {
  //     final unread = await messageRepository.getUnreadMessages();
  //     emit(MessagesUnread(messages: unread));
  //   } catch (e) {
  //     emit(MessagesError(error: 'Failed to get unread messages: $e'));
  //   }
  // }

  void disconnectSocket() {
    disconnectSocketUsecase.call();
  }

  void initializeSocketListener() {
    initializeSocketListenerUseCase((message) {
      final apiMessage = ApiMessageEntity(
        id: message.id,
        sender: ApiMessageUserEntity(
          id: message.sender,
          name: '',
          profileImg: '',
        ),
        receiver: ApiMessageUserEntity(
          id: message.receiver,
          name: '',
          profileImg: '',
        ),
        text: message.text,
        isRead: message.isRead,
        createdAt: message.createdAt,
        updatedAt: message.updatedAt,
      );

      _messages = addMessageToConversations(
        newMessage: apiMessage,
        oldConversations: _messages,
        currentUserId: userId!,
      );

      emit(MessagesLoaded(messages: List.from(_messages)));
    });
  }
}
