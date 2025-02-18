import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBucketListScreen extends StatefulWidget {
  int newIndex;

  AddBucketListScreen({super.key, required this.newIndex});

  @override
  State<AddBucketListScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<AddBucketListScreen> {
  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "cost": 10000,
        "image":
            "https://wallpapers.com/images/featured/nepal-684cyeq8t5f8csf9",
        "item": "Visit Nepal",
        "completed": false
      };

      Response response = await Dio().patch(
          "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.newIndex}.json",
          data: data);
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bucket"),
      ),
      body: ElevatedButton(onPressed: addData, child: Text("add data")),
    );
  }
}
