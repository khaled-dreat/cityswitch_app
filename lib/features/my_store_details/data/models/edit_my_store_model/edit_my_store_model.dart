import 'store.dart';

class EditMyStoreModel {
  String? message;
  Store? store;

  EditMyStoreModel({this.message, this.store});

  factory EditMyStoreModel.fromJson(Map<String, dynamic> json) {
    return EditMyStoreModel(
      message: json['message'] as String?,
      store:
          json['store'] == null
              ? null
              : Store.fromJson(json['store'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'store': store?.toJson(),
  };
}
