import 'datum.dart';

class MyConversationModel {
  bool? success;
  List<Datum>? data;

  MyConversationModel({this.success, this.data});

  factory MyConversationModel.fromJson(Map<String, dynamic> json) {
    return MyConversationModel(
      success: json['success'] as bool?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
