import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_livraison_app/theme/theme_text_style.dart';

import '../theme/theme_colors.dart';

class PanelLivraison extends StatelessWidget {
  final String? commandeId;
  final String? distance;
  final String? cout;
  final String? addressClt;
  final String? addressCkr;
  final void Function()? onPressed;
  //change color theme between night and day
  const PanelLivraison({
    Key? key,
    this.commandeId,
    this.distance,
    this.cout,
    this.addressClt,
    this.addressCkr,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 248, 255),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(31, 17, 17, 17),
              offset: Offset(0, 7.h),
              blurRadius: 8.r,
            )
          ]),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichTextC(pre: "Commande ID : ", suff: commandeId),
                RichTextC(pre: "Distance : ", suff: "$distance Km"),
                RichTextC(pre: "Coût : ", suff: "$cout €"),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text("Adresse :", style: ThemeTextStyle().title),
            SizedBox(
              height: 8.h,
            ),
            RichTextA(icon: Icons.cookie, pre: "cooker :", suff: addressCkr),
            SizedBox(
              height: 4.h,
            ),
            RichTextA(icon: Icons.person, pre: "client :", suff: addressClt),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r), // <-- Radius
                    ),
                    primary: ThemeColors.primary,
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(0, 0),
                    fixedSize: Size(double.infinity, 35.h)),
                child: const Text("trouve"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget RichTextA({String? pre, String? suff, IconData? icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 3.h),
        Icon(
          icon,
          size: 17.r,
        ),
        SizedBox(width: 5.h),
        Text(pre!, style: ThemeTextStyle().title),
        Expanded(child: Text(suff!, style: ThemeTextStyle().body))
      ],
    );
  }

  Widget RichTextC({String? pre, String? suff}) {
    return Row(
      children: [
        Text(pre!, style: ThemeTextStyle().title),
        Text(suff!, style: ThemeTextStyle().body)
      ],
    );
  }
}
//  Commande ID, Distance (Km), Durée (Min), Coût (€), Date Heure
//  Ajouter un colonne pour les actions, 
// va contenir les détails : 
// 1. Adresse du cooker
// 2. Adresse du client
//AjiCode: 3. Lien vers Maps google pour cooker et client
// RichText(
//         text: TextSpan(
//             text: 'Don\'t have an account?',
//             style: TextStyle(
//                 color: Colors.black, fontSize: 18),
//             children: <TextSpan>[
//               TextSpan(text: ' Sign up',
//                   style: TextStyle(
//                       color: Colors.blueAccent, fontSize: 18),
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       // navigate to desired screen
//                     }
//               )
//             ]
//         ),
//       ),