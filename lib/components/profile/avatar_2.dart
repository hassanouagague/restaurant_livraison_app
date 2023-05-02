import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';
import 'package:food_livraison_app/theme/theme_text_style.dart';

class AvatarTwo extends StatelessWidget {
  final String? fullName;
  final int? etat;
  final String? urlImage;
  //final String? baseImg;
  final void Function()? onPressed;

  const AvatarTwo(
      {Key? key,
        this.fullName,
        this.etat = 0,
        required this.onPressed,
        this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dImage = DecorationImage(
      onError: (obj, st) {

      },
      fit: BoxFit.cover,
      image: Image.network(
        'https://imageio.forbes.com/specials-images/imageserve/61688aa1d4a8658c3f4d8640/Antonio-Juliano/0x0.jpg?format=jpg&width=960',
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          debugPrint("onError B");

          return const CircularProgressIndicator();
        },
      ).image,
    );
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 80.r,
              width: 80.r,
              decoration: BoxDecoration(
                border: Border.all(width: 2.r, color: ThemeColors.primary),
                shape: BoxShape.circle,
                image: dImage.onError != null
                    ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://repas-maison.com/$urlImage"), //default image URL on null case
                )
                    : dImage,
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: Container(
                height: 40.r,
                width: 80.r,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          fullName ?? "",
          style: ThemeTextStyle().body,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            etat == 0 ? Text(
              "Non Vérifié",
              style: ThemeTextStyle().noVer,
            ) : Text(
              "Vérifié",
              style: ThemeTextStyle().ver,
            ),
          ],
        )
      ],
    );
  }
}
