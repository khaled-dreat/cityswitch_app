import '../entities/my_conversation_entity/conversation_entity.dart';
import '../repositories/my_meesage_repo.dart';

class GetConversationUseCase {
  final MessageRepository repository;

  GetConversationUseCase({required this.repository});

  Future<List<MyConversationEntity>> call({required String token}) async {
    return await repository.getMessagesWithUser(token: token);
  }
}
