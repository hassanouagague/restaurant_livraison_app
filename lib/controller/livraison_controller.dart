import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/view/app.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app'
    '/controller/storage_controller.dart';
import 'package:food_livraison_app/controller/user_controller.dart';
import 'package:food_livraison_app/service/api/notification_service.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';
import 'package:food_livraison_app/theme/theme_text_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../constant/path.dart';

import '../components/dialoge.dart';
import '../components/input/constom_input.dart';
import '../model/Livraison.dart';
import '../model/notification.dart';
import '../model/position_model.dart';
import '../model/statistical/gain_st_model.dart';
import '../model/user_model.dart';
import '../service/api/geolocator_p.dart';
import '../service/api/livraisons_service.dart';
import '../service/api/luncher.dart';
import '../service/api/statistical_service.dart';
import '../service/api/user_service.dart';
import '../view/home.dart';
import 'storage_controller.dart';
import 'package:food_livraison_app/model/Livraison.dart';
import 'user_controller.dart';

class LivraisonController extends GetxController {
  RxString route = "home".obs;
  RxList<Livraison> livraisonpre = <Livraison>[].obs;
  RxList<Livraison> livraisonConfirme = <Livraison>[].obs;
  RxList<Livraison> livraisoninstCon = <Livraison>[].obs;
  RxList<Livraison> livraisoninst = <Livraison>[].obs;
  Rx<UserModel> user = UserModel().obs;
  StorageController storageController = Get.put(StorageController());
  UserController userController = Get.put(UserController());
  TextEditingController controllerone = TextEditingController();
  TextEditingController controllerTwo = TextEditingController();
  RxString nbrSign = "0".obs;
  RxString etat = "".obs;
  RxBool emtyPre = false.obs;
  RxBool emtyInst = false.obs;
  RxBool emtyInstCom = false.obs;
  RxBool emtyPreCom = false.obs;
  RxBool isloding = true.obs;
  RxInt gains = 0.obs;
  RxList<Notificationn> notification = <Notificationn>[].obs;
  String instNotif = "";
  String preNotif = "";


  void hasData() {
    if (storageController.hasData(key: "user")) {
      user.value =
          UserModel.fromJsonlocal(storageController.getData(key: "user"));

      userController.isSignIn.value = true;

      update();
    } else {
      userController.isSignIn.value = false;
      update();
    }
  }

  Future getUser() async {
   // print("ggg ${user.value.toString()}");

    UserModel us = await UserService().getUser(user.value);
   // print("fff$us");
    if (us.et!) {
      user.value.etat = us.etat;
      user.value.nbrSignal = us.nbrSignal;
      await storageController.updateData(
          data: user.value.toJson(), key: "user");
      us.etat == "0" ? etat.value = "Non vérifié" : etat.value = "Vérifié";
      nbrSign.value = us.nbrSignal ?? "0";

      update();
    }
  }

  Future getGains() async {
    GainStModel gainYear = await StatisticalService()
        .gains(etat: "Versé", by: "Year", userId: user.value.id);
    gains.value = 0;
    if (gainYear.stat!) {
      for (var item in gainYear.montant!) {
        gains.value += item;
      }
    }
  }

  Future getNotification() async {
    isloding.value = true;
    notification.value = await NotificationService().getAll(user.value.id!);
    isloding.value = false;
  }

