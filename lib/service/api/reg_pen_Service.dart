import 'dart:convert';


import 'package:http/http.dart' as http;


import '../../constant/path.dart';
import '../../model/penalite.dart';
import '../../model/reglement.dart';


class RegPenService {
  Future<List<Reglement>> reg(String userId) async {
    var url = Uri.parse(Path.reg);
    List<Reglement> reg = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data =
            json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          reg.add(Reglement.fromJson(element));
        }
        return reg;
      }
      return reg;
    } catch (e) {
      print("regEror$e");
      return reg;
    }
  }
  Future<List<Penalite>> pen(String userId) async {
    var url = Uri.parse(Path.pen);
    List<Penalite> penalite = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data =
            json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          penalite.add(Penalite.fromJson(element));
        }
        return penalite;
      }
      return penalite;
    } catch (e) {
      print("liveeeeee$e");
      return penalite;
    }
  }
}
