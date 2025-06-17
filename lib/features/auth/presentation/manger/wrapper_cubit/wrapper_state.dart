import 'package:equatable/equatable.dart';

abstract class WrapperState extends Equatable {
  const WrapperState();

  @override
  List<Object> get props => [];
}

class WrapperInitial extends WrapperState {}

class UserExists extends WrapperState {}

class UserDoesNotExist extends WrapperState {}
