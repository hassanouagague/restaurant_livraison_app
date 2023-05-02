import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';
import 'package:food_livraison_app/view/auth/login.dart';
import 'package:food_livraison_app/view/home.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<bool> yesCancelDialog(
      BuildContext context,
      String title,
      String body,
      ) async {
    bool? exitApp = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(100.0, 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.r), // <-- Radius
                        ),
                        primary: ThemeColors.primary,
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10.h)),
                    child: Text(
                      'Annuler',
                    ),
                    onPressed:() => Get.back(),
                  ),
                ),
                SizedBox(width: 15.0,),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(100.0, 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20.r), // <-- Radius
                          ),
                          primary: ThemeColors.primary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10.h)),
                      child: Text(
                        'Confirmer',
                      ),
                      onPressed:() {
                        Get.off(Login());
                      },
                  ),
                ),
              ],
            ),
          ],
        );
      },);
    return exitApp ?? false;
  }
}