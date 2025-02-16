import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];

  Future<void> getData() async {
    // Get data From API

    //Handle API Error
    try {
      Response response = await Dio().get(
          "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");

      bucketListData = response.data;

      setState(() {});
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Cannot Connect to Server"),
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bucket List'),
          actions: [
            InkWell(
              onTap: getData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: bucketListData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(bucketListData[index]["image"] ?? ""),
                  ),
                  title: Text(bucketListData[index]["item"] ?? ""),
                  trailing: Text(bucketListData[index]["cost"].toString()),
                );
              }),
        ));
  }
}
