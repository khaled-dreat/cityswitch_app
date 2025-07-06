// map_widget.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/calculate_zoom_for_furthest_store/calculate_zoom_for_furthest_store.dart';
import '../../../../core/utils/location_service/location_service.dart';
import '../../../add_store/presentation/manger/add_store/add_store_cubit.dart';
import '../manger/map_cubit/map_cubit.dart';
import '../manger/store_cubit/stors_cubit.dart';
import '../manger/select_category_cubit/select_category_cubit.dart';

class MapWidget extends StatefulWidget {
  static const String nameRoute = "MapSample";
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  late LocationService locationService;
  CalculateZoomForFurthestStore calculateZoomForFurthestStore =
      CalculateZoomForFurthestStore();

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
    _updateUserLocation();
  }

  late final StreamSubscription _storesSubscription;
  late final StreamSubscription _categorySubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _storesSubscription = context.read<StorsCubit>().stream.listen((state) {
      if (!mounted) return; // تحقق من mounted
      if (state is StorsSuccess) {
        context.read<MapCubit>().updateStores(state.stors);
      }
    });

    _categorySubscription = context
        .read<SelectCategoryDropDownCubit>()
        .stream
        .listen((category) {
          if (!mounted) return; // تحقق من mounted
          context.read<MapCubit>().updateSelectedCategory(category);
        });
  }

  @override
  void dispose() {
    _storesSubscription.cancel();
    _categorySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          Set<Marker> markers = {};

          if (state is MapMarkersUpdated) {
            markers = state.markers;
          } else if (state is MapUserLocationUpdated) {
            markers = state.markers;
          }

          return GoogleMap(
            myLocationButtonEnabled: true,
            markers: markers,
            onMapCreated: (controller) {
              context.read<MapCubit>().setMapController(controller);
            },
            initialCameraPosition:
                context.read<MapCubit>().initialCameraPosition,
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: LatLng(47.41209395398004, 5.985812356300719),
                northeast: LatLng(54.96404597537539, 14.934166528572108),
              ),
            ),
          );
        },
      ),
    );
  }

  void _updateUserLocation() async {
    try {
      await locationService.checkAndRequestLocationService();
      var hasPermission =
          await locationService.checkAndRequestLocationPermission();

      if (hasPermission) {
        await _getCurrentLocation();
      }
    } catch (e) {
      // Handle location error
      print('Error getting location: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      AddStoreCubit cAddstore = BlocProvider.of<AddStoreCubit>(context);

      cAddstore.storeLocation.lat = locationData.latitude;
      cAddstore.storeLocation.lng = locationData.longitude;

      // Calculate zoom level for furthest store
      final currentStores = context.read<StorsCubit>().state;
      double? zoomLevel;

      if (currentStores is StorsSuccess) {
        zoomLevel = await calculateZoomForFurthestStore.findFurthestLocation(
          currentStores.stors,
        );
      }

      // Update map with user location
      context.read<MapCubit>().updateUserLocation(
        locationData,
        zoomLevel: zoomLevel,
      );
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
}

/* import 'package:cityswitch_app/features/add_store/presentation/manger/add_store/add_store_cubit.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/calculate_zoom_for_furthest_store/calculate_zoom_for_furthest_store.dart';
import '../../../../core/utils/location_service/location_service.dart';
import '../manger/store_cubit/stors_cubit.dart';
import '../manger/select_category_cubit/select_category_cubit.dart';

class MapWidget extends StatefulWidget {
  static const String nameRoute = "MapSample";
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
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
            icon: await BitmapDescriptor.asset(
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

    // context.read<StorsCubit>().fetchStors();

    // استمع لتحديث المتاجر
    context.read<StorsCubit>().stream.listen((state) {
      if (state is StorsSuccess) {
        allStores = state.stors;
        addStoreMarkers(context.read<SelectCategoryDropDownCubit>().state);
      }
    });

    // استمع لتغيير الفئة المحددة
    context.read<SelectCategoryDropDownCubit>().stream.listen((category) {
      selectedCategory = category;
      addStoreMarkers(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      getMylocation();
    } else {}
  }

  void getMylocation() async {
    var loc = await locationService.getLocation();
    AddStoreCubit cAddstore = BlocProvider.of<AddStoreCubit>(context);

    cAddstore.storeLocation.lat = loc.latitude;
    cAddstore.storeLocation.lng = loc.longitude;

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
      CameraUpdate.newCameraPosition(camerPosition),
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
 */
