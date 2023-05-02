import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/alert_dialog.dart';
import 'package:food_livraison_app/view/app.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/update_controller.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';

import '../components/home/panel_livraison.dart';
import '../components/livraison/table_liv.dart';


import '../components/profile/avatar_2.dart';
import '../constant/icons/profile_icons.dart';
import '../controller/livraison_controller.dart';

import '../controller/navigation_bar_controller.dart';

import '../routes/route_constant.dart';
import '../service/api/notification_service.dart';
import '../theme/theme_text_style.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final UpdateController controller = Get.put(UpdateController());
  final NavigationBarController navigationBarController =
      Get.put(NavigationBarController());
  final LivraisonController livraisonController =
      Get.put(LivraisonController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> _onBackButtonPressed(context),
      child: Scaffold(
        key: _scaffoldkey,
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0.w),
                      padding: EdgeInsets.fromLTRB(16.0.w, 16.0.h, 16.0.w, 8.0.h),
                      decoration: BoxDecoration(color: ThemeColors.primary),
                      child: Text(
                        "Notifications",
                        style: ThemeTextStyle().drwerTitle,
                      ),
                    ),
                    Obx(() {
                      if (livraisonController.isloding.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: livraisonController.notification.map((element) {
                          return element.etat != "vu"
                              ? InkWell(
                                  onTap: () {
                                    if (element.typeNotif! == "livraison") {
                                      _scaffoldkey.currentState!.closeDrawer();
                                      livraisonController.instNotif =
                                          element.typeId ?? "";
                                      livraisonController.route.value = "inst";
                                      navigationBarController.currentIndex.value =
                                          1;
                                      NotificationService().updateEtat(
                                          livraisonController.user.value.id!,
                                          element.id!);
                                    }
                                    if (element.typeNotif! == "adresse") {
                                      _scaffoldkey.currentState!.closeDrawer();
                                      livraisonController.preNotif =
                                          element.typeId ?? "";
                                      livraisonController.route.value = "precom";
                                      navigationBarController.currentIndex.value =
                                          2;
                                      NotificationService().updateEtat(
                                          livraisonController.user.value.id!,
                                          element.id!);
                                    }
                                    if (element.typeNotif! == "reclamation") {
                                      _scaffoldkey.currentState!.closeDrawer();
                                      Get.toNamed(RouteConstant.reclamation,
                                          arguments: livraisonController
                                              .instNotif = element.typeId ?? "");
                                      NotificationService().updateEtat(
                                          livraisonController.user.value.id!,
                                          element.id!);
                                    }
                                    if (element.typeNotif! == "paiement") {
                                      _scaffoldkey.currentState!.closeDrawer();
                                      Get.toNamed(RouteConstant.reglement,
                                          arguments: livraisonController
                                              .instNotif = element.typeId ?? "");
                                      NotificationService().updateEtat(
                                          livraisonController.user.value.id!,
                                          element.id!);
                                    }
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black12))),
                                    child: ListTile(
                                      title: Text(
                                          element.typeNotif!,
                                          style: const TextStyle(color: Colors.black)),
                                      subtitle: Text(
                                        element.msg!,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }).toList(),
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: ThemeColors.primary,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            child: Center(
              child: Stack(alignment: Alignment.bottomRight, children: [
                Icon(Icons.notifications, size: 36.r, color: Colors.grey[300]),
                Container(
                    height: 15.h,
                    width: 15.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Obx(() {
                      return Text(
                          livraisonController.notification.value.length.toString(),
                          style: TextStyle(fontSize: 13.sp));
                    })),
              ]),
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: ()async{
                  bool action = await AlertDialogs.yesCancelDialog(context, 'Se déconnecter', 'Êtes-vous sûr?');
            },
                icon: Icon(Icons.logout,size: 36.r, color:Colors.deepOrange[200])),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(6.0)),
                          elevation: 10,
                          color: Colors.white,
                          child: SizedBox(
                            height: 150,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  GetBuilder<LivraisonController>(builder: (cont) {
                                    return AvatarTwo(
                                      urlImage: cont.user.value.image ?? "",
                                      etat: int.parse(cont.user.value.etat ?? "0"),
                                      fullName: cont.user.value.nom,

                                      onPressed: ()  {
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(6.0)),
                          elevation: 10,
                          color: Colors.white,
                          child: SizedBox(
                            height: 150,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Nombre Signalé",
                                        style: ThemeTextStyle().title2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GetBuilder<LivraisonController>(builder: (controller) {
                                        return Text(
                                          controller.nbrSign.value,
                                          style: ThemeTextStyle().body4,
                                        );
                                      }),
                                    ],),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        " Gains ",
                                        style: ThemeTextStyle().title2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() {
                                        return Text(
                                          "${livraisonController.gains.value}€",
                                          style: ThemeTextStyle().body4,
                                        );
                                      }),
                                    ],
                                  ),
                                 // SizedBox(height: 8.h,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),
                  Card(
                    shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(6.0)),
                    elevation: 10,
                    color: Colors.white,
                    child: SizedBox(
                      height: 60.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Disponibilité : ',
                              style: ThemeTextStyle().title,
                            ),
                            SizedBox(width: 60,),
                            Expanded(
                              child: Obx(() {
                                return DropdownButton(
                                  isDense: true,
                                  // Initial Value
                                  value: controller.dropdownvalue.value,
                                  isExpanded: true,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 28,

                                  // Array list of items
                                  items: controller.items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: TextStyle(color: Colors.black),),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) async {
                                    await controller.updatetrsp(context, value);
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  PanelLivraison(
                    title: "Livraison Précommande",
                    imagePath: ProfileIcons.ordered,
                    onTap: () {
                       Get.toNamed(RouteConstant.livraisonPre);
                    },
                    child: Expanded(child: Obx(() {
                      if (livraisonController.livraisonpre.value.isEmpty &&
                          !livraisonController.emtyPre.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (livraisonController.emtyPre.value) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Il ñ'y a pas de commande "),
                            ElevatedButton(
                                onPressed: () async {
                                  await livraisonController.restarPre();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,),
                                child: Text("Réessayer"))
                          ],
                        );
                      }
                      return TableLiv(
                        data: livraisonController.livraisonpre,
                        onPressed: (int? index) {
                          livraisonController.showDetailsPre(
                              context: context, index: index!);
                        },
                      );
                    })),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  PanelLivraison(
                    title: "Livraisons instantanées",
                    imagePath: ProfileIcons.ordered,
                    onTap: () {
                      Get.toNamed(RouteConstant.livraisonInst);
                    },
                    child: Expanded(child: Obx(() {
                      if (livraisonController.livraisoninst.isEmpty &&
                          !livraisonController.emtyInst.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (livraisonController.emtyInst.value) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Il ñ'y a pas de commande "),
                            ElevatedButton(
                                onPressed: () async {
                                  await livraisonController.restarinst();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,),
                                child: Text("Réessayer"),)
                          ],
                        );
                      }

                      return TableLiv(
                        data: livraisonController.livraisoninst,
                        onPressed: (int? index) {
                          print(index);
                          livraisonController.showDetailsinst(
                              context: context, index: index!);
                        },
                      );

                    })),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            )),
      ),
    );
  }
  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool action = await AlertDialogs.yesCancelDialog(context, 'Se déconnecter', 'Êtes-vous sûr?');
    return action;
  }
}
