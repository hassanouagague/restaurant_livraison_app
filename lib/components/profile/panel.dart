import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_text_style.dart';

class Panel extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function()? onTap;

  const Panel(
      {Key? key, required this.imagePath, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 316,
      child: Card(
        shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(6.0)),
        elevation: 10,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
            onPressed: onTap,
            child: Row(
              children: [
                SvgPicture.asset(imagePath,
                    width: 19.83.w,
                    height: 16.5,
                    color: ThemeColors.primary,
                    semanticsLabel: 'A red up arrow'),
                SizedBox(width: 20.0,),
                Expanded(child: Text(title,style: ThemeTextStyle().body2),),
                IconButton(
                  icon: SizedBox(
                      height: 22.h,
                      width: 10,
                      child: Icon(Icons.arrow_forward_ios,color: ThemeColors.primary,)),
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
      /*Card(
      shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(30.0)), // THIS NOT APPLYING !!!
      elevation: 20,
      color: Color(0xFFF5F6F9),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: TextButton(
          onPressed: onTap,
          child: Row(
            children: [
              SvgPicture.asset(imagePath,
                  width: 19.83.w,
                  height: 16.5,
                  color: ThemeColors.primary,
                  semanticsLabel: 'A red up arrow'),
              SizedBox(width: 20.0,),
              Expanded(child: Text(title,style: ThemeTextStyle().body2),),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );*/
      /**/
    /*InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(imagePath,
                    width: 19.83.w,
                    height: 16.5,
                    color: Colors.black,
                    semanticsLabel: 'A red up arrow'),
                SizedBox(
                  width: 22.75.w,
                ),
                Text(title, style: ThemeTextStyle().body),
              ],
            ),
            SizedBox(
              height: 22.h,
              width: 22.w,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 12.h,
              ),
            )
          ],
        ),
      ),
    );*/
  }
}