  showDetailsPre({required BuildContext context, required int index}) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      title: 'No Header',
      body: Column(children: [
        const Text(
            "Remarque : Le service de localisation doit être activé pour pouvoir l'utiliser afin de déterminer votre destination.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distance :',
            ),
            Expanded(
              child: Text(
                "${livraisonpre.elementAt(index).distance} Km" ?? "",
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cout :',
            ),
            Expanded(
              child: Text(
                "${livraisonpre.elementAt(index).cout} €" ?? "",
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Durée :',
            ),
            Expanded(
              child: Text(
                  "${livraisonpre.elementAt(index).temps} Min" ?? "",
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de client :',
            ),
            Expanded(
              child: Text(
                livraisonpre.elementAt(index).addressClt ?? "",
              ),
            ),
            InkWell(
                onTap: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisonpre.elementAt(index).latCkr ?? "",
                      longDis: livraisonpre.elementAt(index).longCkr ?? "");
                },
                child: const Text(
                  "Trouver",
                  style: TextStyle(color: ThemeColors.primary,fontWeight: FontWeight.bold),
                ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de cooker :',
            ),
            Expanded(
              child: Text(
                livraisonpre.elementAt(index).addressCkr ?? "",
              ),
            ),
            InkWell(
                onTap: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisonpre.elementAt(index).latClt ?? "",
                      longDis: livraisonpre.elementAt(index).longClt ?? "");
                },
                child: const Text(
                  "Trouver",
                  style: TextStyle(color: ThemeColors.primary,fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ]),
      isDense: true,
      buttonsTextStyle: ThemeTextStyle().label,
      btnCancelOnPress: () async {
        debugPrint('OnClcik');
        await refuspre(index, context);
      },
      btnCancelText: "Refuser",
      btnOkText: "Confirmer",
      btnOkOnPress: () async {
        debugPrint('OnClcik');
        await confirmePre(index, context);
      },
    ).show();
  }

  showDetailsinst({required BuildContext context, required int index}) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      title: 'No Header',
      body: Column(
          children: [
        /*Row(
          children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Remarque : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Adresse de client :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Adresse de cooker :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: const Text("Le service de localisation doit être activé pour pouvoir l'utiliser afin de déterminer votre destination.")),
                Expanded(
                  child: Text(
                    livraisoninst.elementAt(index).addressClt!,
                  ),
                ),
                Expanded(
                  child: Text(
                    livraisoninst.elementAt(index).addressCkr!,
                  ),
                ),
              ],
            ),
          ],
        ),*/

        const Text(
            "Remarque : Le service de localisation doit être activé pour pouvoir l'utiliser afin de déterminer votre destination.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de client :',
            ),
            Expanded(
              child: Text(
                livraisoninst.elementAt(index).addressClt!,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de cooker :',
            ),
            Expanded(
              child: Text(
                livraisoninst.elementAt(index).addressCkr!,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Commande Nº : ${livraisoninst.elementAt(index).commandeId ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Code Cuisinier : ${livraisoninst.elementAt(index).codeCooker ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Cuisinier Téléphone :  ${livraisoninst.elementAt(index).telCkr ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Client Téléphone : ${livraisoninst.elementAt(index).telClt ?? ""}"),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Colors.red),
                onPressed: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisoninst.elementAt(index).latCkr,
                      longDis: livraisoninst.elementAt(index).longCkr);
                },
                child: Row(
                  children: [
                    const Icon(Icons.directions),
                    SizedBox(width: 4.w),
                    Text("ALLER A COOKER", style: ThemeTextStyle().butVer),
                  ],
                )),
            SizedBox(
              width: 13.w,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0XFF00CA71)),
                onPressed: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisoninst.elementAt(index).latClt,
                      longDis: livraisoninst.elementAt(index).longClt);
                },
                child: Row(
                  children: [
                    const Icon(Icons.directions),
                    SizedBox(width: 4.w),
                    Text("ALLER A CLIENT", style: ThemeTextStyle().butVer),
                  ],
                ))
          ],
        ),
        SizedBox(
          width: 13.w,
        ),
        livraisoninst.elementAt(index).etat != "Livrée"
            ? ConstomInput(
                title: "Code Suivi",
                controller: controllerone,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Divider(),
                  Text("LIVRAISON EFFECTUÉE", style: ThemeTextStyle().livVer),
                  const Divider(),
                ],
              )
      ]),
      isDense: true,
      buttonsTextStyle: ThemeTextStyle().label,

      btnOkText:
          livraisoninst.elementAt(index).etat != "Livrée" ? "Livrer" : null,

      btnOkOnPress: livraisoninst.elementAt(index).etat != "Livrée"
          ? () async {
       // print('TYPE INDEX ${livraisoninst.elementAt(index).idDetailsCommandes.runtimeType}');
              debugPrint('OnClcik');
              String check = await LivraisonsService().codesuivi(
                  cmdId: livraisoninst.elementAt(index).idDetailsCommandes,
                  userID: user.value.id ,
                  code: controllerone.text);
              //print(livraisoninst.elementAt(index).idDetailsCommandes);
              //print(controllerone.text);
              //print(check);
              dialogCheckCode(check, context);
              //
              //test ==> Get.to(livraisoninst);
              // test 2 ==> Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(builder: (BuildContext context) => LivraisonInst()),
        //               );
            }
          : null,
      // btnOkIcon: Icons.directions,
    ).show();
  }

  showDetailsPreCon({required BuildContext context, required int index}) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      title: 'No Header',
      body: Column(children: [
        const Text(
          "Remarque : Le service de localisation doit être activé pour pouvoir l'utiliser afin de déterminer votre destination.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de client :',
            ),
            Expanded(
              child: Text(
                livraisonConfirme.elementAt(index).addressClt!,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de cooker :',
            ),
            Expanded(
              child: Text(
                livraisonConfirme.elementAt(index).addressCkr!,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Code Cuisinier : ${livraisonConfirme.elementAt(index).codeCooker ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Cuisinier Téléphone :  ${livraisonConfirme.elementAt(index).telCkr ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Client Téléphone : ${livraisonConfirme.elementAt(index).telClt ?? ""}"),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Colors.red),
                onPressed: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisonConfirme.elementAt(index).latCkr,
                      longDis: livraisonConfirme.elementAt(index).longCkr);
                },
                child: Row(
                  children: [
                    const Icon(Icons.directions),
                    SizedBox(width: 4.w),
                    Text("ALLER A COOKER", style: ThemeTextStyle().butVer),
                  ],
                )),
            SizedBox(
              width: 13.w,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0XFF00CA71)),
                onPressed: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisonConfirme.elementAt(index).latClt,
                      longDis: livraisonConfirme.elementAt(index).longClt);
                },
                child: Row(
                  children: [
                    const Icon(Icons.directions),
                    SizedBox(width: 4.w),
                    Text("ALLER A CLIENT", style: ThemeTextStyle().butVer),
                  ],
                )),
          ],
        ),
        SizedBox(
          width: 13.w,
        ),
        livraisonConfirme.elementAt(index).etat != "Livrée"
            ? ConstomInput(
          title: "Code Suivi",
          controller: controllerTwo,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(),
            Text("LIVRAISON EFFECTUÉE", style: ThemeTextStyle().livVer),
            const Divider(),
          ],
        )
      ]),
      isDense: true,
      buttonsTextStyle: ThemeTextStyle().label,
      btnOkText:
      livraisonConfirme.elementAt(index).etat != "Livrée" ? " Livrer" : null,
      btnOkOnPress: livraisonConfirme.elementAt(index).etat != "Livrée"
          ? () async {
        // print(livraisonConfirme.elementAt(index).etat);
        String check = await LivraisonsService().codesuivi(
            cmdId: livraisonConfirme
                .elementAt(index)
                .idDetailsCommandes,
            userID: user.value.id,
            code: controllerTwo.text);
        print(controllerTwo.text);
        dialogCheckCode(check, context);
        //releod page confirmer
        //Get.to(Home);
        // test 2 ==> Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(builder: (BuildContext context) => LivraisonPre()),
        //               );

      }
          :null,
    ).show();
  }

  showDetailsInsCon({required BuildContext context, required int index}) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      title: 'No Header',
      body: Column(children: [
        const Text(
            "Remarque : Le service de localisation doit être activé pour pouvoir l'utiliser afin de déterminer votre destination.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de client :',
            ),
            Expanded(
              child: Text(
                livraisoninstCon.elementAt(index).addressClt!,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse de cooker :',
            ),
            Expanded(
              child: Text(
                livraisoninstCon.elementAt(index).addressCkr!,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Code Cuisinier : ${livraisoninstCon.elementAt(index).codeCooker ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Cuisinier Téléphone :  ${livraisoninstCon.elementAt(index).telCkr ?? ''}"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Client Téléphone : ${livraisoninstCon.elementAt(index).telClt ?? ""}"),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Colors.red),
                onPressed: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisonConfirme.elementAt(index).latCkr,
                      longDis: livraisonConfirme.elementAt(index).longCkr);
                },
                child: Row(
                  children: [
                    const Icon(Icons.directions),
                    SizedBox(width: 4.w),
                    Text("ALLER A COOKER", style: ThemeTextStyle().butVer),
                  ],
                )),
            SizedBox(
              width: 13.w,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0XFF00CA71)),
                onPressed: () async {
                  debugPrint('OnClcik');
                  await getPosition(
                      context: context,
                      latDis: livraisoninstCon.elementAt(index).latClt,
                      longDis: livraisoninstCon.elementAt(index).longClt);
                },
                child: Row(
                  children: [
                    const Icon(Icons.directions),
                    SizedBox(width: 4.w),
                    Text("ALLER A CLIENT", style: ThemeTextStyle().butVer),
                  ],
                )),
          ],
        ),
        SizedBox(
          width: 13.w,
        ),
        livraisoninstCon.elementAt(index).etat != "Livrée"
            ? ConstomInput(
                title: "Code Suivi",
                controller: controllerTwo,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Divider(),
                  Text("LIVRAISON EFFECTUÉE", style: ThemeTextStyle().livVer),
                  const Divider(),
                ],
              )
      ]),
      isDense: true,
      buttonsTextStyle: ThemeTextStyle().label,
      btnOkText:
      livraisoninstCon.elementAt(index).etat != "Livrée" ? " Livrer" : null,
      btnOkOnPress: livraisoninstCon.elementAt(index).etat != "Livrée"
          ? () async {
            // print(livraisonConfirme.elementAt(index).etat);
             String check = await LivraisonsService().codesuivi(
                 cmdId: livraisoninstCon
                     .elementAt(index)
                     .idDetailsCommandes,
                 userID: user.value.id,
                 code: controllerTwo.text);
             print(controllerTwo.text);
             dialogCheckCode(check, context);
        //releod page confirmer
             Get.to(Home);
        // test 2 ==> Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(builder: (BuildContext context) => LivraisonPre()),
        //               );

           }
           :null,
    ).show();
  }

  Future<void> getPosition(
      {required BuildContext context, String? latDis, String? longDis}) async {
    Dialoge().showLoaderDialog(context);
    PositionModel positionE = await GeolocatorP().determinePosition();
    if (!positionE.per!) {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: positionE.msg,
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      Position currentPostion = positionE.position!;
      String lat = currentPostion.latitude.toString();
      String long = currentPostion.longitude.toString();
      LauncherMap.openMap(
        livLat: lat,
        livLong: long,
        disLat: latDis,
        disLong: longDis,
      );
    }
  }

  Future confirmePre(int index, BuildContext context) async {
    String etat = await LivraisonsService()
        .confirmeCommande(livraisonpre.elementAt(index));
    await restarPreCo();
    if (etat == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Commande  a été effectuée',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: "Il ya un problème,Réessayer",
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

  Future confirmeIns(int index, BuildContext context) async {
    String etat = await LivraisonsService()
        .confirmeCommande(livraisoninstCon.elementAt(index));
    await restarinstcon();
    if (etat == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Commande  a été effectué',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: "Il ya un problème,Réessayer",
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

  Future refuspre(int index, BuildContext context) async {
    String etat =
        await LivraisonsService().refuseCommande(livraisonpre.elementAt(index));
    await restarPre();
    if (etat == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Commande a été refuseé',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      livraisonpre.value = await LivraisonsService().pre(user.value.id!);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: "Il ya un problème,Réessayer",
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

  Future restarPre() async {
    emtyPre.value = false;
    livraisonpre.value = [];
    livraisonpre.value = await LivraisonsService().pre(user.value.id!);
    if (livraisonpre.isEmpty) {
      emtyPre.value = true;
    }
    update();
  }

  Future restarinstcon() async {
    emtyInstCom.value = false;
    livraisoninstCon.value = [];
    livraisoninstCon.value = await LivraisonsService().livInsConfirm(user.value.id!,instNotif);

    if (livraisoninst.isEmpty) {
      emtyInstCom.value = true;
    }
    update();
  }

  Future restarinst() async {
    emtyInst.value = false;
    livraisoninst.value = [];
    livraisoninst.value = await LivraisonsService().inst(user.value.id!,instNotif);

    if (livraisoninst.isEmpty) {
      emtyInst.value = true;
    }
    update();
  }

  Future restarPreCo() async {
    emtyPreCom.value = false;
    livraisonConfirme.value = [];
    livraisonConfirme.value =
        await LivraisonsService().livPreConfirm(user.value.id!,preNotif);

    if (livraisonConfirme.isEmpty) {
      emtyPreCom.value = true;
    }
    update();
  }

  Future init() async {
    await restarPre();
    await restarinst();
    await restarPreCo();
    await restarinstcon();
    await getUser();
    await getGains();
    await getNotification();
  }

  handleAuthStatechanged(route) async {
    hasData();
    switch (route) {
      case "home":
        await restarPre();
        await restarinst();
        await getGains();
        await getNotification();
        break;
      case "inst":
        print("testint");
        await restarinst();
        break;
      case "precom":
        await restarPreCo();
        break;
      case "pro":
        await getUserUp();
        break;
      default:
        print("errrrrrrrrrrrrorrororoooror");
        break;
    }
  }



  getUserUp() async {
    UserModel us = await UserService().getUser(user.value);
    print("print");
    if (us.et!) {
      user.value.image = us.image ?? "";
      user.value.kbis = us.kbis ?? "";

      user.value.etat = us.etat;
      user.value.nom = us.nom;
      print("1print${us.image}");
      await storageController.updateData(
          data: user.value.toJson(), key: "user");
      update();
    }
  }

  dialogCheckCode(String statu, BuildContext context) {
    if (statu == "Code Confirmé") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Succès',
        desc: "Code Confirmé",
        btnOkOnPress: () {
          print('hhhik');
          //Get.to(Home);
          debugPrint('OnClcik');
          Get.offAll(App(pageindex: 0));
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => App(pageindex: 1,)),);
        },
        btnOkIcon: Icons.cancel,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: "Le code invalide",
        btnOkOnPress: () {
          debugPrint('OnClcikz');
          //Get.offAll(App(pageindex: 0));
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => App(pageindex: 0,)),);
          //Navigator.push( context, MaterialPageRoute( builder: (BuildContext context) => App(pageindex: 0)),);
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }

  /////////////////////////////////uplode//////////////////////////////////////
  FilePickerResult? resultp;
  FilePickerResult? resultk;

  getFilep() async {
    resultp = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    update();
  }

  getFilek() async {
    resultk = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    update();
  }

  uploadFileProfile() async {
    Dialoge().showLoaderDialog(Get.context!);
    print(resultp!.paths.first);

    File imagefile = File(resultp!.paths.first!); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes); //convert bytes to base64 string
    print("Code image => $base64string");


    var postUri =
        Uri.parse("https://repas-maison.com/MobileAppScript/user.php?type=updatelivreur");
    print("post url $postUri");
    var request = http.MultipartRequest("POST", postUri);
    request.fields['KEY'] = '5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg';
    request.fields['part'] = 'photo';
    request.fields['userID'] = user.value.id!;
    request.fields['extfile'] = 'jpg';
    request.fields['photo'] = "data:image/jpeg;base64,$base64string";


    var response = await request.send();
   // print(response);

    if (response.statusCode > 300) print('not Uploaded!');
    print("Response StatusCode ${response.statusCode}");
    if (response.statusCode == 200) print('Uploaded!');

     var resposedata = await response.stream.toBytes();
     var reslt = String.fromCharCodes(resposedata);
     print(reslt);
    //print("printentre interinerfunction");


    await getUserUp();
    Get.to(App(pageindex: 3));


  }

  uploadFileKbis() async {
    print("printrah");
    Dialoge().showLoaderDialog(Get.context!);

    File imagefile = File(resultk!.paths.first!); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string2 = base64.encode(imagebytes); //convert bytes to base64 string
    print("Code Kbis => $base64string2");

    var postUri =Uri.parse(Path.getUser);
        //Uri.parse("https://repas-maison.com/MobileAppScript/user.php?type=updatelivreur");

    print(postUri);
    var request = http.MultipartRequest("POST", postUri);
    request.fields['KEY'] =
        '5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg';
    request.fields['part'] = 'kbis';
    request.fields['userID'] = user.value.id!;
    request.fields['extfile'] = 'jpg';
    request.fields['kbis'] = "data:image/jpeg;base64,$base64string2";


    var response = await request.send();
    if (response.statusCode > 300) print('not Uploaded!');
    if (response.statusCode == 200) print('Uploaded!');
     var resposedata = await response.stream.toBytes();
     var reslt = String.fromCharCodes(resposedata);
    print(reslt);
    print("===============");
    await getUserUp();
    Get.back();
  }

  // getUserProfile() async {
  //   UserModel us = await UserService().getUser(user.value);

  //   if (us.et!) {
  //     user.value.image = us.image ?? "";
  //     user.value.etat = us.etat;
  //     user.value.nom = us.nom;
  //     print("print 1");
  //     await storageController.updateData(
  //         data: user.value.toJson(), key: "user");

  //     update();
  //   }
  // }

  // getUserKbis() async {
  //   UserModel us = await UserService().getUser(user.value);
  //   if (us.et!) {
  //     user.value.kbis = us.kbis ?? "";
  //     user.value.etat = us.etat;
  //     user.value.nom = us.nom;

  //     await storageController.updateData(
  //         data: user.value.toJson(), key: "user");
  //     update();
  //   }
  // }

  /////////////////////////////////////////////////////////////////////////////
  @override
  void onInit() async {
    hasData();
    await init();
    ever(route, handleAuthStatechanged);
    super.onInit();
  }
}
