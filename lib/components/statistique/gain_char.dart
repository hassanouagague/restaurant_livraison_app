import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/statistical/gain_st_model.dart';
import '../../theme/theme_text_style.dart';

class GainChar extends StatelessWidget {
  final GainStModel gain;
  final String by;
  final String? title;
  const GainChar({Key? key, required this.gain, required this.by, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [];

    if (by == "Jour") {
      for (var i = 0; i < gain.day!.length; i++) {
        chartData
            .add(ChartData(gain.day!.elementAt(i), gain.montant!.elementAt(i)));
      }
    }
    if (by == "Mois") {
      for (var i = 0; i < gain.month!.length; i++) {
        chartData.add(
            ChartData(gain.month!.elementAt(i), gain.montant!.elementAt(i)));
      }
    }

    if (by == "Année") {
      for (var i = 0; i < gain.year!.length; i++) {
        chartData.add(
            ChartData(gain.year!.elementAt(i), gain.montant!.elementAt(i)));
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
              series: <ChartSeries<ChartData, int>>[
                // Renders column chart
                ColumnSeries<ChartData, int>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ])),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}
