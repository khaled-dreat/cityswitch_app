import 'package:cityswitch_app/features/my_messages/data/models/api_message_model/api_message_user_model.dart';
import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_entity.dart';
import 'package:cityswitch_app/features/my_messages/domain/entities/api_message_entity/api_message_user_entity.dart';

import '../models/api_message_model/api_message_model.dart';

extension MessageModelMapper on ApiMessageModel {
  ApiMessageEntity toEntity() => ApiMessageEntity(
    id: id,
    sender: sender.toEntity(),
    receiver: receiver.toEntity(),
    text: text,
    isRead: isRead,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension UserModelMapper on ApiMessageUserModel {
  ApiMessageUserEntity toEntity() =>
      ApiMessageUserEntity(id: id, name: name, profileImg: profileImg);
}
