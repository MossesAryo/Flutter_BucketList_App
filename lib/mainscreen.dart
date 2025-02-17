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
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    // Get data From API

    //Handle API Error
    try {
      Response response = await Dio().get(
          "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");

      if (response.data is List) {
        bucketListData = response.data;
      } else {
        bucketListData = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(onPressed: getData, child: Text('Try Again'))
        ],
      ),
    );
  }

  Widget listDataWidget() {
    List<dynamic> filteredList = bucketListData
        .where((element) => !(element?["completed"] ?? false))
        .toList();

    return filteredList.length < 1
        ? Center(child: Text("No Data"))
        : ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: (bucketListData[index] is Map &&
                        (!(bucketListData[index]["completed"] ?? false)))
                    ? ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewItemScreen(
                              index: index,
                              title:
                                  bucketListData[index]?["item"].toString() ??
                                      "",
                              image: bucketListData[index]?["image"] ?? "",
                            );
                          })).then((value) {
                            if (value == "refresh") {
                              getData();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              bucketListData[index]?["image"] ?? ""),
                        ),
                        title: Text(bucketListData[index]?["item"] ?? ""),
                        trailing: Text(
                            bucketListData[index]?["cost"].toString() ?? ""),
                      )
                    : SizedBox(),
              );
            });
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
              : isError
                  ? errorWidget(errorText: "Reconnecting...")
                  : listDataWidget(),
        ));
  }
}
