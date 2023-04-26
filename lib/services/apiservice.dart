import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final response = await get(Uri.parse('http://127.0.0.1:5000/sensor-data'));
      

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> sensorDataList = [];

        data.forEach((sensorData) {
          Map<String, dynamic> dataMap = {
            'temperature': sensorData['temperature'],
            'humidity': sensorData['humidity'],
            'x_acc': sensorData['x_acc'],
            'y_acc': sensorData['y_acc'],
            'z_acc': sensorData['z_acc']
          };
          sensorDataList.add(dataMap);
        });

        return sensorDataList;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
