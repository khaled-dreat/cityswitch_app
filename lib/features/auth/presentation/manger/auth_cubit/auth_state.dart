// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class RegisterationLoading extends AuthState {}

class RegisterationSuccess extends AuthState {
  final UserEntites user;

  const RegisterationSuccess({required this.user});
}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AddUserFailure extends AuthState {
  final String errMessage;
  const AddUserFailure({required this.errMessage});
}

class AuthisNotShowPass extends AuthState {
  final bool isNotShowPass;

  const AuthisNotShowPass({required this.isNotShowPass});
}
