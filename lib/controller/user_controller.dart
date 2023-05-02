import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:food_livraison_app/components/dialoge.dart';

import 'package:food_livraison_app/controller/storage_controller.dart';
import 'package:food_livraison_app/model/user_model.dart';
import 'package:food_livraison_app/routes/route_constant.dart';

class UserController extends GetxController {
  //and controller spalsh page
  StorageController storageController = Get.put(StorageController());
  Timer? timer;
  RxInt start = 2.obs;
  RxBool isSignIn = false.obs;
  Rx<UserModel> user = UserModel().obs;
  handleAuthStatechanged(isSignIn) async {
    if (!isSignIn) {
      Get.offAllNamed(RouteConstant.app);
    } else {
      Get.offAllNamed(RouteConstant.login);
      await storageController.deleteData(key: "user");
    }
  }

  void hasData() {
    if (storageController.hasData(key: "user")) {
      user.value = UserModel.fromJsonlocal(storageController.getData(key: "user"));
      
      isSignIn.value = true;
    } else {
      isSignIn.value = false;
    }
  }

  Future logOut(BuildContext context) async {
    Dialoge().showLoaderDialog(context);
    await storageController.deleteData(key: "user");
    //hasData();
  }

  Future<void> pushHomeScreen() async {
    const oneSec = Duration(milliseconds: 900);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (start.value == 0) {
        timer.cancel();
        hasData();
      } else {
        start.value--;
      }
    });
  }

  @override
  void onReady() async {
    await GetStorage.init();
    pushHomeScreen();
    ever(isSignIn, handleAuthStatechanged);

    super.onReady();
  }
}
