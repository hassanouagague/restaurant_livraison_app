import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/user_controller.dart';
import 'package:food_livraison_app/model/user_model.dart';

import '../components/dialoge.dart';
import '../model/statistical/gain_st_model.dart';
import '../service/api/statistical_service.dart';
import '../service/api/update_service.dart';
import 'storage_controller.dart';

class UpdateController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  String? password;
  String? passwordOne;
  String? passwordTwo;
  RxBool error = false.obs;
  RxBool obscur1 = false.obs;
  RxBool obscur2 = false.obs;
  RxString msg = "".obs;
  StorageController storageController = Get.put(StorageController());
  UserController userController = Get.put(UserController());
  //trasport // Initial Selected Value
  RxString dropdownvalue = 'Libre'.obs;
  
  // List of items in our dropdown menu
  List<String> items = [
    'Libre',
    'En route',
  ];

  void hasData() {
    if (storageController.hasData(key: "user")) {
      user.value =
          UserModel.fromJsonlocal(storageController.getData(key: "user"));
      user.value.transport == "1"
          ? dropdownvalue.value = 'Libre'
          : dropdownvalue.value = 'En route';
      userController.isSignIn.value = true;
      update();
    } else {
      userController.isSignIn.value = false;
    }
  }

  bool checkpassword() {
    if (password == "" || passwordOne == "" || passwordTwo == "") {
      error.value = false;
      msg.value = " l'entrée est vide";
      return error.value;
    }
    // l'entrée est vide
    if (password != user.value.password) {
      error.value = false;
      msg.value = "Mot de passe incorrect";

      return error.value;
    }

    if (passwordOne != passwordTwo) {
      error.value = false;
      msg.value = "Mot de passe ne pas identique";

      return error.value;
    }
    if (password == passwordOne) {
      error.value = false;
      msg.value = "Correspond à l'ancien mot de passe";

      return error.value;
    }
    error.value = true;
    msg.value = "";
    user.value.password = passwordOne;
    return error.value;
  }

  Future updatepass(context) async {
    Dialoge().showLoaderDialog(context);
    sleep(const Duration(milliseconds: 200));
    UserModel userGet = await UpdateService().pass(user.value);
    if (userGet.et!) {
      Get.back();

      await storageController.updateData(data: userGet.toJson(), key: "user");
      hasData();
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Le Mot de passe est modifie',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: userGet.message,
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }

  Future updateinfo(context) async {
    Dialoge().showLoaderDialog(context);
    sleep(const Duration(milliseconds: 200));
    UserModel userGet = await UpdateService().info(user.value);
    if (userGet.et!) {
      Get.back();

      await storageController.updateData(data: userGet.toJson(), key: "user");
      hasData();
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Mise à jour réussie',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: userGet.message,
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }

  Future updatetrsp(context, String? value) async {
    Dialoge().showLoaderDialog(context);

    String? t = value == 'Libre' ? "1" : "0";
    dropdownvalue.value = value!;
    user.value.transport = t;
    sleep(const Duration(milliseconds: 200));
    UserModel userGet = await UpdateService().transport(user.value);
    if (userGet.et!) {
      Get.back();

      await storageController.updateData(data: userGet.toJson(), key: "user");

      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        titleTextStyle: TextStyle(color: Colors.black),
        desc: 'Mise à jour réussie',
        descTextStyle: TextStyle(color: Colors.green),
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        titleTextStyle: TextStyle(color: Colors.black),
        desc: userGet.message,
        descTextStyle: TextStyle(color: Colors.red),
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }

  
  @override
  void onInit() async {
    hasData();

    
    super.onInit();
  }
}
