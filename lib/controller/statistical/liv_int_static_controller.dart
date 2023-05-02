import 'package:get/get.dart';

import '../../model/statistical/liv_st_model.dart';
import '../../model/user_model.dart';
import '../../service/api/statistical_service.dart';
import '../storage_controller.dart';
import '../user_controller.dart';

class LivIntStaticController extends GetxController {
  Rx<LivStModel> liv = LivStModel().obs;
  List<String> items = ["Jour", "Mois", "Année"];
  List<String> itemst = ["All", "Livree"];
  RxString by = "Jour".obs;
  RxString etat = "All".obs;
  RxBool islo = false.obs;
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

  String changeFrtoEn(String? type) {
    if (type == "Jour") {
      //print("Day");
      return "Day";
    }
    if (type == "Mois") {
      //print("Month");
      return "Month";
    }
    //print("Year");
    return "Year";
  }

  Future changeTypeBy(String? value) async {
    islo.value = false;
    by.value = value!;
    liv.value = await StatisticalService()
        .livInt(etat: etat.value, by: changeFrtoEn(value), userId: user.id);
    if (liv.value.stat!) {
      islo.value = true;
    }
  }

  Future changeEtat(String? value) async {
    islo.value = false;
    etat.value = value!;
    liv.value = await StatisticalService()
        .livInt(etat: etat.value, by: changeFrtoEn(by.value), userId: user.id);
    if (liv.value.stat!) {
      islo.value = true;
    }
  }

  @override
  void onInit() async {
    hasData();
    liv.value = await StatisticalService()
        .livInt(etat: etat.value, by: changeFrtoEn(by.value), userId: user.id);
    //print(liv.value.nbr);
    if (liv.value.stat!) {
      islo.value = true;
    }
    // print(gain.value.monthName);
    super.onInit();
  }
}
