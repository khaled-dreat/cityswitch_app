// map_state.dart
part of 'map_cubit.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapMarkersUpdated extends MapState {
  final Set<Marker> markers;

  const MapMarkersUpdated(this.markers);

  @override
  List<Object> get props => [markers];
}

final class MapUserLocationUpdated extends MapState {
  final Set<Marker> markers;
  final CameraPosition cameraPosition;

  const MapUserLocationUpdated(this.markers, this.cameraPosition);

  @override
  List<Object> get props => [markers, cameraPosition];
}

final class MapMarkersCleared extends MapState {}

final class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object> get props => [message];
}
