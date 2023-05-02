import 'package:get/get.dart';

import '../../model/statistical/penalite_st_model.dart';
import '../../model/user_model.dart';
import '../../service/api/statistical_service.dart';
import '../storage_controller.dart';
import '../user_controller.dart';

class PenStaticController extends GetxController {
  Rx<PenaliteStModel> penalite = PenaliteStModel().obs;
  List<String> items = ["Jour", "Mois", "Année"];
  List<String> itemst = ["En cours", "Appliquée"];
  RxString by = "Jour".obs;
  RxString etat = "En cours".obs;
  RxBool islo = false.obs;
  UserModel user = UserModel();
  StorageController storageController = Get.put(StorageController());
  UserController userController = Get.put(UserController());

  String changeFrtoEn(String? type) {
    if (type == "Jour") {
      print("Day");
      return "Day";
    }
    if (type == "Mois") {
      print("Month");
      return "Month";
    }
    print("Year");
    return "Year";
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

  Future changeTypeBy(String? value) async {
    islo.value = false;
    by.value = value!;
    penalite.value = await StatisticalService()
        .penalite(etat: etat.value, by: changeFrtoEn(value), userId: user.id);
    if (penalite.value.stat!) {
      islo.value = true;
    }
  }

  Future changeEtat(String? value) async {
    islo.value = false;
    etat.value = value!;
    penalite.value = await StatisticalService().penalite(
        etat: etat.value, by: changeFrtoEn(by.value), userId: user.id);
    if (penalite.value.stat!) {
      islo.value = true;
    }
  }

  @override
  void onInit() async {
    hasData();
    penalite.value = await StatisticalService().penalite(
        etat: etat.value, by: changeFrtoEn(by.value), userId: user.id);
    if (penalite.value.stat!) {
      islo.value = true;
    }

    super.onInit();
  }
}
