import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:food_livraison_app/model/reclamation.dart';
import 'package:food_livraison_app/model/reponse.dart';

import '../../constant/path.dart';
import '../../model/penalite.dart';
import '../../model/reglement.dart';

class ReclamationService {
  Future<List<ReclamationModel>> getAll(String userId) async {
    var url = Uri.parse(Path.getAllReclamation);
    List<ReclamationModel> rec = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "part": "getall"
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;
        print(data);
        for (var i = 0; i < data.length; i++) {
          
          rec.add(ReclamationModel.fromJson(data.elementAt(i)));
          rec.elementAt(i).reponse = await getRep(userId,rec.elementAt(i).id!);
        }

        return rec;
      }
      return rec;
    } catch (e) {
      print("regEror$e");
      return rec;
    }
  }

  Future<List<Reponse>> getRep(String userId, String reclamId) async {
    var url = Uri.parse(Path.getReponse);
    List<Reponse> rep = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "type": "listing",
      "reclamID": reclamId,
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          rep.add(Reponse.fromJson(element));
        }
        return rep;
      }
      return rep;
    } catch (e) {
      print("regEror$e");
      return rep;
    }
  }

  Future<bool> addRec(
      {required String userId,
      required String titre,
      required String desc,
      required String type}) async {
    var url = Uri.parse(Path.getAllReclamation);
    List<ReclamationModel> rec = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "part": "addreclam",
      "titre": titre,
      "type": type,
      "reclamation": desc
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        String data = json.decode(response.body);
        print("----------------------");
        print(data);
        if (data == "succed") {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print("recEror$e");
      return false;
    }
  }
//  "succed"
}
