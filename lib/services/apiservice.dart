import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  Future<List<Map<String, dynamic>>> getData(String ip) async {
    final headers = {
      "accept": "application/json"
    };
    try {
      final response = await get(Uri.parse('http://$ip/sensor-data'), headers: headers);
      

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
      print(e);
    }
    return [];
  }
}
