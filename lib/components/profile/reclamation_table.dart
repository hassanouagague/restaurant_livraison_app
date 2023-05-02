import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/model/reclamation.dart';

import '../../theme/theme_text_style.dart';
import 'reclamation_exp.dart';

class ReclamationTable extends StatelessWidget {
  final List<ReclamationModel> allReclamation;
  final notifId;
  const ReclamationTable({Key? key, required this.allReclamation,this.notifId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          height: 50.h,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 50.w,
                  child: Text("ID", style: ThemeTextStyle().title)),
              // Container(
              //     width: 100.w,
              //     child: Text("Titre", style: ThemeTextStyle().title)),
              SizedBox(
                  width: 90.w,
                  child: Text("Date", style: ThemeTextStyle().title)),
              SizedBox(
                  width: 130.w,
                  child: Text("État", style: ThemeTextStyle().title)),
              SizedBox(
                  width: 50.w,
                  child: Text("Détails", style: ThemeTextStyle().title)),
            ],
          ),
        ),
        Column(
            children: List.generate(allReclamation.length, (int index) {
          return ReclamationExp(
            notifId: notifId??"",
            reclamation: allReclamation.elementAt(index),
          );
        }))
      ]),
    );
  }
}
