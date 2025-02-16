import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 Future <void>   getData() async {
    // Get data From API
    Response response = await Dio().get(
        "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");

    print(response);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bucket List'),
        ),
        body: ElevatedButton(onPressed: getData, child: Text('Get Data')));
  }
}
