import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_colors.dart';

class Custombutton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const Custombutton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 240.w,
        height: 35.h,
        child: TextButton(
            onPressed: onPressed,
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp),
                ),
              ],
            )));
  }
}
