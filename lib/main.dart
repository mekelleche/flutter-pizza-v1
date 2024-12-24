import 'package:flutter/material.dart';
import 'package:project2/adminprof.dart';
import 'package:project2/authpage.dart';
import 'package:project2/PurchaseCount.dart';
import 'package:project2/homepage.dart';
import 'package:project2/myDB.dart';
import 'package:project2/userprof.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PurchaseCount(), 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
