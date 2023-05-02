import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_livraison_app/model/city.dart';
import 'package:food_livraison_app/model/user_model.dart';

// import 'package:form_data/form_data.dart';

import '../../constant/path.dart';

class UserService {
  Future<Map<String,dynamic>> register(UserModel user) async {
    var url = Uri.parse(user.toQueryParams());
    try {
      var response = await http.get(
        url,
      );

      if (response.statusCode >= 300) {
        return {"chek":false,"link":""} ;
      }

      Map data = json.decode(response.body) as Map;

      if (data["message"] == "register succed") {
        return {"chek":true,"link":data["link"]} ;
      }
       return {"chek":false,"link":""} ;
    } catch (e) {
       return {"chek":false,"link":""} ;
    }
  }

  Future<String> restPass(String email) async {
    var url = Uri.parse(Path.getpas);
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
      "type": "livreur",
      "email": email,
    };
    try {
      var response = await http.post(url, body: body);
      if (response.statusCode >= 300) {
        return "st";
      }

      var data = json.decode(response.body);

      if (data["message"] == "email non disponible") {
        return "nodis";
      }
      return "st";
    } catch (e) {
      print("erlogin$e");
      return "er";
    }
  }

  Future<UserModel> login(UserModel user) async {
    var url = Uri.parse(Path.login);
    late UserModel userFill;

    try {
      var response = await http.post(url, body: user.loginToJson());
      if (response.statusCode >= 300) {
        userFill = UserModel();
        userFill.et = false;
        userFill.message = "problem in server";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data["user"]["id"] != null) {
        userFill = UserModel.fromJson(data);
        userFill.et = true;
        userFill.message = "connected successfully";
        userFill.password = user.password;
        return userFill;
      }

      userFill = UserModel();
      userFill.et = false;
      userFill.message = data["message"];
      return userFill;
    } catch (e) {
      print("erlogin$e");
      userFill = UserModel();
      userFill.et = false;
      userFill.message = e.toString();
      return userFill;
    }
  }

  Future<UserModel> getUser(UserModel user) async {
    var url = Uri.parse(Path.getUser);
    late UserModel userFill;

    try {
      var response = await http.post(url, body: user.getuserToJson());
      if (response.statusCode >= 300) {
        userFill = UserModel();
        userFill.et = false;
        userFill.message = "null 400";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      

      if (data["data"]["id"] != null) {
        userFill = UserModel.getUserfromJson(data);

        userFill.et = true;
        userFill.message = "successfully";
        userFill.password = user.password;
        return userFill;
      }

      userFill = UserModel();
      userFill.et = false;
      userFill.message = " null id ";
      return userFill;
    } catch (e) {
      print("mstfg$e");
      userFill = UserModel();
      userFill.et = false;
      userFill.message = e.toString();
      return userFill;
    }
  }

  Future<List<City>> getCities() async {
    var url = Uri.parse(Path.getVilles);
    List<City> cityList = [];
    Map body = {
      "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
    };
    try {
      var response = await http.post(url, body: body);

      if (response.statusCode <= 300) {
        List data = json.decode(response.body) as List;

        for (var element in data) {
          cityList.add(City.fromJson(element));
        }
        return cityList;
      }
      return cityList;
    } catch (e) {
      print("Citys$e");
      return cityList;
    }
  }
}
