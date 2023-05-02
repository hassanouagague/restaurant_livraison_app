import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/statistique/penalite_char.dart';
import '../../../controller/statistical/pen_static_controller.dart';
import '../../../theme/theme_colors.dart';
import '../../../theme/theme_text_style.dart';

class PenaliteStatic extends StatelessWidget {
  PenaliteStatic({Key? key}) : super(key: key);
  final PenStaticController controller = Get.put(PenStaticController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.primary,
          ),
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),

                Text(
                  'Suivre tout pénalite',
                  style: ThemeTextStyle().headingOne,
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 100.w,
              ),
              Expanded(
                flex: 1,
                child: Obx(() {
                  return DropdownButton(
                    isDense: true,
                    // Initial Value
                    value: controller.by.value,
                    isExpanded: true,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: controller.items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) async {
                     
                      await controller.changeTypeBy(value);
                    },
                  );
                }),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 1,
                child: Obx(() {
                  return DropdownButton(
                    isDense: true,
                    // Initial Value
                    value: controller.etat.value,
                    isExpanded: true,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: controller.itemst.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) async {
                      await controller.changeEtat(value);
                    },
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Card(
            child: Obx(() {
              if (controller.penalite.value.somme != null &&
                  controller.islo.value) {

                  return PainaliteChar(
                    penalite: controller.penalite.value,
                    by: controller.by.value,
                    title: controller.penalite.value.monthName,
                  );

              }
              if (!controller.islo.value) {
                return PainaliteChar(
                    penalite: controller.penalite.value,
                    by: "Il n'y a pas de données");
              }
              return const SizedBox();
            }),
          ),
        ],
      )),
    );
  }
}
