import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fosscapi/bargraph/bar_graph.dart';
import 'package:fosscapi/services/apiservice.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  double temperature = 0;
  double humidity = 0;
  double x_acc = 0;
  double y_acc = 0;
  double z_acc = 0;
  Timer? timer;
  // List<Map<String, dynamic>> sensorDataList = [];

  final ipController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   stopTimer();
  //   super.dispose();
  // }

  /// START TIMER FUNCTION
  void startTimer() {
    String ipAddress = ipController.text.trim();
    print(ipAddress);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      List<Map<String, dynamic>> data =
          await apiService.getData(ipAddress);
      setState(() {
        temperature = data.isNotEmpty
            ? double.tryParse(data[0]['temperature'].substring(0, 4)) ?? 0.0
            : 0.0;
        humidity =
            data.isNotEmpty ? double.tryParse(data[0]['humidity']) ?? 0.0 : 0.0;
        x_acc =
            data.isNotEmpty ? double.tryParse(data[0]['x_acc']) ?? 0.0 : 0.0;
        y_acc =
            data.isNotEmpty ? double.tryParse(data[0]['y_acc']) ?? 0.0 : 0.0;
        z_acc =
            data.isNotEmpty ? double.tryParse(data[0]['z_acc']) ?? 0.0 : 0.0;
      });
    });
  }

  /// STOP TIMER
  void stopTimer() {
    timer?.cancel();
    timer = null;
  }
 // this function has no use as data is called from timer function
  // Future<void> getData() async {
  //   List<Map<String, dynamic>> data =
  //       await apiService.getData(ipController.text);
  //   setState(() {
  //     sensorDataList = data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'F O S S C U',
          style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.green),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: screenWidth * 0.06,
                ),
                Text(
                  'Enter the IP Address',
                  style: TextStyle(
                      color: Colors.white, fontSize: screenWidth * 0.06),
                ),
                SizedBox(
                  height: screenWidth * 0.06,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'request is sent to url/sensor-data',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.03),
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: ipController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(202, 202, 202, 0.424),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(202, 202, 202, 0.424),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'enter ip address with port number',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.08,
                ),
                ElevatedButton(
                  onPressed: () async {
                    startTimer();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                    width: screenWidth * 0.8,
                    height: screenWidth * 1.2,
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Text(
                              'temperature : $temperature  ',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Humidity : $humidity  ',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'X-Acc : $x_acc  ',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Y-Acc : $y_acc  ',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Z-Acc : $z_acc',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.white,
                          height: screenWidth * 0.55,
                          child: MyBarGraph(
                            barData: [
                              temperature,
                              humidity,
                              x_acc,
                              y_acc,
                              z_acc
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
