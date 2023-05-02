import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/alert_dialog.dart';
import 'package:food_livraison_app/view/app.dart';
import 'package:food_livraison_app/view/home.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/components/profile/panel.dart';
import 'package:food_livraison_app/routes/route_constant.dart';

import '../components/kbis_panel.dart';
import '../components/profile/avatar.dart';
import '../components/statistique/custombutton.dart';
import '../components/statistique/panel_statistique.dart';
import '../constant/icons/profile_icons.dart';
import '../controller/livraison_controller.dart';
import '../controller/user_controller.dart';
import '../theme/theme_colors.dart';
import 'profile/Statistical/gains.dart';
import 'profile/statistical/liv_int_static.dart';
import 'profile/statistical/liv_pre_static.dart';
import 'profile/statistical/penalite_static.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final UserController userController = Get.find();
  final LivraisonController controller = Get.put(LivraisonController());

  bool tappedYes =false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> _onBackButtonPressed(context),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Profile',style: TextStyle(color: Colors.grey[300]),),
          elevation: 5,
          backgroundColor: ThemeColors.primary,
          actions: <Widget>[

            IconButton(
                onPressed: ()async{
                  bool action = await AlertDialogs.yesCancelDialog(context, 'Se déconnecter', 'Êtes-vous sûr?');
                },
                icon: Icon(Icons.logout,size: 36.r, color:Colors.deepOrange[200])),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                GetBuilder<LivraisonController>(builder: (cont) {
                  return Avatar(
                    urlImage: cont.user.value.image ?? "",
                    etat: int.parse(cont.user.value.etat ?? "0"),
                    fullName: cont.user.value.nom,
                    onPressed: () async {
                      await cont.getFilep();
                      if (cont.resultp != null) {
                        await cont.uploadFileProfile();
                      }
                    },
                  );
                }),

                SizedBox(
                  height: 20.h,
                ),
                Panel(
                    title: "Mon compte",
                    imagePath: ProfileIcons.pencil,
                    onTap: () {
                      Get.toNamed(RouteConstant.info);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                Panel(
                    title: "Adresse Et Disponibilité",
                    imagePath: ProfileIcons.address,
                    onTap: () {
                      Get.toNamed(RouteConstant.workArea);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                Panel(
                    title: "Réglements",
                    imagePath: ProfileIcons.privite,
                    onTap: () {
                      Get.toNamed(RouteConstant.reglement);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                Panel(
                    title: "Pénalités",
                    imagePath: ProfileIcons.privite,
                    onTap: () {
                      Get.toNamed(RouteConstant.penalite);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                PanelStatistique(
                  title: "Statistiques",
                  imagePath: ProfileIcons.equalizer,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Custombutton(
                          title: "Gains",
                          onPressed: () {
                            Get.to(() => Gains());
                          },
                        ),
                        Custombutton(
                          title: "Pénalités",
                          onPressed: () {
                            Get.to(() => PenaliteStatic());
                          },
                        ),
                        Custombutton(
                          title: "Livraisons instantanées",
                          onPressed: () {
                            Get.to(() => LivIntStatic());
                          },
                        ),
                        Custombutton(
                          title: "Livraisons en précommande",
                          onPressed: () {
                            Get.to(() => LivPreStatic());
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Panel(
                    title: "Réclamations",
                    imagePath: ProfileIcons.rec,
                    onTap: () {
                      Get.toNamed(RouteConstant.reclamation);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                Panel(
                    title: "Changer Le Mot De Passe",
                    imagePath: ProfileIcons.pass,
                    onTap: () {
                      Get.toNamed(RouteConstant.pass);
                    }),
                SizedBox(
                  height: 12.h,
                ),
                GetBuilder<LivraisonController>(builder: (cont) {
                  return KbisPanel(
                    onPre: () async {
                      await cont.getFilek();
                      if (cont.resultk != null) {
                        await cont.uploadFileKbis();
                        //Get.to(App(pageindex: 3));
                      }
                    },
                    //change file
                    imagePath: ProfileIcons.file,
                    fileName: cont.user.value.kbis ?? "",
                    title: "Kbis",
                    etatkbis: cont.user.value.etatKbis ??"" ,
                  );
                }),


                // CHANGER LE MOT DE PASSE
                Panel(
                    title: "Déconnexion",
                    imagePath: ProfileIcons.logOut,
                    onTap: () async{
                      bool action = await AlertDialogs.yesCancelDialog(context, 'Se déconnecter', 'Êtes-vous sûr?');
                      // userController.logOut(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool action = await Get.offAll(App(pageindex: 3));
    return action;
  }
}
