import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الخرائط',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  LatLng _initialPosition = LatLng(24.7136, 46.6753); // الرياض كموقع افتراضي

  // Controllers للحقول النصية
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _streetController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // الحصول على الموقع الحالي
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });

      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLng(_initialPosition));
      }
    } catch (e) {
      print('خطأ في الحصول على الموقع: $e');
    }
  }

  // البحث عن الموقع باستخدام العنوان
  Future<void> _searchLocation() async {
    if (_cityController.text.isEmpty) {
      _showMessage('يرجى إدخال اسم المدينة');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // تجميع العنوان الكامل
      String fullAddress = '';
      if (_streetController.text.isNotEmpty) {
        fullAddress += _streetController.text + ', ';
      }
      fullAddress += _cityController.text;
      if (_postalCodeController.text.isNotEmpty) {
        fullAddress += ', ' + _postalCodeController.text;
      }

      // البحث عن الموقع
      List<Location> locations = await locationFromAddress(fullAddress);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newPosition = LatLng(location.latitude, location.longitude);

        // تحديث الخريطة والعلامة
        setState(() {
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId('searched_location'),
              position: newPosition,
              infoWindow: InfoWindow(
                title: 'الموقع المطلوب',
                snippet: fullAddress,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          );
        });

        // تحريك الكاميرا إلى الموقع الجديد
        if (_controller != null) {
          _controller!.animateCamera(
            CameraUpdate.newLatLngZoom(newPosition, 15),
          );
        }

        _showMessage('تم العثور على الموقع بنجاح');
      } else {
        _showMessage('لم يتم العثور على الموقع');
      }
    } catch (e) {
      _showMessage('خطأ في البحث: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // عرض رسالة للمستخدم
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 3)),
    );
  }

  // مسح الحقول والعلامات
  void _clearAll() {
    setState(() {
      _cityController.clear();
      _postalCodeController.clear();
      _streetController.clear();
      _markers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تطبيق الخرائط', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // قسم الإدخال
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // حقل المدينة
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'اسم المدينة *',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 12),

                // حقل الرمز البريدي
                TextField(
                  controller: _postalCodeController,
                  decoration: InputDecoration(
                    labelText: 'الرمز البريدي',
                    prefixIcon: Icon(Icons.mail_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 12),

                // حقل الشارع
                TextField(
                  controller: _streetController,
                  decoration: InputDecoration(
                    labelText: 'اسم الشارع',
                    prefixIcon: Icon(Icons.remove_road),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 16),

                // أزرار التحكم
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _searchLocation,
                        icon:
                            _isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : Icon(Icons.search),
                        label: Text(_isLoading ? 'جاري البحث...' : 'البحث'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _clearAll,
                      icon: Icon(Icons.clear),
                      label: Text('مسح'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // قسم الخريطة
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 10,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onTap: (LatLng position) {
                // إمكانية إضافة علامة عند الضغط على الخريطة
                setState(() {
                  _markers.clear();
                  _markers.add(
                    Marker(
                      markerId: MarkerId('tapped_location'),
                      position: position,
                      infoWindow: InfoWindow(
                        title: 'موقع محدد',
                        snippet:
                            'خط الطول: ${position.longitude.toStringAsFixed(6)}\nخط العرض: ${position.latitude.toStringAsFixed(6)}',
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _postalCodeController.dispose();
    _streetController.dispose();
    super.dispose();
  }
}
