import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/theme/theme_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/statistical/liv_st_model.dart';
import '../../theme/theme_text_style.dart';

class LivChar extends StatelessWidget {
  final LivStModel liv;
  final String by;
  final String? title;
  const LivChar({Key? key, required this.liv, required this.by, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [];
    if (by == "Jour") {
      for (var i = 0; i < liv.day!.length; i++) {
        //print("char${liv.day!.elementAt(i)}");
        chartData.add(ChartData(liv.day!.elementAt(i), liv.nbr!.elementAt(i)));
      }
    }
    if (by == "Mois") {
      for (var i = 0; i < liv.month!.length; i++) {
        //print("char${liv.month!.elementAt(i)}");
        chartData
            .add(ChartData(liv.month!.elementAt(i), liv.nbr!.elementAt(i)));
      }
    }

    if (by == "Année") {
      for (var i = 0; i < liv.year!.length; i++) {
        //print("char${liv.year!.elementAt(i)}");
        chartData.add(ChartData(liv.year!.elementAt(i), liv.nbr!.elementAt(i)));
      }
    }
    return Center(
        child: SingleChildScrollView(

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          child: Container(
              height: 450.h,
              child: SfCartesianChart(
                  isTransposed: true,
                  title: ChartTitle(
                      text: title ?? "",
                      textStyle: const TextStyle(
                        // color: Colors.red,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      )),
                  primaryYAxis: NumericAxis(
                      // numberFormat: NumberFormat.numberOfIntegerDigits(),
                      interval: 1,
                      title: AxisTitle(
                          text: 'Nombre', textStyle: ThemeTextStyle().title)),
                  primaryXAxis: CategoryAxis(
                      interval: 1,
                      visibleMaximum: 15,
                      title:
                          AxisTitle(text: by, textStyle: ThemeTextStyle().title),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                  ),
                  series: <ChartSeries<ChartData, int>>[
                    // Renders column chart
                    ColumnSeries<ChartData, int>(
                        color: ThemeColors.primary,
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ])),
        ),
      ),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}
