import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../components/input/constom_input.dart';
import '../../components/input/constom_input_n.dart';
import '../../components/input/constom_input_pass.dart';
import '../../controller/register_controller.dart';
import '../../controller/storage_controller.dart';
import '../../routes/route_constant.dart';
import '../../theme/theme_text_style.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final RegisterController registerController = Get.put(RegisterController());
  final StorageController storageController = Get.put(StorageController());
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: loginKey,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 78.h,
                    ),
                    Text(
                      'S\'inscrire',
                      style: ThemeTextStyle().headingOne,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 70.r,
                      width: 70.r,
                      child: Image.asset("asset/icon/logo.png"),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ConstomInputN(
                      hintOne: "Nom",
                      hintTwo: "Prénom",
                      title: "Nom Et Prénom",
                      onSavedOne: (String? value) {
                        registerController.user.nom = value;
                      },
                      onSavedTwo: (String? value) {
                        registerController.user.prenom = value;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ConstomInputRest(
                      title: 'Email',
                      hint: 'johndoe@email.com',
                      validator: (String? value) {
                        if (!GetUtils.isEmail(value!)) {
                          return "email n'est pas valide";
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        registerController.user.email = value;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() {
                      return ConstomInputPass(
                        obscure: registerController.obscure.value,
                        title: "Mot De Passe",
                        hint: "..................",
                        onTap: (() => registerController.changeObscure()),
                        onSaved: (String? value) {
                          registerController.user.password = value;
                        },
                      );
                    }),
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
                        onPressed: () {
                          var t = loginKey.currentState;
                          if(t!.validate()){
                            t.save();
                         
                            registerController.registre(context);
                          }
                          
                        },
                        child: const Text('S\'inscrire')),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous avez déjà un compte? ",
                            style: ThemeTextStyle().noticed),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteConstant.login);
                          },
                          child: Text("Connexion",
                              style: ThemeTextStyle().noticedOr),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
