import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class SecurityProvider extends ChangeNotifier {
  SecurityProvider() {
    askGpsandSmss();
  }
  LatLng _userPosition = const LatLng(0.0, 0.0);

  bool permisionIsGranted = false;

  LatLng get userPosition => _userPosition;
  set userPosition(LatLng value) {
    _userPosition = value;
    notifyListeners();
  }

  Future<void> askGpsandSmss() async {
    final status = await Permission.location.request();
    await Permission.sms.request();
    await Permission.contacts.request();

    switch (status) {
      case PermissionStatus.granted:
        permisionIsGranted = true;
        getUserPosition();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        permisionIsGranted = false;
        openAppSettings();
    }
  }

  Future<void> getUserPosition() async {
    final locator = await Geolocator.getCurrentPosition();
    userPosition = LatLng(locator.latitude, locator.longitude);
  }
}
