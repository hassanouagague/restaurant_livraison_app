import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_text_style.dart';

class ConstomInputRec extends StatelessWidget {
  final String? hint;
  final String title;
  final String? value;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const ConstomInputRec(
      {Key? key,
      this.hint,
      this.value,
      this.controller,
      required this.title,
      this.onSaved,
      this.validator,
      this.onChanged})
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
                // height: 70.h,
                constraints: BoxConstraints(
                  minHeight: 150.h,
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(20.r)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 6,
                            controller: controller,
                            onChanged: onChanged,
                            initialValue: value,
                            validator: validator,
                            onSaved: onSaved,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: hint,
                              hintStyle: ThemeTextStyle().inputHint,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
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
