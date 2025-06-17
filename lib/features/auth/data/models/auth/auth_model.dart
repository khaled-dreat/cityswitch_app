class AuthModel {
  String? name;
  String? email;
  String? password;
  String? passwordConfirm;

  AuthModel({this.name, this.email, this.password, this.passwordConfirm});

  void setEmail(String? value) => email = value;
  void setPass(String? value) => password = value;
  void setName(String? value) => name = value;
  void setpasswordConfirm(String? value) => passwordConfirm = value;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    name: json['name'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    passwordConfirm: json['passwordConfirm'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'passwordConfirm': passwordConfirm,
  };
}
