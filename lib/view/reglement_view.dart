import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




import '../components/regelements_penalite/table_reg.dart';
import '../controller/reg_pen_controller.dart';
import '../theme/theme_colors.dart';
import '../theme/theme_text_style.dart';

class ReglementView extends StatelessWidget {
  ReglementView({Key? key}) : super(key: key);
  final RegPenController controller = Get.put(RegPenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          title: Text('Reglements'),
          backgroundColor: ThemeColors.primary,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Reglements',
                style: ThemeTextStyle().headingOne,
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(child: Obx(() {
                if (controller.reglement.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return TableReg(
                  notifId: Get.arguments,
                  data: controller.reglement,
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
