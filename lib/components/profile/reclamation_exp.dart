import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/reclamation.dart';
import '../../theme/theme_text_style.dart';

class ReclamationExp extends StatefulWidget {
  final ReclamationModel reclamation;
  final String? notifId;
  ReclamationExp({Key? key, required this.reclamation,this.notifId}) : super(key: key);
  double height = 60.h;
  bool visible = false;
  @override
  State<ReclamationExp> createState() => _ReclamationExpState();
}

class _ReclamationExpState extends State<ReclamationExp> {
 
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      onEnd: () {
        if (widget.height > 250.h) {
          setState(() {
            widget.visible = true;
          });
        }
      },
      duration: const Duration(milliseconds: 200),
      height: widget.height,
      decoration:  BoxDecoration(
        color:widget.reclamation.id == widget.notifId ? Color.fromARGB(19, 197, 157, 38):null,
        border:const Border(bottom: BorderSide()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 50.w,
                  child: Text("#${widget.reclamation.id}",
                      style: ThemeTextStyle().body)),
              // Container(
              //     width: 100.w,
              //     child: Text("Titre", style: ThemeTextStyle().title)),
              SizedBox(
                  width: 90.w,
                  child: Text(widget.reclamation.createdAt!,
                      style: ThemeTextStyle().sufNum)),
              SizedBox(
                  width: 130.w,
                  child: Text(widget.reclamation.etat!,
                      style: ThemeTextStyle().body)),
              SizedBox(
                  width: 50.w,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.height > 250.h) {
                          widget.visible = false;
                          widget.height = 60.h;
                        } else {
                          widget.height = 260.h;
                        }
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20.r,
                  ))
            ],
          ),
          Visibility(
            visible: widget.visible,
            child: Row(
              children: [
                SizedBox(width: 10.w),
                Text("type : ", style: ThemeTextStyle().title),
                Text(widget.reclamation.type!, style: ThemeTextStyle().body),
              ],
            ),
          ),
          Visibility(
            visible: widget.visible,
            child: Row(
              children: [
                SizedBox(width: 10.w),
                Text("Titre : ", style: ThemeTextStyle().title),
                Text(widget.reclamation.titre!, style: ThemeTextStyle().body),
              ],
            ),
          ),
          Visibility(
            visible: widget.visible,
            child: SizedBox(
              height: 70.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10.w),
                  Text("reclamation : ", style: ThemeTextStyle().title),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(widget.reclamation.reclamation!,
                          style: ThemeTextStyle().body),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.reclamation.reponse != [] && widget.reclamation.reponse != null
              ? Visibility(
                  visible: widget.visible,
                  child: SizedBox(
                    height: 80.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
                        Text("Réponse : ", style: ThemeTextStyle().title),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.reclamation.reponse!
                                      .map((e) => Text(e.reponse!,
                                          style: ThemeTextStyle().body))
                                      .toList())),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
