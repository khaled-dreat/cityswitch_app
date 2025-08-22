import 'api_message_user_model.dart';

class ApiMessageModel {
  final String id;
  final ApiMessageUserModel sender;
  final ApiMessageUserModel receiver;
  final String text;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApiMessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApiMessageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ApiMessageModel(
      id: data['_id'],
      sender: ApiMessageUserModel.fromJson(data['sender']),
      receiver: ApiMessageUserModel.fromJson(data['receiver']),
      text: data['text'],
      isRead: data['isRead'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
    );
  }
}
