import 'package:geolocator/geolocator.dart';

Future<Position?> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are disabled, handle accordingly
    return null;
  }

  // Check if the app has permission to access the user's location
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    // The user has permanently denied location permission, handle accordingly
    return null;
  }

  if (permission == LocationPermission.denied) {
    // The user has denied location permission, request permission
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // The user has denied location permission, handle accordingly
      return null;
    }
  }

  // Get the user's current location
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return position;
}
