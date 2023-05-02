import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/theme_text_style.dart';

class ConstomInputPass extends StatelessWidget {
  final String? hint;
  final bool? obscure;
  final String title;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  const ConstomInputPass(
      {Key? key, this.hint, this.obscure, required this.title,this.onTap,this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Text(
              title,
              style: ThemeTextStyle().label,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(20.r)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        onSaved: onSaved,
                        obscureText: obscure!,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: hint,
                          hintStyle: ThemeTextStyle().inputHint,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: SvgPicture.asset(
                          obscure!
                              ? "asset/icon/password/EyeClose.svg"
                              : "asset/icon/password/Eyeopen.svg",
                          width: 19.83.w,
                          height: 16.5,
                          // color: Colors.red,
                          semanticsLabel: 'A red up arrow'),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
