import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/storage_controller.dart';
import 'package:food_livraison_app/controller/user_controller.dart';
import 'package:food_livraison_app/model/reclamation.dart';
import 'package:food_livraison_app/service/api/reclamation_service.dart';
import 'package:food_livraison_app/view/profile/reclamation/add_reclamation.dart';

import '../components/dialoge.dart';
import '../model/user_model.dart';

class ReclamationController extends GetxController {
  RxList<ReclamationModel> allRec = <ReclamationModel>[].obs;
  UserModel user = UserModel();
  StorageController storageController = Get.put(StorageController());
  UserController userController = Get.put(UserController());
  RxBool isl = true.obs;
  
  List<String> allType = [
    "Cuisinière",
    "Client",
    "Service facturation",
    "Système"
  ];
  RxString type = "Service facturation".obs;
  String? titre;
  String? desc;
  
  String changeFrtoEn(String tp) {
    if ("Client" == type.value) {
      return "client";
    }
    if("Service facturation"== type.value){
       return "service facturation";
    }
    if("Système"== type.value){
       return "systeme";
    }
    return "cooker";
  }

  Future addReclamation(BuildContext context) async {
    Dialoge().showLoaderDialog(context);

    bool statu = await ReclamationService()
        .addRec(userId: user.id!, titre: titre!, desc: desc!, type:changeFrtoEn(type.value) );
    Get.back();
    if (statu) {
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Votre réclamation a été ajoutée avec succès',
        btnOkOnPress: () {
          debugPrint('OnClcik');
          Get.back();
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
          Get.back();
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: " Votre réclamation n'a pas été ajoutée ",
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkText: "Réessayer",
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }

  void hasData() {
    if (storageController.hasData(key: "user")) {
      user = UserModel.fromJsonlocal(storageController.getData(key: "user"));
      userController.isSignIn.value = true;
      update();
    } else {
      userController.isSignIn.value = false;
    }
  }

  Future<void> getAll() async {
    isl.value = true;
    allRec.value = await ReclamationService().getAll(user.id!);
    // print(allRec.value);
    isl.value = false;
  }

  changeType(String items) {
    type.value = items;
  }

  @override
  void onInit() async {
    print("getall");
    hasData();
    await getAll();

    super.onInit();
  }
}
