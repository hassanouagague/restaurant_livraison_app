import 'package:url_launcher/url_launcher.dart';

class LauncherMap {
  LauncherMap._();
// 
 static Future<void> openMap({String? livLat, String? livLong, String? disLat,String? disLong}) async {
    // String googleUrl =
    //     "https://www.google.com/maps/dir/?api=1&origin=33.55,-7.591995&destination=33.532148,-7.570044&travelmode=driving";
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$livLat,$livLong&destination=$disLat,$disLong&travelmode=driving';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
  // static Future<void> evaluer(String path) async {
  //   String googleUrl = path;
  //   if (await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     throw 'Could not google play.';
  //   }
  // }
}
// https://www.google.com/maps/dir/?api=1&origin=33.55,-7.591995&destination=33.532148,-7.570044&travelmode=driving