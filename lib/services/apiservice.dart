import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  Future<String?> getData() async {

    try {
       final response =
        await get(Uri.parse('http://127.0.0.1:5000/sensor-data'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      data.forEach((sensorData) {
        print('Temperature: ${sensorData['temperature']}');
        print('Humidity: ${sensorData['humidity']}');
        print('X-Acceleration: ${sensorData['x_acc']}');
        print('Y-Acceleration: ${sensorData['y_acc']}');
        print('Z-Acceleration: ${sensorData['z_acc']}');
      });
    }
   
  }
  catch (e) {
    return e.toString();
  }
}
}