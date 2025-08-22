import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_entity.dart';
import '../entities/send_message_entity/send_message_entity.dart';
import '../repositories/my_meesage_repo.dart';

class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase({required this.repository});

  Future<ApiMessageEntity> call({
    required SendMessageEntity message,
    required String token,
  }) async {
    return await repository.sendMessage(message: message, token: token);
  }
}
