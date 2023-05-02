import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/theme/theme_text_style.dart';

import '../alert_dialog.dart';
import '../controller/navigation_bar_controller.dart';
import '../controller/user_controller.dart';
import '../theme/theme_colors.dart';
import '../view/livraison_inst.dart';
import '../view/livraison_pre.dart';
import '../view/profile.dart';
import '../view/home.dart';

import '../controller/livraison_controller.dart';

class App extends StatelessWidget {
  App({Key? key, required this.pageindex}) : super(key: key);
  final NavigationBarController navigationBarController =
      Get.put(NavigationBarController());
  final UserController userController = Get.find();
  final LivraisonController controller = Get.put(LivraisonController());
  final int pageindex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      body: Obx(() {
       // if(pageindex!=null){
        //  navigationBarController.currentIndex.value=pageindex;
       // }

        if (navigationBarController.currentIndex.value == 3) {

          return Profile();
        }
        if (navigationBarController.currentIndex.value == 1) {
          return LivraisonInst();
        }
        if (navigationBarController.currentIndex.value == 2) {
          return LivraisonPre();
        }
        return Center(child: Home());
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavyBar(
          selectedIndex: navigationBarController.currentIndex.value,
          onItemSelected: (index) async {
            if (index == 0) {
              controller.instNotif = "";
              controller.route.value = "inst";
              controller.route.value = "home";
            }
            if (index == 1) {
              controller.instNotif = "";
              controller.route.value = "inst";
            }
            if (index == 2) {
              controller.route.value = "precom";
            }
            if (index == 3) {
              controller.route.value = "pro";
            }
            navigationBarController.currentIndex.value = index;
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: Text('Dashboard', style: ThemeTextStyle().labeltwo),
                icon: Icon(
                  Icons.home,
                  size: 20.r,
                  color: ThemeColors.primary,
                )),
            BottomNavyBarItem(
                title: Text('Instantanée', style: ThemeTextStyle().labeltwo),
                icon: Icon(Icons.all_inbox, size: 20.r,color: ThemeColors.primary,)),
            BottomNavyBarItem(
                title: Text('Précommande', style: ThemeTextStyle().labeltwo),
                icon: Icon(Icons.pending_actions, size: 20.r,color: ThemeColors.primary,)),
            BottomNavyBarItem(
                title: Text('Profile', style: ThemeTextStyle().labeltwo),
                icon: Icon(
                  Icons.person,
                  size: 20.r,
                  color: ThemeColors.primary,
                )),
          ],
        );
      }),
    ),
    );
  }
}
