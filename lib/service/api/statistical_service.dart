import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant/path.dart';

import '../../model/statistical/gain_st_model.dart';
import '../../model/statistical/liv_st_model.dart';
import '../../model/statistical/penalite_st_model.dart';

class StatisticalService {
  Future<GainStModel> gains(
      {required String etat, required String by, String? userId}) async {
    var url = Uri.parse(Path.statistiques);
    print("--------------------------");
    print(by);
    print("--------------------------");
    GainStModel gain = GainStModel();
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "TypStat": "GainLivreur",
      "etat": etat,
      "by": by
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;

        //
        if (data.isNotEmpty) {
          List<Map> dataF = [];
          for (Map element in data) {
            dataF.add(element);
          }
          if (by == "Day") {
            gain = GainStModel.fromJsonListDay(dataF);
          }
          if (by == "Month") {
            gain = GainStModel.fromJsonListMonth(dataF);
          }
          if (by == "Year") {
            gain = GainStModel.fromJsonListYear(dataF);
          }
          gain.stat = true;
          return gain;
        } else {
          gain.stat = false;
          return gain;
        }
      }
      gain.stat = false;
      return gain;
    } catch (e) {
      print(e);
      gain.stat = false;
      return gain;
    }
  }

  Future<PenaliteStModel> penalite(
      {required String etat, required String by, String? userId}) async {
    var url = Uri.parse(Path.statistiques);

    PenaliteStModel penalit = PenaliteStModel();
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "TypStat": "Penalites",
      "etat": etat,
      "by": by
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;

        //
        if (data.isNotEmpty) {
          List<Map> dataF = [];
          for (Map element in data) {
            dataF.add(element);
          }
          if (by == "Day") {
            penalit = PenaliteStModel.fromJsonListDay(dataF);
          }
          if (by == "Month") {
            penalit = PenaliteStModel.fromJsonListMonth(dataF);
          }
          if (by == "Year") {
            penalit = PenaliteStModel.fromJsonListYear(dataF);
          }
          penalit.stat = true;
          return penalit;
        } else {
          penalit.stat = false;
          return penalit;
        }
      }
      penalit.stat = false;
      return penalit;
    } catch (e) {
      print(e);
      penalit.stat = false;
      return penalit;
    }
  }

  Future<LivStModel> livInt(
      {required String etat, required String by, String? userId}) async {
    var url = Uri.parse(Path.statistiques);
    ;
    LivStModel livStModel = LivStModel();
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "TypStat": "CmdInst",
      "etat": etat,
      "by": by
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;

        //
        if (data.isNotEmpty) {
          List<Map> dataF = [];
          for (Map element in data) {
            dataF.add(element);
          }
          print(dataF);
          if (by == "Day") {
            livStModel = LivStModel.fromJsonListDay(dataF);
          }
          if (by == "Month") {
            livStModel = LivStModel.fromJsonListMonth(dataF);
          }
          if (by == "Year") {
            livStModel = LivStModel.fromJsonListYear(dataF);
          }
          livStModel.stat = true;
          return livStModel;
        } else {
          livStModel.stat = false;
          return livStModel;
        }
      }
      livStModel.stat = false;
      return livStModel;
    } catch (e) {
      print(e);
      livStModel.stat = false;
      return livStModel;
    }
  }

  Future<LivStModel> livPre(
      {required String etat, required String by, String? userId}) async {
    var url = Uri.parse(Path.statistiques);
    ;

    LivStModel livStModel = LivStModel();
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "userID": userId,
      "TypStat": "CmdPre",
      "etat": etat,
      "by": by
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;

        //
        if (data.isNotEmpty) {
          List<Map> dataF = [];
          for (Map element in data) {
            dataF.add(element);
          }

          print("pre$dataF");
          // print();
          if (by == "Day") {
            livStModel = LivStModel.fromJsonListDay(dataF);
          }
          if (by == "Month") {
            livStModel = LivStModel.fromJsonListMonth(dataF);
          }
          if (by == "Year") {
            livStModel = LivStModel.fromJsonListYear(dataF);
          }
          livStModel.stat = true;
          return livStModel;
        } else {
          livStModel.stat = false;
          return livStModel;
        }
      }
      livStModel.stat = false;
      return livStModel;
    } catch (e) {
      print(e);
      livStModel.stat = false;
      return livStModel;
    }
  }
  //
}
