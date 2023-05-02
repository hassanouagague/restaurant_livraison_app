import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/alert_dialog.dart';
import 'package:get/get.dart';

import '../components/livraison/table_liv.dart';
import '../controller/livraison_controller.dart';
import '../theme/theme_colors.dart';
import '../theme/theme_text_style.dart';
import 'app.dart';

class LivraisonPre extends StatelessWidget {
  LivraisonPre({Key? key}) : super(key: key);
  final LivraisonController controller = Get.put(LivraisonController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> _onBackButtonPressed(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Précommande',style: TextStyle(color: Colors.grey[300]),),
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 78.h,
                ),
                Text(
                  'Livraison Précommande',
                  style: ThemeTextStyle().headingOne,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(child: Obx(() {
                  if (controller.livraisonConfirme.value.isEmpty &&
                      !controller.emtyPreCom.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.emtyPreCom.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Il ñ'y a pas de commande "),
                          ElevatedButton(
                              onPressed: () async {
                                //await controller.restarinst();
                                await controller.restarPre();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,),
                              child: Text("Réessayer"))
                        ],
                      ),
                    );
                  }
                  return TableLiv(
                    data: controller.livraisonConfirme.value,
                    onPressed: (int? index) {
                      controller.showDetailsPreCon(
                          context: context, index: index!);
                    },
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool action = await Get.offAll(App(pageindex: 2));
    return action;
  }
}
