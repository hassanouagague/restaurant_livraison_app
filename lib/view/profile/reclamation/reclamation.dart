import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/routes/route_constant.dart';

import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../../components/profile/reclamation_table.dart';
import '../../../controller/reclamation_controller.dart';
import '../../../theme/theme_text_style.dart';

class Reclamation extends StatelessWidget {
  Reclamation({Key? key}) : super(key: key);
  final ReclamationController controller = Get.put(ReclamationController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Réclamation'),
            backgroundColor: ThemeColors.primary,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(RouteConstant.addReclamation);
            },
            backgroundColor: ThemeColors.primary,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Réclamation',
                        style: ThemeTextStyle().headingOne,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Obx(() {
                        if (controller.isl.value && controller.allRec.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!controller.isl.value &&
                            controller.allRec.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Il ñ'y a pas de reclamation "),
                                ElevatedButton(
                                    onPressed: () async {
                                      await controller.getAll();
                                    },
                                    child: Text("Réessayer"))
                              ],
                            ),
                          );
                        }
                        return ReclamationTable(
                          notifId: Get.arguments,
                          allReclamation: controller.allRec.value,
                        );
                      }),
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  )))),
    );
  }
}
