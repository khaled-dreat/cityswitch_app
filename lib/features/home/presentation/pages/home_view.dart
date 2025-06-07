import 'dart:math';
import 'dart:developer' as dev;

import 'package:cityswitch_app/features/home/presentation/manger/fetch_home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/calculate_zoom_for_furthest_store/calculate_zoom_for_furthest_store.dart';
import '../../../../core/utils/location_service/location_service.dart';
import '../../domain/entities/maps_entites.dart';
import '../manger/select_category_cubit/select_category_cubit.dart';
import '../widgets/check_list.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late CameraPosition initialCameraPostion;
  String? selectedCategory;
  List<StorsEntites> allStores = [];
  late LocationService locationService;
  CalculateZoomForFurthestStore calculateZoomForFurthestStore =
      CalculateZoomForFurthestStore();
  @override
  void initState() {
    initialCameraPostion = const CameraPosition(
      zoom: 6,
      target: LatLng(51.137304653951055, 10.424409714917962),
    );
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  void addStoreMarkers(String? category) async {
    markers.clear();

    final filteredStores =
        allStores.where((store) => store.category == category).toList();

    for (StorsEntites store in filteredStores) {
      if (store.location?.lat != null && store.location?.lng != null) {
        markers.add(
          Marker(
            markerId: MarkerId(store.id!),
            position: LatLng(store.location!.lat!, store.location!.lng!),
            infoWindow: InfoWindow(title: store.name),
            icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(48, 48)),
              'assets/img/logo/logo.png',
            ),
          ),
        );
      }
    }
    var loc = await locationService.getLocation();
    setMyCameraPosition(
      locationData: loc,
      zoomLivel: await calculateZoomForFurthestStore.findFurthestLocation(
        allStores,
      ),
    );
    setMyLocationMarker(loc);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<HomeCubit>().fetchStors();

    // استمع لتحديث المتاجر
    context.read<HomeCubit>().stream.listen((state) {
      if (state is MapSuccess) {
        allStores = state.stors;
        addStoreMarkers(context.read<StoreFilterCubit>().state);
      }
    });

    // استمع لتغيير الفئة المحددة
    context.read<StoreFilterCubit>().stream.listen((category) {
      selectedCategory = category;
      addStoreMarkers(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DropDownScreen(),

            Expanded(
              child: GoogleMap(
                myLocationButtonEnabled: true,
                markers: markers,
                onMapCreated: (controller) {
                  googleMapController = controller;
                },
                initialCameraPosition: initialCameraPostion,
                cameraTargetBounds: CameraTargetBounds(
                  LatLngBounds(
                    southwest: LatLng(47.41209395398004, 5.985812356300719),
                    northeast: LatLng(54.96404597537539, 14.934166528572108),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      getMylocation();
      //     setMyCameraPosition(locationData);
      //  locationService.getRealTimeLocationData((locationData) {
      //    setMyLocationMarker(locationData);
      //  });
    } else {}
  }

  void getMylocation() async {
    var loc = await locationService.getLocation();
    setMyLocationMarker(loc);
    setMyCameraPosition(locationData: loc);
  }

  void setMyCameraPosition({
    required LocationData locationData,
    double? zoomLivel,
  }) {
    var camerPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: zoomLivel ?? 15,
    );

    googleMapController?.animateCamera(
      CameraUpdate.
      newCameraPosition(camerPosition),
    );
  }

  void setMyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
      markerId: const MarkerId('my_location_marker'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );

    markers.add(myLocationMarker);
    setState(() {});
  }
}
