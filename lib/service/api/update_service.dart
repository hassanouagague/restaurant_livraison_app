import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:food_livraison_app/model/user_model.dart';
import 'package:food_livraison_app/view/home.dart';

import '../../constant/path.dart';
import '../../model/check_error.dart';

class UpdateService {
  Future<UserModel> info(UserModel user) async {
    var url = Uri.parse(Path.updatelivreur);
    late UserModel userFill;
    try {
      var response = await http.post(url, body: user.infoToJson());
      if (response.statusCode >= 300) {
        userFill = user;
        userFill.et = false;
        userFill.message = "problem in server";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data["error"]) {
        userFill = user;
        userFill.et = true;
        userFill.message = data["message"];
        return userFill;
      }

      userFill = user;
      userFill.et = data["error"];
      userFill.message = data["message"];
      return userFill;
    } catch (e) {
      userFill = user;
      userFill.et = false;
      userFill.message = e.toString();
      return userFill;
    }
  }

  Future<UserModel> pass(UserModel user) async {
    var url = Uri.parse(Path.updatelivreur);
    late UserModel userFill;
    try {
      var response = await http.post(url, body: user.passToJson());
      if (response.statusCode >= 300) {
        userFill = user;
        userFill.et = false;
        userFill.message = "problem in server";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data["error"]) {
        userFill = user;
        userFill.et = true;
        userFill.message = data["message"];
        return userFill;
      }

      userFill = user;
      userFill.et = data["error"];
      userFill.message = data["message"];
      return userFill;
    } catch (e) {
      userFill = user;
      userFill.et = false;
      userFill.message = e.toString();
      return userFill;
    }
  }

  Future<UserModel> addresse(UserModel user) async {
    var url = Uri.parse(Path.updatelivreur);
    late UserModel userFill;
    try {
      var response = await http.post(url, body: user.adresseToJson());
      if (response.statusCode >= 300) {
        userFill = user;
        userFill.et = false;
        userFill.message = "problem in server";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data["error"]) {
        userFill = user;
        userFill.et = true;
        userFill.message = data["message"];
        return userFill;
      }

      userFill = user;
      userFill.et = data["error"];
      userFill.message = data["message"];
      return userFill;
    } catch (e) {
      userFill = user;
      userFill.et = false;
      userFill.message = e.toString();
      return userFill;
    }
  }

  Future<UserModel> transport(UserModel user) async {
    var url = Uri.parse(Path.updatelivreur);
    late UserModel userFill;
    try {
      var response = await http.post(url, body: user.traspToJson());
      if (response.statusCode >= 300) {
        userFill = user;
        userFill.et = false;
        userFill.message = "problem in server";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data["error"]) {
        userFill = user;
        userFill.et = true;
        userFill.message = data["message"];
        return userFill;
      }

      userFill = user;
      userFill.et = data["error"];
      userFill.message = data["message"];
      return userFill;
    } catch (e) {
      userFill = user;
      userFill.et = false;
      userFill.message = e.toString();
      print("eupdatetra$e");
      return userFill;
    }
  }

  Future<UserModel> Disponib(UserModel user, String date) async {
    var url = Uri.parse(Path.updatelivreur);
    late UserModel userFill;
    try {
      var response = await http.post(url, body: user.disponibiliteToJson(date));
      if (response.statusCode >= 300) {
        userFill = user;
        userFill.et = false;
        userFill.message = "problem in server";
        return userFill;
      }

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data["error"]) {
        userFill = user;
        userFill.et = true;
        userFill.message = data["message"];
        return userFill;
      }

      userFill = user;
      userFill.et = data["error"];
      userFill.message = data["message"];
      return userFill;
    } catch (e) {
      userFill = user;
      userFill.et = false;
      userFill.message = e.toString();
      return userFill;
    }
  }

  Future<String?> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();

    return res.reasonPhrase;
  }
}
