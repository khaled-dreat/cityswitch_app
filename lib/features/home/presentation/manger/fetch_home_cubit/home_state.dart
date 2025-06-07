// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends MapState {}

class MapLoading extends MapState {}

class MapFailure extends MapState {
  final String errMessage;
  const MapFailure({required this.errMessage});
}

class MapSuccess extends MapState {
  final List<StorsEntites> stors;

  const MapSuccess({required this.stors});
}
