import 'dart:math';

import '../../features/home/domain/entities/stors_entites.dart';
import '../utils/location_service/location_service.dart';

class CalculateZoomForFurthestStore {
  final locationService = LocationService();
  Future<double> findFurthestLocation(List<StorsEntites> data) async {
    var loc = await locationService.getLocation();

    double myLat = loc.latitude!;
    double myLng = loc.longitude!;

    double maxDistance = 0;

    for (var place in data) {
      final location = place.location;
      final distance = calculateDistance(
        myLat,
        myLng,
        location!.lat,
        location.lng,
      );

      if (distance > maxDistance) {
        maxDistance = distance;
      }
    }

    return chooseZoomLevel(maxDistance);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371000; // نصف قطر الأرض بالمتر
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degToRad(double deg) => deg * (pi / 180);

  double chooseZoomLevel(double distanceInMeters) {
    if (distanceInMeters < 300) return 16;
    if (distanceInMeters < 1000) return 15;
    if (distanceInMeters < 2000) return 14;
    if (distanceInMeters < 5000) return 13;
    if (distanceInMeters < 10000) return 12;
    if (distanceInMeters < 20000) return 11;
    if (distanceInMeters < 50000) return 10;
    if (distanceInMeters < 100000) return 9;
    if (distanceInMeters < 200000) return 8;
    return 7;
  }
}
