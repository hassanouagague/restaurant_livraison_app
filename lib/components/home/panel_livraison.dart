import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_text_style.dart';

class PanelLivraison extends StatefulWidget {
  final String imagePath;
  final String title;
  final void Function()? onTap;
  Widget? child;
  PanelLivraison(
      {Key? key,
      required this.imagePath,
      required this.title,
      this.onTap,
      this.child})
      : super(key: key);

  @override
  State<PanelLivraison> createState() => _PanelLivraisonState();
}

class _PanelLivraisonState extends State<PanelLivraison> {
  bool isExpanded = true;
  double height = 300.h;
  double counter = 0.25;
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
      width: double.infinity,
      height: height+45,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height*0.082,
            child: Card(
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
                      Row(
                        children: [
                          SvgPicture.asset(widget.imagePath,
                              width: 19.83.w,
                              height: 16.5,
                              color: ThemeColors.primary,
                              semanticsLabel: 'A red up arrow'),
                          SizedBox(
                            width: 22.75.w,
                          ),
                          Text(widget.title, style: ThemeTextStyle().body3),
                        ],
                      ),
                      InkWell(
                        onTap: () {

                          setState(() {

                            if (height > 40.h) {
                              isExpanded = false;
                              height = 40.h;
                              counter = 0;
                              return;
                            }
                            height = 300.h;

                            counter = 0.25;
                          });
                        },
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 150),
                          turns: counter,
                          child: SizedBox(
                            height: 22.h,
                            width: 30,
                            child:  Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeColors.primary,
                              size: 20,
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
          height > 280.h && isExpanded
              ? widget.child!
              : SizedBox(
                  height: 10.h,
                )
        ],
      ),
    );
  }
}
