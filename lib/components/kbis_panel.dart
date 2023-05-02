import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';

import '../../theme/theme_text_style.dart';
import 'statistique/custombutton.dart';

class KbisPanel extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? fileName;
  final String? etatkbis;
  final void Function()? onTap;
  final void Function()? onPre;
  KbisPanel(
      {Key? key,
      required this.imagePath,
      required this.title,
      this.onTap,
      required this.onPre,
      this.fileName,
      this.etatkbis,
      })
      : super(key: key);

  @override
  State<KbisPanel> createState() => _KbisPanelState();
}

class _KbisPanelState extends State<KbisPanel> {
  bool isExpanded = false;
  double height = 40.h;
  double counter = 0;
  //String kbis_etat = "";
  @override
  Widget build(BuildContext context) {

    print('etatkbis ZAZ ${widget.etatkbis}');

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

        // maxHeight: 310.h,
      // ),
      width: 330,
      height: height+40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.082,
                child: Card(
                  shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(06.0)), // THIS NOT APPLYING !!!
                  elevation: 10,
                  color:Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: SizedBox(
                    height: 62,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  SvgPicture.asset(widget.imagePath,
                                      width: 19.83.w,
                                      height: 16.5,
                                      color: ThemeColors.primary,
                                      semanticsLabel: 'A red up arrow'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(child: Text(widget.title, style: ThemeTextStyle().body2)),
                                ],
                              ),
                            ),
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
                                height = 100.h;
                                counter = 0.25;
                              });
                            },
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 150),
                              turns: counter,
                              child: SizedBox(
                                height: 22.h,
                                width: 42.w,
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

              height > 79.h && isExpanded
                  ? Padding(
                    padding: EdgeInsets.all(20.h),
                    child: widget.fileName != "" ? widget.etatkbis != "Validé" ? const Text(
                      "Fichier est téléchargé",
                      style: TextStyle(color: ThemeColors.primary),
                    ) : const Text(
                      "Kbis validé",
                      style: TextStyle(color: Colors.green),
                    ) : Row(
                      children: [
                        Custombutton(
                          title: "Parcourir un Fichier kbis",
                          onPressed: widget.onPre,
                        ),
                      ],
                    ),
                  )
                  : SizedBox(
                height: 20.h,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
