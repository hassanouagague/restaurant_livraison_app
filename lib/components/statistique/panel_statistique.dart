import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_text_style.dart';

class PanelStatistique extends StatefulWidget {
  final String imagePath;
  final String title;
  final void Function()? onTap;
  Widget? child;
  PanelStatistique(
      {Key? key,
        required this.imagePath,
        required this.title,
        this.onTap,
        this.child})
      : super(key: key);

  @override
  State<PanelStatistique> createState() => _PanelStatistiqueState();
}

class _PanelStatistiqueState extends State<PanelStatistique> {
  bool isExpanded = false;
  double height = 40.h;
  double counter = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      onEnd: () {
        setState(() {
          if (height > 50) {
            isExpanded = true;
            return;
          }
        });
      },
      duration: const Duration(milliseconds: 200),
      // constraints: BoxConstraints(

      //   maxHeight: 310.h,
      // ),

      width: 330,
      height: height+40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.082,
                child: Card(
                  //semanticContainer: true,
                  shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(6.0)), // THIS NOT APPLYING !!!
                  elevation: 10,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: SizedBox(
                    height: 62,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(widget.imagePath,
                              width: 19.83.w,
                              height: 16.5,
                              color: ThemeColors.primary,
                              semanticsLabel: 'A red up arrow'),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(widget.title, style: ThemeTextStyle().body2
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("d$height");
                              setState(() {
                                if (height > 40.h) {
                                  isExpanded = false;
                                  height = 40.h;
                                  counter = 0;
                                  return;
                                }
                                height = 240.h;
                                counter = 0.25;
                              });
                            },
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 150),
                              turns: counter,
                              child: SizedBox(
                                height: 22.h,
                                width: 30,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ThemeColors.primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              height > 199.h && isExpanded
                  ? Row(
                children: [
                  SizedBox(width: 40.w),
                  widget.child!,
                ],
              )
                  : SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),

    );

  }
}
