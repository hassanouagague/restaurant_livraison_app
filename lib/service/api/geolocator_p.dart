import 'package:geolocator/geolocator.dart';

import '../../model/position_model.dart';

class GeolocatorP {
  Future<PositionModel> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    PositionModel position = PositionModel();
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      position.per = false;
      position.msg = "Les services de localisation (GPS) sont désactivés.";
      return position;
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        position.per = false;
        position.msg = "Les autorisations de localisation sont refusées.";
        return position;
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      position.per = false;
      position.msg =
          "Les autorisations de localisation sont définitivement refusées, nous ne pouvons pas demander d'autorisations.";
      return position;
    }
    position.per = true;
    position.msg = "";
    position.position = await Geolocator.getCurrentPosition();
    return position;
  }
}
