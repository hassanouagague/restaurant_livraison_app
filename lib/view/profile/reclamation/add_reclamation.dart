import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../../components/input/constom_input.dart';
import '../../../components/profile/reclamation_table.dart';
import '../../../components/regelements_penalite/constom_input.dart';
import '../../../controller/reclamation_controller.dart';
import '../../../theme/theme_text_style.dart';

class AddReclamation extends StatelessWidget {
  AddReclamation({Key? key}) : super(key: key);
  final ReclamationController controller = Get.put(ReclamationController());

  final GlobalKey<FormState> _reclamationKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Form(
        key: _reclamationKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.h,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Ajoute une Réclamation',
                  style: ThemeTextStyle().headingOne,
                ),
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    'Type : ',
                    style: ThemeTextStyle().label,
                  ),
                ),
                SizedBox(
                    height: 50.h,
                    child: Obx(() {
                      return DropdownButton(
                        isDense: true,
                        // Initial Value
                        value: controller.type.value,
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: controller.allType.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? value) async {
                          await controller.changeType(value!);
                        },
                      );
                    })),
                SizedBox(
                  height: 30.h,
                ),
                ConstomInput(
                  title: 'Titre',
                  hint: '',
                  validator: (String? value) {
                    if (value!.length <= 6) {
                      return "Titre est trop court";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.titre = value;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                ConstomInputRec(
                  title: 'Reclamation',
                  hint: '',
                  validator: (String? value) {
                    if (value!.length < 10) {
                      return "Description est trop court";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.desc = value;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 3),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.r), // <-- Radius
                        ),
                        primary: ThemeColors.primary,
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10.h)),
                    onPressed: () async {
                      var t = _reclamationKey.currentState;
                      if (t!.validate()) {
                        t.save();
                        await controller.addReclamation(context);
                      }
                    },
                    child: const Text('Réclamer')),
              ],
            )),
      ))),
    );
  }
}
