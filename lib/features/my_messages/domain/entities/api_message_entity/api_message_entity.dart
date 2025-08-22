import 'api_message_user_entity.dart';

class ApiMessageEntity {
  final String id;
  final ApiMessageUserEntity sender;
  final ApiMessageUserEntity receiver;
  final String text;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApiMessageEntity({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });
}
