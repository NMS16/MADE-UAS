import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String firebaseURL = "https://uas-made-a204d-default-rtdb.asia-southeast1.firebasedatabase.app/";

  void sendData() async {
    final response = await http.put(
      Uri.parse(
          "$firebaseURL/switch.json"), // to add data to the database in firebase
      body: json.encode(
        {
          "onoff": onoff,
        },
      ),
    );
  }

  void getDataTemp() async {
    final response = await http.get(
       Uri.parse("$firebaseURL/data.json"), // to add data to the database in firebase
    );
    final data = json.decode(response.body);
    setState(() {
      getDataFBTemp = data["temp"];
    });
    // to get data directly from the firebase
  }

  void getDataHum() async {
    final response = await http.get(
       Uri.parse("$firebaseURL/data.json"), // to add data to the database in firebase
    );
    final data = json.decode(response.body);
    setState(() {
      getDataFBHum = data["humidity"];
    });
    // to get data directly from the firebase
  }

  void getDataLight() async {
    final response = await http.get(
       Uri.parse("$firebaseURL/data.json"), // to add data to the database in firebase
    );
    final data = json.decode(response.body);
    setState(() {
      getDataFBLight = data["light"];
    });
    // to get data directly from the firebase
  }

  bool onoff = false;
  int getDataFBTemp = 0;
  int getDataFBHum = 0;
  int getDataFBLight = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Get Data from Firebase"),
        ),
      ),
      body: Row(
        children:[
          Column(
            children:[
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  "Temperature: $getDataFBTemp",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  "Humidity: $getDataFBHum",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  "Light: $getDataFBLight",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                onPressed: (){
                  getDataHum();
                  getDataLight();
                  getDataTemp();
                  print("Refreshed");
                }
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "On/Off",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                onPressed: (){
                  onoff = !onoff;
                  sendData();
                  print("Switched");
                }
              ,)
            ],
          ),
        ],
      ),
    );
  }
}