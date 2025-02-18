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
  TextEditingController itemText = TextEditingController();
  TextEditingController costText = TextEditingController();
  TextEditingController imgURLText = TextEditingController();

  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "cost": costText.text,
        "image": imgURLText.text,
        "item": itemText.text,
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
    var addForm = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Bucket"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: addForm,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().length < 3) {
                      return "Must be more than 3 character";
                    }
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                  },
                  controller: itemText,
                  decoration: InputDecoration(label: Text("Item")),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().length < 3) {
                      return "Must be more than 3 character";
                    }
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                  },
                  controller: costText,
                  decoration: InputDecoration(label: Text("Estimated Costs")),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().length < 3) {
                      return "Must be more than 3 character";
                    }
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                  },
                  controller: imgURLText,
                  decoration: InputDecoration(label: Text("Image URL")),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (addForm.currentState!.validate()) {
                                addData();
                              }
                            },
                            child: Text("add data"))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
