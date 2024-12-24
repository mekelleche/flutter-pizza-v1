import 'package:flutter/material.dart';
import 'package:project2/homepage.dart';
import 'package:project2/myDB.dart';

class Userprof extends StatefulWidget {
  final int? user_id;
  const Userprof({required this.user_id});
  @override
  State<Userprof> createState() => _Userprof();
}

class _Userprof extends State<Userprof> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController curpassController = TextEditingController();
  TextEditingController newpassController = TextEditingController();
  TextEditingController confpassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Mydb mydb = Mydb();
  List userData = [];
  getData() async {
    List response = await mydb
        .selectData('SELECT * FROM Users WHERE uid=${widget.user_id}');
    //print(widget.user_id);
    //print("$response");
    setState(() {
      userData = response;
    });
  }

  handle_pass() async {
    final curpass = curpassController.text;
    final newpass = newpassController.text;
    final confpass = confpassController.text;
    final name = nameController.text;

    if (curpass == userData[0]['pass'] && (newpass.isEmpty && confpass.isEmpty||newpass.isNotEmpty && confpass.isNotEmpty)) {
      int i = await mydb.updateData(
          "UPDATE Users set name='$name' WHERE uid=${widget.user_id}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Accepted canged name")),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("incorrect password or dont fill new pass to change name")),
          );
    }
    if (curpass == newpass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('enter a new password')),
      );
    }
    if (confpass != newpass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('passwords doesnt match')),
      );
    }
    if (newpass.isNotEmpty &&
        curpass != newpass &&
        curpass == userData[0]['pass'] &&
        confpass == newpass) {
      int j = await mydb.updateData(
          "UPDATE Users set pass='$newpass' WHERE uid=${widget.user_id}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Accepted canged pass")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: userData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text(
                        "${userData[0]['name']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text(
                        "${userData[0]['email']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: 350,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          labelText: "Enter new username",
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please entre your";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: 350,
                    child: TextFormField(
                      controller: curpassController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          labelText: "Current Password",
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please entre your password";
                        }
                        if (value != null) {
                          if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$')
                              .hasMatch(value)) {
                            return "please entre valid password";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: 350,
                    child: TextFormField(
                      controller: newpassController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          labelText: "New Password",
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (value != null) {
                          if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$')
                              .hasMatch(value)) {
                            return "please entre valid password";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: 350,
                    child: TextFormField(
                      controller: confpassController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (value != null) {
                          if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$')
                              .hasMatch(value)) {
                            return "please entre valid password";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    width: 350,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            handle_pass();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill input')),
                            );
                          }
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    width: 350,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        child: const Text(
                          "Consult list",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
    );
  }
}