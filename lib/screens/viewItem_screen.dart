import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  int index;
  ViewItemScreen(
      {super.key,
      required this.index,
      required this.title,
      required this.image});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.index}.json");
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  Future<void> markAsComplete() async {
    try {
      Map<String, dynamic> data = {"completed": true};

      Response response = await Dio().patch(
          "https://flutterapitest123-417ed-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.index}.json",
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
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure to delete this item ?'),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        InkWell(
                          onTap: () {
                            deleteData();
                          },
                          child: Text("Delete"),
                        )
                      ],
                    );
                  });
            }

            if (value == 2) {
              markAsComplete();
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text("delete")),
              PopupMenuItem(value: 2, child: Text("Mark As Complete"))
            ];
          })
        ],
        title: Text("${widget.title}"),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.image))),
          ),
        ],
      ),
    );
  }
}
