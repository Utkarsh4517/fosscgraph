import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fosscapi/bargraph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List barData;
  const MyBarGraph({required this.barData, super.key});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      temperature: barData[0],
      humidity: barData[1],
      x_acc: barData[2],
      y_acc: barData[3],
      z_acc: barData[4],
    );
    myBarData.initializeBarData();
    return BarChart(BarChartData(
        maxY: 50,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x.toInt(),
                barRods: [
                  BarChartRodData(toY: data.y, width: 15, borderRadius: BorderRadius.circular(4)),
                ],
              ),
            )
            .toList()));
  }
}
