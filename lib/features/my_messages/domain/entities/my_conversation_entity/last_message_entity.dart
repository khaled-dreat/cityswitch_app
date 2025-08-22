class LastMessageEntity {
  final String id;
  final String sender;
  final String receiver;
  final String text;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  LastMessageEntity({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  LastMessageEntity copyWith({
    String? id,
    String? sender,
    String? receiver,
    String? text,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LastMessageEntity(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      text: text ?? this.text,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
