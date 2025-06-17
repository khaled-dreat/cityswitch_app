// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stors_cubit.dart';

abstract class StorsState extends Equatable {
  const StorsState();

  @override
  List<Object> get props => [];
}

class StorsInitial extends StorsState {}

class StorsLoading extends StorsState {}

class StorsFailure extends StorsState {
  final String errMessage;
  const StorsFailure({required this.errMessage});
}

class StorsSuccess extends StorsState {
  final List<StorsEntites> stors;

  const StorsSuccess({required this.stors});
}
