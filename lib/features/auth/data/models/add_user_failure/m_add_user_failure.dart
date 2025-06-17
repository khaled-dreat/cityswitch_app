import 'm_error.dart';

class AddUserFailureModel {
  List<ErrorModel>? errors;

  AddUserFailureModel({this.errors});

  factory AddUserFailureModel.fromJson(Map<String, dynamic> json) {
    return AddUserFailureModel(
      errors:
          (json['errors'] as List<dynamic>?)
              ?.map((e) => ErrorModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'errors': errors?.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() => 'AddUserFailureModel(errors: $errors)';
}
