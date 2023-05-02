import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/update_controller.dart';

import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../components/input/constom_input_pass.dart';
import '../../theme/theme_text_style.dart';

class Password extends StatelessWidget {
  Password({Key? key}) : super(key: key);
  final UpdateController controller = Get.put(UpdateController());

  final GlobalKey<FormState> _infoKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          title: Text('CHANGER LE MOT DE PASSE'),
          backgroundColor: ThemeColors.primary,
        ),
        body: SingleChildScrollView(child: Obx(() {
          return Form(
              key: _infoKey,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),

                      Text(
                        'CHANGER LE MOT DE PASSE',
                        style: ThemeTextStyle().headingOne,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      ConstomInputPass(
                        obscure: controller.obscur1.value,
                        title: "ANCIEN MOT DE PASSE",
                        hint: "..................",
                        onTap: () {
                          controller.obscur1.value = !controller.obscur1.value;
                        },
                        onSaved: (String? value) {
                          controller.password = value;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ConstomInputPass(
                        obscure: controller.obscur2.value,
                        title: "NOUVEAU MOT DE PASSE",
                        hint: "..................",
                        onTap: () {
                          controller.obscur2.value = !controller.obscur2.value;
                        },
                        onSaved: (String? value) {
                          controller.passwordOne = value;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ConstomInputPass(
                        obscure: controller.obscur2.value,
                        title: "CONFIRMER MOT DE PASSE",
                        hint: "..................",
                        onTap: () {
                          controller.obscur2.value = !controller.obscur2.value;
                        },
                        onSaved: (String? value) {
                          controller.passwordTwo = value;
                        },
                      ),
                      Visibility(
                        visible: !controller.error.value,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.msg.value,
                                  style: ThemeTextStyle().error,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
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
                            var t = _infoKey.currentState;

                            t!.save();
                            bool ch = controller.checkpassword();

                            if (ch) {
                              await controller.updatepass(context);
                              t.reset();
                            }
                          },
                          child: const Text('Modifier')),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  )));
        })),
      ),
    );
  }
}
