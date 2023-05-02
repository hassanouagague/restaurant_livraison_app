import 'package:get/get.dart';
import 'package:food_livraison_app/controller/storage_controller.dart';
import 'package:food_livraison_app/controller/user_controller.dart';
import 'package:food_livraison_app/model/penalite.dart';
import 'package:food_livraison_app/model/reglement.dart';
import 'package:food_livraison_app/service/api/reg_pen_Service.dart';

import '../model/user_model.dart';



class RegPenController extends GetxController {
  RxList<Reglement> reglement = <Reglement>[].obs;
  RxList<Penalite> penalite = <Penalite>[].obs;
  // RxList<Livraison> livraisoninst = <Livraison>[].obs;
  UserModel user = UserModel();
  StorageController storageController = Get.put(StorageController());
  UserController userController = Get.put(UserController());

  void hasData() {
    if (storageController.hasData(key: "user")) {
      user = UserModel.fromJsonlocal(storageController.getData(key: "user"));
      userController.isSignIn.value = true;
      update();
    } else {
      userController.isSignIn.value = false;
    }
  }


  @override
  void onInit() async {
    hasData();
    print(user.id);
    reglement.value = await RegPenService().reg(user.id!);
    penalite.value = await RegPenService().pen(user.id!);
    super.onInit();
  }
}
