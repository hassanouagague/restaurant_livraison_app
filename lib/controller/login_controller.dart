import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:food_livraison_app/view/app.dart';
import 'package:food_livraison_app/view/home.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/storage_controller.dart';
import 'package:food_livraison_app/controller/user_controller.dart';
import 'package:food_livraison_app/model/user_model.dart';
import 'package:food_livraison_app/service/api/user_service.dart';

import '../components/dialoge.dart';
import '../view/profile.dart';

class LoginController extends GetxController {
  RxBool obscure = true.obs;
  UserModel user = UserModel();
  UserModel userFile = UserModel();
  StorageController storageController = Get.find();
  UserController userController = Get.find();
  TextEditingController controller = TextEditingController();
  RxBool val = false.obs;
  void changeObscure() {
    obscure.value = !obscure.value;
  }

  Future login(BuildContext context) async {
    Dialoge().showLoaderDialog(context);
    sleep(const Duration(milliseconds: 200));
    userFile = await UserService().login(user);
    print("hellosdd");
    print(userFile.toJson());
    print(userFile.message);
    if (userFile.message == "connected successfully") {
      print("????"+userFile.message.toString());
      storageController.setData(data: userFile.toJson(), key: "user");
      userController.hasData();
      Get.offAll(App(pageindex: 0));
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc:
            'Vérifiez que l\'e-mail ou le mot de passe que vous avez entré est correct',
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

  Future restpass(BuildContext context) async {
    if (controller.text.isEmpty) {
      AwesomeDialog(
              context: context,
              headerAnimationLoop: false,
              dialogType: DialogType.ERROR,
              desc: "Valeur saisie être vide",
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              btnOkColor: Colors.red)
          .show();
    } else {
     
      val.value = false;
      Dialoge().showLoaderDialog(context);
      String check = await UserService().restPass(controller.text);

      if (check == "st") {
        Get.back();
        controller.text = "";
        AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          desc: 'Vous recevrez le nouveau mot de passe par email',
          btnOkOnPress: () {
            debugPrint('OnClcik');
          },
          btnOkIcon: Icons.check_circle,
        ).show();
      }
      if (check == "nodis") {
        Get.back();

        AwesomeDialog(
                context: context,
                headerAnimationLoop: false,
                dialogType: DialogType.ERROR,
                desc: "Cet email n'existe pas dans la base de données",
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                btnOkColor: Colors.red)
            .show();
      }
    }
  }

  Future loginC() async {
    userFile = await UserService().login(user);
    if (userFile.message == "connected successfully") {
      storageController.setData(data: userFile.toJson(), key: "user");
      userController.hasData();
    } else {}
  }
}
