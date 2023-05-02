import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/model/penalite.dart';

import '../../theme/theme_text_style.dart';

class TablePen extends StatelessWidget {
  final List<Penalite> data;

  TablePen({
    Key? key,
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
                  DataColumn(label: RichTextC(pre: 'Transaction ID', suff: '')),
                  DataColumn(label: RichTextC(pre: 'Somme', suff: '')),
                  DataColumn(label: RichTextC(pre: 'Pénalité', suff: '')),
                  DataColumn(label: RichTextC(pre: 'État', suff: '')),
                  DataColumn(label: RichTextC(pre: 'Date', suff: '')),
                ],
                rows: List.generate(data.length, (index) {
                  return DataRow(cells: [
                    DataCell(Text("#${data.elementAt(index).id!}")),
                    DataCell(Text(data.elementAt(index).transactionId!)),
                    DataCell(RichTextt(
                        pre: data.elementAt(index).somme!, suff: "€")),
                    DataCell(RichTextt(
                        pre: data.elementAt(index).pinalite!, suff: "€")),
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
