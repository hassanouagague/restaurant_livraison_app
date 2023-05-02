import 'package:food_livraison_app/controller/login_controller.dart';
import 'package:food_livraison_app/view/auth/login.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/storage_controller.dart';

import '../controller/user_controller.dart';


class MyBin extends Bindings {
  @override
  void dependencies() {

    Get.put(UserController());
    Get.put(StorageController());

  }

}
