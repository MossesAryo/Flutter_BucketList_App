import 'package:bucketlist/addBucketlist.dart';
import 'package:bucketlist/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    // Get data From API

    //Handle API Error
    try {
      Response response = await Dio().get(
          "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");

      bucketListData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddBucketListScreen();
            }));
          },
          shape: CircleBorder(),
          child: Icon(Icons.add),
        ),
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
        body: RefreshIndicator(
          onRefresh: () async {
            getData();
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: bucketListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewItemScreen(
                              title: bucketListData[index]["item"].toString(),
                              image: bucketListData[index]["image"] ?? "",
                            );
                          }));
                        },
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              bucketListData[index]["image"] ?? ""),
                        ),
                        title: Text(bucketListData[index]["item"] ?? ""),
                        trailing:
                            Text(bucketListData[index]["cost"].toString()),
                      ),
                    );
                  }),
        ));
  }
}
