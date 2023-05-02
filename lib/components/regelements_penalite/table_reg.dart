import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/model/Livraison.dart';
import 'package:food_livraison_app/model/reglement.dart';

import '../../theme/theme_text_style.dart';

class TableReg extends StatelessWidget {
  final List<Reglement> data;
  final String notifId;
  TableReg({
    Key? key,
    required this.data,
    required this.notifId,
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
      children: [
        Text(
          pre!,
        ),
        Text(suff!, style: ThemeTextStyle().sufNum)
      ],
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
                columnSpacing: 14.w,
                horizontalMargin: 0,
                // Commande ID, Distance (Km), Durée (Min), Coût (€),
                columns: [
                  DataColumn(
                      label: Text(
                    'ID',
                    style: ThemeTextStyle().title,
                  )),
                  DataColumn(label: RichTextC(pre: 'Montant', suff: '(€)')),
                  DataColumn(label: RichTextC(pre: 'Période', suff: '')),
                  DataColumn(label: RichTextC(pre: 'état', suff: '')),
                  DataColumn(label: RichTextC(pre: 'Date', suff: '')),
                ],
                rows: List.generate(data.length, (index) {
                  return DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        if (notifId == data.elementAt(index).id) {
                          return Color.fromARGB(19, 197, 157, 38);
                        }
                        return Colors.white;
                      }),
                      cells: [
                        DataCell(Text("#${data.elementAt(index).id!}")),
                        DataCell(RichTextt(
                            pre: data.elementAt(index).montant!, suff: "€")),
                        DataCell(Text(data.elementAt(index).periode!)),
                        DataCell(Text(data.elementAt(index).etat!)),
                        DataCell(Text(
                            style: TextStyle(fontSize: 8),
                            data.elementAt(index).createdAt ?? "")),
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
