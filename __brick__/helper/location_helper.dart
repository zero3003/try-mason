import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

Future<dynamic> getCurrentLocation() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}

getPlacemark(LocationData loc) async {
  List<geo.Placemark> _placemarks = await geo.placemarkFromCoordinates(loc.latitude ?? 0, loc.longitude ?? 0);
  return _placemarks;
}
