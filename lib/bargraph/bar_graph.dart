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
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles))
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x.toInt(),
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: 15,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            )
            .toList()));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(color: Colors.red, fontSize: 10);

  Widget? text ;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Temparature',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Humidity',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'X-Acc',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Y-Acc',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Z-Acc',
        style: style,
      );
      break;
    default:
      const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text!);
}
