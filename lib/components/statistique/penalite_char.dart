import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/statistical/penalite_st_model.dart';
import '../../theme/theme_text_style.dart';

class PainaliteChar extends StatelessWidget {
  final PenaliteStModel penalite;
  final String by;
  final String? title;
  const PainaliteChar(
      {Key? key, required this.penalite, required this.by, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [];
    if (by == "Jour") {
      for (var i = 0; i < penalite.day!.length; i++) {
        chartData.add(ChartData(penalite.day!.elementAt(i),
            penalite.penalite!.elementAt(i), penalite.somme!.elementAt(i)));
      }
    }
    if (by == "Mois") {
      for (var i = 0; i < penalite.month!.length; i++) {
        chartData.add(ChartData(penalite.month!.elementAt(i),
            penalite.penalite!.elementAt(i), penalite.somme!.elementAt(i)));
      }
    }

    if (by == "Année") {
      for (var i = 0; i < penalite.year!.length; i++) {
        chartData.add(ChartData(penalite.year!.elementAt(i),
            penalite.penalite!.elementAt(i), penalite.somme!.elementAt(i)));
      }
    }
    return Center(
        child: SingleChildScrollView(
      child: Container(
          height: 300.h,
          child: SfCartesianChart(
              title: ChartTitle(
                  text: title ?? "",
                  textStyle: const TextStyle(
                    // color: Colors.red,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    fontSize: 10,
                  )),
              primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Montant', textStyle: ThemeTextStyle().title)),
              primaryXAxis: CategoryAxis(
                  interval: 1,
                  visibleMaximum: 9,
                  title:
                      AxisTitle(text: by, textStyle: ThemeTextStyle().title)),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
              ),
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  isResponsive: false),
              series: <ChartSeries<ChartData, int>>[
                // Renders column chart
                ColumnSeries<ChartData, int>(
                    name: "Pénalites",
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y),
                ColumnSeries<ChartData, int>(
                    name: "Somme",
                    yAxisName: "test",
                    xAxisName: "he",
                    opacity: 0.9,
                    width: 0.4,
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y1)
              ])),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final int y;
  final int y1;
}
