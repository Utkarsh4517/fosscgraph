import 'package:fosscapi/bargraph/individual_bar.dart';

class BarData {
  final double temperature;
  final double humidity;
  final double x_acc;
  final double y_acc;
  final double z_acc;

  BarData(
      {required this.temperature,
      required this.humidity,
      required this.x_acc,
      required this.y_acc,
      required this.z_acc});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: temperature),
      IndividualBar(x: 0, y: humidity),
      IndividualBar(x: 0, y: x_acc),
      IndividualBar(x: 0, y: y_acc),
      IndividualBar(x: 0, y: z_acc),
    ];
  }
}
