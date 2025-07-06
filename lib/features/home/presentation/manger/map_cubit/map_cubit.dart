// map_cubit.dart
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../domain/entities/stors_entites.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  GoogleMapController? _googleMapController;
  Set<Marker> _markers = {};
  List<StorsEntites> _allStores = [];
  String? _selectedCategory;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    zoom: 6,
    target: LatLng(51.137304653951055, 10.424409714917962),
  );

  CameraPosition get initialCameraPosition => _initialCameraPosition;

  void setMapController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void updateStores(List<StorsEntites> stores) {
    _allStores = stores;
    _updateMarkers();
  }

  void updateSelectedCategory(String? category) {
    _selectedCategory = category;
    _updateMarkers();
  }

  void _updateMarkers() async {
    emit(MapLoading());

    _markers.clear();

    // Filter stores by category if selected
    final filteredStores =
        _selectedCategory != null
            ? _allStores
                .where((store) => store.category == _selectedCategory)
                .toList()
            : _allStores;

    // Add store markers
    for (StorsEntites store in filteredStores) {
      if (store.location?.lat != null && store.location?.lng != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(store.id!),
            position: LatLng(store.location!.lat!, store.location!.lng!),
            infoWindow: InfoWindow(title: store.name),
            icon: await BitmapDescriptor.asset(
              const ImageConfiguration(size: Size(48, 48)),
              'assets/img/logo/logo.png',
            ),
          ),
        );
      }
    }

    emit(MapMarkersUpdated(_markers));
  }

  void updateUserLocation(LocationData locationData, {double? zoomLevel}) {
    // Add user location marker
    final userMarker = Marker(
      markerId: const MarkerId('my_location_marker'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );

    _markers.add(userMarker);

    // Update camera position
    final cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: zoomLevel ?? 15,
    );

    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    emit(MapUserLocationUpdated(_markers, cameraPosition));
  }

  void clearMarkers() {
    _markers.clear();
    emit(MapMarkersCleared());
  }
}
