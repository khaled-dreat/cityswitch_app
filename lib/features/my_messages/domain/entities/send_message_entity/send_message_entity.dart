class SendMessageEntity {
  final String senderId;
  final String receiverId;
  final String text;

  SendMessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {'senderId': senderId, 'receiverId': receiverId, 'text': text};
  }
}
