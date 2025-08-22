import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_entity.dart';
import '../entities/send_message_entity/send_message_entity.dart';
import '../repositories/my_meesage_repo.dart';

class SendMessageSocketUsecase {
  final MessageRepository repository;

  SendMessageSocketUsecase({required this.repository});

  Future<void> call({required String receiverId, required String text}) async {
    return repository.sendMessageSocket(receiverId: receiverId, text: text);
  }
}
