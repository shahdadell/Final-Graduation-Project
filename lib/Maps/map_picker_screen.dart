import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart'
    as geocoding; // استخدام alias لـ geocoding
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'
    as location_pkg; // استخدام alias لـ location
import 'package:permission_handler/permission_handler.dart';
import 'package:graduation_project/Theme/theme.dart';

class MapPickerScreen extends StatefulWidget {
  final String? initialLat;
  final String? initialLong;

  const MapPickerScreen({super.key, this.initialLat, this.initialLong});
  // أضفنا const هنا ^

  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late GoogleMapController _mapController;
  LatLng _selectedPosition =
      const LatLng(30.0444, 31.2357); // موقع افتراضي: القاهرة
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    // طلب إذن الموقع
    bool hasPermission = await _requestLocationPermission();
    if (!hasPermission) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
      // موقع افتراضي لو الأذونات مرفوضة
      _selectedPosition = const LatLng(30.0444, 31.2357);
      return;
    }

    // لو فيه موقع افتراضي (من EditAddressScreen)
    if (widget.initialLat != null && widget.initialLong != null) {
      try {
        double lat = double.parse(widget.initialLat!);
        double long = double.parse(widget.initialLong!);
        _selectedPosition = LatLng(lat, long);
      } catch (e) {
        print("Error parsing initial lat/long: $e");
        _selectedPosition = const LatLng(30.0444, 31.2357);
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // جيب الموقع الحالي باستخدام مكتبة location
    try {
      location_pkg.Location location = location_pkg.Location();
      // التأكد إن الخدمة مفعلة
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception("Location service is disabled");
        }
      }

      location_pkg.LocationData locationData = await location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        _selectedPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
      } else {
        throw Exception("Failed to get location data");
      }
    } catch (e) {
      print("Error getting current location: $e");
      // موقع افتراضي لو حصل خطأ (القاهرة)
      _selectedPosition = const LatLng(30.0444, 31.2357);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<Map<String, String>> _getAddressFromLatLng(
      double lat, double lng) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, lng);
      geocoding.Placemark place = placemarks[0];
      return {
        'city': place.locality ?? '',
        'street': place.street ?? '',
        'country': place.country ?? '',
      };
    } catch (e) {
      print("Error converting coordinates to address: $e");
      return {
        'city': '',
        'street': '',
        'country': '',
      };
    }
  }

  Future<bool> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status.isGranted;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_selectedPosition, 15),
    );
  }

  void _onCameraMove(CameraPosition position) {
    _selectedPosition = position.target;
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: MyTheme.whiteColor,
              size: 20.w,
            ),
          ),
        ),
        title: Text(
          "Select Location",
          style: textTheme.displayLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: MyTheme.whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: MyTheme.orangeColor))
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _selectedPosition,
                    zoom: 15,
                  ),
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                ),
                Center(
                  child: Icon(
                    Icons.location_pin,
                    color: MyTheme.redColor,
                    size: 40.w,
                  ),
                ),
              ],
            ),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton(
              onPressed: () async {
                // جيب العنوان النصي بناءً على الـ latitude وlongitude
                Map<String, String> addressDetails =
                    await _getAddressFromLatLng(
                  _selectedPosition.latitude,
                  _selectedPosition.longitude,
                );

                // رجّع الإحداثيات مع العنوان النصي
                Navigator.pop(context, {
                  'latitude': _selectedPosition.latitude.toString(),
                  'longitude': _selectedPosition.longitude.toString(),
                  'city': addressDetails['city'],
                  'street': addressDetails['street'],
                  'country': addressDetails['country'],
                });
              },
              backgroundColor: MyTheme.orangeColor,
              child: Icon(Icons.check, color: MyTheme.whiteColor),
            ),
    );
  }
}
