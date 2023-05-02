import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_text_style.dart';

class ConstomInputN extends StatelessWidget {
  final String? hintOne;
  final String? hintTwo;
  final String title;
  final String? valueone;
  final String? valuetwo;
  final void Function(String?)? onSavedOne;
  final void Function(String?)? onSavedTwo;
  const ConstomInputN(
      {Key? key,
      this.hintOne,
      this.hintTwo,
      this.valueone,
      this.valuetwo,
      required this.title,
      this.onSavedOne,
      this.onSavedTwo})
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
            input(hint: hintOne, onSaved: onSavedOne ,value: valueone),
            SizedBox(
              width: 10.w,
            ),
            input(hint: hintTwo, onSaved: onSavedTwo,value: valuetwo),
          ],
        ),
      ],
    );
  }

  Widget input({String? hint, void Function(String?)? onSaved,String? value}) {
    return Expanded(
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
                initialValue: value,
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
    );
  }
}

class ConstomInputNSpare extends StatelessWidget {
  final String? hintOne;
  final String? hintTwo;
  final String title;
  final String title1;
  final String? value;
  final String? value1;
  final void Function(String?)? onSavedOne;
  final void Function(String?)? onSavedTwo;
  const ConstomInputNSpare(
      {Key? key,
      this.hintOne,
      this.hintTwo,
      required this.title,
      required this.title1,
      this.value,
      this.value1,
      this.onSavedOne,
      this.onSavedTwo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  title,
                  style: ThemeTextStyle().label,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              input(hint: hintOne, onSaved: onSavedOne, value: value),
            ],
          ),
        ),
        SizedBox(
          width: 9.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  title1,
                  style: ThemeTextStyle().label,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              input(hint: hintTwo, onSaved: onSavedTwo, value: value1),
            ],
          ),
        ),
      ],
    );
  }

  Widget input({String? hint, void Function(String?)? onSaved, String? value}) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(children: [
          Expanded(
            child: TextFormField(
              initialValue: value,
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
    );
  }
}
