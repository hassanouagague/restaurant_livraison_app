import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/model/Livraison.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_text_style.dart';

class TableLiv extends StatelessWidget {
  final List<Livraison> data;
  final void Function(int? index)? onPressed;
  TableLiv({
    Key? key,
    required this.onPressed,
    required this.data,
  }) : super(key: key);
  Widget RichTextC({String? pre, String? suff}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(pre!, style: ThemeTextStyle().title),
        Text(suff!, style: ThemeTextStyle().sufNum)
      ],
    );
  }

  Widget RichTextt({String? pre, String? suff}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text(pre!), Text(suff!, style: ThemeTextStyle().sufNum)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      data.isEmpty
          ? SizedBox()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 10.w,
                horizontalMargin: 0,
                // Commande ID, Distance (Km), Durée (Min), Coût (€),
                columns: [
                  DataColumn(
                      label: Text(
                    '',
                    style: ThemeTextStyle().title,
                  )),
                  DataColumn(
                      label: Text(
                    'ID',
                    style: ThemeTextStyle().title,
                  )),
                  DataColumn(label: RichTextC(pre: 'Distance', suff: '(km)')),
                  DataColumn(label: RichTextC(pre: 'Coût', suff: '(€)')),
                  DataColumn(label: RichTextC(pre: 'Durée', suff: '(Min)')),
                  DataColumn(label: RichTextC(pre: 'Date', suff: '')),
                ],
                rows: List.generate(data.length, (index) {
                  return DataRow(
                      // color: Color.fromARGB(19, 197, 49, 38),
                      color: MaterialStateColor.resolveWith((states) {

                        if (data.elementAt(index).notif?? false) {
                          return Color.fromARGB(19, 197, 157, 38);
                        } else {
                          if (data.elementAt(index).etat == "Livrée") {
                            return Color.fromARGB(19, 51, 197, 38);
                          }
                          else if (data.elementAt(index).dcEtat == "En route"){
                            return Colors.blue.shade100;
                          }
                          else if (data.elementAt(index).dcEtat == "payé"){
                            return Colors.white;
                          }else
                          return Colors.transparent;
                        }
                      }),
                      cells: [
                        DataCell(IconButton(
                          color: ThemeColors.primary,
                          onPressed: () {
                            onPressed! (index);
                            //print("${data.elementAt(index).id}");
                          },
                          icon: const Icon(Icons.remove_red_eye),
                        )),
                        DataCell(Text("#${data.elementAt(index).id}")),
                        DataCell(RichTextt(
                            pre: data.elementAt(index).distance, suff: "km")),
                        DataCell(RichTextt(
                            pre: data.elementAt(index).cout, suff: "€")),
                        DataCell(RichTextt(
                            pre: data.elementAt(index).temps, suff: "Min")),
                        DataCell(Text(
                            style: TextStyle(fontSize: 8),
                            data.elementAt(index).createdAt ??
                                "-")),
                      ]);
                }),


                // DataRow(cells: [
                //   DataCell(Text('5')),
                //   DataCell(Text('John')),
                //   DataCell(Text('Student')),
                //   DataCell(Text('Actor')),
                //   DataCell(ElevatedButton(
                //     onPressed: () {},
                //     child: Text('détails'),
                //   )),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text('10')),
                //   DataCell(Text('Harry')),
                //   DataCell(Text('Leader')),
                //   DataCell(Text('Actor')),
                //   DataCell(ElevatedButton(
                //     onPressed: () {},
                //     child: Text('détails'),
                //   )),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text('15')),
                //   DataCell(Text('Peter')),
                //   DataCell(Text('Scientist')),
                //   DataCell(Text('Actor')),
                //   DataCell(ElevatedButton(
                //     onPressed: () {},
                //     child: Text('détails'),
                //   )
                //   ),
                // ]),
              ),
            )
    ]);
  }
}
