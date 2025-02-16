import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  ViewItemScreen({super.key, required this.title});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("${widget.title}"),
    ));
  }
}
