import 'store.dart';

class AddStoreModel {
  String? message;
  Store? store;

  AddStoreModel({this.message, this.store});

  factory AddStoreModel.fromJson(Map<String, dynamic> json) => AddStoreModel(
    message: json['message'] as String?,
    store:
        json['store'] == null
            ? null
            : Store.fromJson(json['store'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'store': store?.toJson(),
  };
}
