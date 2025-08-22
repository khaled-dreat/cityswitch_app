import 'dart:developer';
import 'package:cityswitch_app/features/my_messages/data/mappers/api_message_toentity_mapper.dart';
import 'package:cityswitch_app/features/my_messages/data/mappers/conversation_model_mapper.dart';
import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_entity.dart';

import '../../../../core/api/api_service.dart';
import '../../domain/entities/my_conversation_entity/conversation_entity.dart';
import '../../domain/entities/my_conversation_entity/message_entity.dart';
import '../../domain/entities/send_message_entity/send_message_entity.dart';
import '../models/api_message_model/api_message_model.dart';
import '../models/my_conversation/my_conversation.dart';

abstract class MessagesRemoteDataSource {
  Future<List<MyConversationEntity>> fetchConversation({required String token});
  Future<ApiMessageEntity> sendMessage({
    required SendMessageEntity message,
    required String token,
  });
  Future<List<MessageEntity>> getUnreadMessages();
}

class MessagesRemoteDataSourceImpl extends MessagesRemoteDataSource {
  final ApiService apiService;

  MessagesRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<MyConversationEntity>> fetchConversation({
    required String token,
  }) async {
    try {
      final response = await apiService.getAllMyMessages(token: token);

      log('✅ response: ${response}');
      log('✅ type: ${response.runtimeType}');
      // ✅ هنا نمرّر كامل الـ Map
      final model = MyConversationModel.fromJson(response);

      // ✅ تأكد أن toEntityList لا تعتمد على model.data.data

      return model.toEntityList();
    } catch (e) {
      log('❌ fetchConversation error: $e');
      rethrow;
    }
  }

  @override
  Future<ApiMessageEntity> sendMessage({
    required SendMessageEntity message,
    required String token,
  }) async {
    try {
      final response = await apiService.postMyMeesage(
        sendMessageEntity: message,
        token: token,
      );

      final model = ApiMessageModel.fromJson(response);
      return model.toEntity();
    } catch (e) {
      log('❌ sendMessage error: $e');
      rethrow;
    }
  }

  @override
  Future<List<MessageEntity>> getUnreadMessages() async {
    try {
      final response = await apiService.get(endPoint: 'api/messages/unread');
      final List data = response['data'];
      return data.map((e) => MessageEntity.fromJson(e)).toList();
    } catch (e) {
      log('❌ getUnreadMessages error: $e');
      rethrow;
    }
  }
}
