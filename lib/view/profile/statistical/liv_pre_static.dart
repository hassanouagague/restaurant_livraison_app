import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/statistique/liv_char.dart';
import '../../../controller/statistical/liv_pre_static_controller.dart';
import '../../../theme/theme_colors.dart';
import '../../../theme/theme_text_style.dart';

class LivPreStatic extends StatelessWidget {
  LivPreStatic({Key? key}) : super(key: key);
  final LivPreStaticController controller = Get.put(LivPreStaticController());

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
                  'Livraisons en Précommande test',
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
                      print(value);
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
          Obx(() {
            if (controller.liv.value.nbr != null && controller.islo.value) {
              return LivChar(
                liv: controller.liv.value,
                by: controller.by.value,
                title: controller.liv.value.monthName,
              );
            }
            if (!controller.islo.value) {
              return LivChar(
                  liv: controller.liv.value, by: "Il n'y a pas de données");
            }
            return const SizedBox();
          }),
        ],
      )),
    );
  }
}
