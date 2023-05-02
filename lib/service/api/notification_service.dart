import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant/path.dart';
import '../../model/notification.dart';

class NotificationService {
  Future<List<Notificationn>> getAll(String userId) async {
    var url = Uri.parse(Path.getNot);
    List<Notificationn> not = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "type": "livreur"
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;

        for (var i = 0; i < data.length; i++) {
          not.add(Notificationn.fromJson(data.elementAt(i)));
        }

        return not;
      }
      return not;
    } catch (e) {
      return not;
    }
  }

  Future updateEtat(String userId, String notifId) async {
    var url = Uri.parse(Path.updateEtatNotif);
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "notifID": notifId
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        var data = json.decode(response.body);
        print("updatenotif${data}");
      }
    } catch (e) {
      print("updatenotif${e}");
    }
  }
}
