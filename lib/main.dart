import 'package:bucketlist/addBucketlist.dart';
import 'package:bucketlist/mainscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home" : (context) => MainScreen(),
        "/add" : (context) => AddBucketListScreen(),
      },
      initialRoute: "/home",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
