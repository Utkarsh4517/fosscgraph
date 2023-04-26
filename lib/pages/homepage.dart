import 'package:flutter/material.dart';
import 'package:fosscapi/services/apiservice.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  List<Map<String, dynamic>> sensorDataList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List<Map<String, dynamic>> data = await apiService.getData();
    setState(() {
      sensorDataList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ipController = TextEditingController();
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
                  'Enter your IP Address',
                  style: TextStyle(
                      color: Colors.white, fontSize: screenWidth * 0.06),
                ),
                SizedBox(
                  height: screenWidth * 0.08,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
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
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.08,
                ),
                ElevatedButton(
                  onPressed: () async {
                    //apiResponse = await apiService.getData();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  width: screenWidth * 0.8,
                  height: screenWidth * 1.2,
                  child: ListView.builder(
                    itemCount: sensorDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Temperature: ${sensorDataList[index]['temperature']}',style: const TextStyle(color: Colors.white),),
                        subtitle: Text('Humidity: ${sensorDataList[index]['humidity']}', style: const TextStyle(color: Colors.white),),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
