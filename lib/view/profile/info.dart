import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/update_controller.dart';

import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../components/input/constom_input.dart';
import '../../components/input/constom_input_n.dart';

import '../../theme/theme_text_style.dart';

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);
  final UpdateController controller = Get.put(UpdateController());

  final GlobalKey<FormState> _infoKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          title: Text('Mon compte'),
          backgroundColor: ThemeColors.primary,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _infoKey,
              child: Obx(() {
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                        height: 40.h,
                      ),

                        Text(
                          'Mon compte',
                          style: ThemeTextStyle().headingOne,
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        ConstomInputN(
                          hintOne: "Nom",
                          hintTwo: "Prénom",
                          valueone: controller.user.value.nom ?? "",
                          valuetwo: controller.user.value.prenom ?? "",
                          title: "Nom Et Prénom",
                          onSavedOne: (String? value) {
                            controller.user.value.nom = value;
                          },
                          onSavedTwo: (String? value) {
                            controller.user.value.prenom = value;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstomInputNSpare(
                          hintOne:"Mr ou M.",
                          hintTwo:"Numéro",
                          value: controller.user.value.civilite ?? "",
                          value1: controller.user.value.telephone ?? "",
                          title: "civilite",
                          title1: "telephone",
                          onSavedOne: (String? value) {
                            controller.user.value.civilite = value;
                            print("test kbis Z${controller.user.value.etatKbis}z");
                          },
                          onSavedTwo: (String? value) {
                            controller.user.value.telephone = value;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstomInputRest(
                          title: 'Email',
                          hint:'johndoe@email.com',
                          value:controller.user.value.email ?? "" ,
                          validator: (String? value) {
                            if (!GetUtils.isEmail(value!)) {
                              return "email n'est pas valide";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            controller.user.value.email = value;
                          },
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
                              if (t!.validate()) {
                                t.save();

                                await controller.updateinfo(context);
                                Get.to(_infoKey);
                                t.reset();
                              }
                            },
                            child: const Text('METTRE À JOUR')),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ));
              })),
        ),
      ),
    );
  }
}
