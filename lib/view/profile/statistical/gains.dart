import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/statistique/gain_char.dart';

import '../../../controller/statistical/gain_controller.dart';
import '../../../theme/theme_colors.dart';
import '../../../theme/theme_text_style.dart';

class Gains extends StatelessWidget {
  Gains({Key? key}) : super(key: key);
  final GainController controller = Get.put(GainController());

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
                  'Gains',
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
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 10,
            child: Obx(() {
              if (controller.gain.value.montant != null &&
                  controller.islo.value) {

                  return GainChar(
                    gain: controller.gain.value,
                    by: controller.by.value,
                    title: controller.gain.value.monthName,
                  );

              }
              if (!controller.islo.value) {
                return GainChar(
                    gain: controller.gain.value, by: "Il n'y a pas de données");
              }
              return const SizedBox();
            }),
          ),
        ],
      )),
    );
  }
}
