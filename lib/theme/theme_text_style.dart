import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';

class ThemeTextStyle {
  //Heading 1
  final TextStyle headingOne =
      TextStyle(fontFamily: 'BebasNeue', fontSize: 36.sp,color: Colors.black);
  final TextStyle label = TextStyle(fontFamily: 'BebasNeue', fontSize: 14.sp,color: Colors.black);
  final TextStyle labelone = TextStyle(fontFamily: 'Poppins', fontSize: 15.sp,color: Colors.black);
  final TextStyle labeltwo = TextStyle(color:Colors.red,fontFamily: 'Poppins', fontSize: 12.sp);

  final TextStyle labelbolod = TextStyle(
      fontFamily: 'BebasNeue', fontSize: 12.sp, fontWeight: FontWeight.bold,color: Colors.black);
  final TextStyle inputHint = TextStyle(
      fontFamily: 'Poppins', fontSize: 14.sp, color: Colors.grey);
  final TextStyle inputH = TextStyle(fontFamily: 'Poppins', fontSize: 14.sp,color: Colors.black);
  final TextStyle noticed = TextStyle(
      fontFamily: 'PoppinsExtr',
      fontSize: 14.sp,
      color: Colors.grey);
  final TextStyle noticedOr = TextStyle(
      fontFamily: 'PoppinsExtr',
      fontSize: 14.sp,
      color: Colors.orange);
  final TextStyle body = TextStyle(fontFamily: 'PoppinsExtr', fontSize: 14.sp,color: Colors.black);
  final TextStyle body2 = TextStyle(fontFamily: 'PoppinsExtr', fontSize: 14.sp,color: Colors.grey);
  final TextStyle body3 = TextStyle(fontFamily: 'PoppinsExtr', fontSize: 15.sp,color: Colors.grey);
  final TextStyle body4 = TextStyle(fontFamily: 'PoppinsExtr', fontSize: 20.sp,color: Colors.deepOrange);

  final TextStyle sufNum = TextStyle(fontFamily: 'PoppinsExtr', fontSize: 9.sp);
  final TextStyle title2 = TextStyle(
      fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.bold,color: Colors.black);
  final TextStyle title = TextStyle(
      fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.bold,color: Colors.black);
  final TextStyle error = TextStyle(
      fontFamily: 'PoppinsExtr', fontSize: 14.sp, color: ThemeColors.error);
  final TextStyle ver = TextStyle(
      fontFamily: 'PoppinsExtr',
      fontSize: 14.sp,
      color: Color.fromARGB(255, 79, 121, 81));
  final TextStyle noVer = TextStyle(
      fontFamily: 'PoppinsExtr',
      fontSize: 14.sp,
      color: Color.fromARGB(255, 184, 62, 53));
  final TextStyle butVer =
      TextStyle(fontFamily: 'BebasNeue', fontSize: 13.sp, color: Colors.white);
  final TextStyle drwerTitle =
      TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: Colors.white);
  final TextStyle livVer = TextStyle(
      fontFamily: 'PoppinsExtr',
      fontSize: 16.sp,
      color: Color.fromARGB(255, 79, 121, 81));
}
