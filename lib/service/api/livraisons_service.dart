import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant/path.dart';
import '../../model/Livraison.dart';

class LivraisonsService {
  Future<List<Livraison>> pre(String userId) async {
    var url = Uri.parse(Path.pre);
    List<Livraison> livpre = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          livpre.add(Livraison.fromJson(element));
        }
        return livpre;
      }
      return livpre;
    } catch (e) {
      print("liveeeeee$e");
      return livpre;
    }
  }

  Future<List<Livraison>> inst(String userId, String notif) async {
    var url = Uri.parse(Path.inst);
    List<Livraison> livpre = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          if (notif == element['id']) {
            Livraison test = Livraison.fromJson(element);
            test.notif = true;
            livpre.add(test);
          }else{
            livpre.add(Livraison.fromJson(element));
          }
          
        }
        return livpre;
      }
      return livpre;
    } catch (e) {
      print("liveeeeee$e");
      return livpre;
    }
  }

  Future<List<Livraison>> livInsConfirm(String userId, String notif) async {
    var url = Uri.parse(Path.instCon);
    print("0000wowoow");
    List<Livraison> livinst = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId
    };

    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          if (notif == element['id']) {
            Livraison test = Livraison.fromJson(element);
            test.notif = true;
            livinst.add(test);
          }else{
            livinst.add(Livraison.fromJson(element));
          }

        }
        return livinst;
      }
      return livinst;
    } catch (e) {
      print("liveeeeee$e");
      return livinst;
    }
  }

  Future<List<Livraison>> livPreConfirm(String userId, String notif) async {
    var url = Uri.parse(Path.livpreconfirm);
    List<Livraison> livpre = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;
        print(data);
        for (var element in data) {
          if (notif == element['id']) {
            Livraison test = Livraison.fromJson(element);
            test.notif = true;
            livpre.add(test);
          }else{
            livpre.add(Livraison.fromJson(element));
          }
          
        }
        return livpre;
      }
      return livpre;
    } catch (e) {
      print("liveeeeee$e");
      return livpre;
    }
  }

  Future<String> confirmeCommande(Livraison livraison) async {
    var url = Uri.parse(Path.confirme);

    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": livraison.livreurId,
      "cmdID": livraison.id,
      "adresseID": livraison.adresseCltid
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        String data = json.decode(response.body);
        print(data);
        return data;
      }
      return "no action";
    } catch (e) {
      print("liveeeeee$e");
      return e.toString();
    }
  }

  Future<String> codesuivi(
      {String? cmdId, String? userID, String? code}) async {
    var url = Uri.parse(Path.codeSuivi);

    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userID,
      "dcmdID": cmdId,
      "code": code
    };

    try {
      var response = await http.post(url, body:body);

      if (response.statusCode <= 300) {
        Map data = json.decode(response.body);
        return data["message"];
      }
      return "sr";
    } catch (e) {
      print("liveeeeee$e");
      return "sr";
    }
  }

  Future<String> refuseCommande(Livraison livraison) async {
    var url = Uri.parse(Path.refuse);

    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": livraison.livreurId,
      "cmdID": livraison.id,
      "adresseID": livraison.adresseCltid
    };

    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        String data = json.decode(response.body);
        return data;

      }
      return "no action";
    } catch (e) {
      print("liveeeeee$e");
      return e.toString();
    }
  }
}
