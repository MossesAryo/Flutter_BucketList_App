import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  void getData(){
    // Get data From API

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bucket List'),
      ),
      body: ElevatedButton(onPressed: getData, child: Text('Get Data'))
    );
  }
}