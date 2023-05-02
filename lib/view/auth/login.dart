import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/controller/login_controller.dart';
import 'package:food_livraison_app/routes/route_constant.dart';
import 'package:food_livraison_app/service/api/user_service.dart';

import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../components/input/constom_input.dart';
import '../../components/input/constom_input_pass.dart';

import '../../theme/theme_text_style.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());

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
                      'Connexion',
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
                    ConstomInputRest(
                      title: 'Email',
                      hint: 'johndoe@email.com',
                      validator: (String? value) {
                        // if (false) {
                        //   return "email n'est pas valide";
                        // }
                        return null;
                      },
                      onSaved: (String? value) {
                        loginController.user.email = value;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() {
                      return ConstomInputPass(
                        obscure: loginController.obscure.value,
                        title: "Mot De Passe",
                        hint: "..................",
                        onTap: (() => loginController.changeObscure()),
                        onSaved: (String? value) {
                          loginController.user.password = value;
                        },
                      );
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            AwesomeDialog(
                              useRootNavigator: false,
                              context: context,
                              headerAnimationLoop: false,
                              dialogType: DialogType.NO_HEADER,
                              title: 'Reset mot de passe',
                              body: Column(children: [
                                Text(
                                  "Mot de passe oublié !",
                                  style: ThemeTextStyle().inputH,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ConstomInputRest(
                                  title: "email",
                                  controller: loginController.controller,
                                )
                              ]),
                              btnOkOnPress: () {
                                loginController.restpass(context);
                              },
                              btnOkIcon: Icons.check_circle,
                            ).show();
                          },
                          child: Text("Mot de passe oublié ",
                              style: ThemeTextStyle().noticedOr),
                        )
                      ],
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
                        onPressed: () {
                          var t = loginKey.currentState;
                          if (t!.validate()) {
                            t.save();

                            loginController.login(context);
                          }
                        },
                        child: const Text('Connexion')),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Créer nouveau compte ",
                            style: ThemeTextStyle().noticed),
                        InkWell(
                          child: Text("S'inscrire",
                              style: ThemeTextStyle().noticedOr),
                          onTap: () {
                            Get.toNamed(RouteConstant.register);
                          },

                        ),
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
// Mot de pass oublié