import 'package:flutter/material.dart';
import 'package:project2/adminprof.dart';
import 'package:project2/userprof.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdminUser extends StatefulWidget {
  AdminUser({super.key});

  @override
  State<AdminUser> createState() => _AdminUser();
}

class _AdminUser extends State<AdminUser> {
  int? type;
  String? email;
  int? id;
  bool isLoading = true;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getInt('type');
      email = prefs.getString('email');
      id = prefs.getInt('uid');
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (id == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text("Error: User ID is not available."),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: type == 0 ? AdminProf(user_id: id!) : Userprof(user_id: id!),
    );
  }
}
