import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/model/user_model.dart';
import 'package:food_livraison_app/routes/route_constant.dart';
import 'package:food_livraison_app/service/api/user_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../components/dialoge.dart';
import '../view/auth/webviewscreen.dart';

class RegisterController extends GetxController {
  RxBool obscure = true.obs;
  UserModel user = UserModel();
  void changeObscure() {
    obscure.value = !obscure.value;
  }

  Future registre(BuildContext context) async {
    Dialoge().showLoaderDialog(context);
    sleep(const Duration(milliseconds: 200));
    Map<String, dynamic> etat = await UserService().register(user);

    // {"chek":true,"link":data["link"]}
    if (etat["chek"]) {
      print(etat["link"]);
      Get.back();
      Get.to(const WebViewScreen(), arguments: etat["link"]);
      // AwesomeDialog(
      //   context: context,
      //   animType: AnimType.LEFTSLIDE,
      //   headerAnimationLoop: false,
      //   dialogType: DialogType.SUCCES,
      //   showCloseIcon: true,
      //   title: 'Succès',
      //   desc: 'Votre compte a été enregistré Aller à la page connexion',
      //   btnOkOnPress: () {
      //     Get.toNamed(RouteConstant.login);
      //     debugPrint('OnClcik');
      //   },
      //   btnOkIcon: Icons.check_circle,
      //   onDismissCallback: (type) {
      //     debugPrint('Dialog Dissmiss from callback $type');
      //   },
      // ).show();
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc:
            'Il y a peut-être un problème avec la connexion ou Ce email est déjà utilisé. Essayez un autre addresse mail',
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
}
