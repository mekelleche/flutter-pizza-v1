import 'package:flutter/material.dart';
import 'package:project2/admin_user.dart';
import 'package:project2/myDB.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  Mydb mydb = Mydb();
  TabController? tabController;
  final _formKeyL = GlobalKey<FormState>();
  final _formKeyS = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController semailController = TextEditingController();
  TextEditingController spasswordController = TextEditingController();
  void handel_login() async {
    final email = emailController.text;
    final pwd = passwordController.text;
    int? isValid = await mydb.validateUser(email, pwd);
    if (isValid != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List user =
          await mydb.selectData('SELECT * FROM Users WHERE uid=$isValid');
      await prefs.setInt('type', user[0]['type']);
      await prefs.setString('email', user[0]['email']);
      await prefs.setInt('uid', isValid);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AdminUser()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('invalid email or password')),
      );
    }
  }

  void handel_singup() async {
    final name = snameController.text;
    final email = semailController.text;
    final pass = spasswordController.text;
    bool? exist = await mydb.validatemail(email);

    if (exist == false) {
      int? number = await mydb.insertData(
          'INSERT INTO Users(name,email,pass,type) VALUES("$name","$email","$pass",1)');
      if (number != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        List user =
            await mydb.selectData('SELECT * FROM Users WHERE uid=$number');
        await prefs.setInt('type', user[0]['type']);
        await prefs.setString('email', user[0]['email']);
        await prefs.setInt('uid', number);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdminUser()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('invalid email or password')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('invalid email already exist')));
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 17),
          unselectedLabelColor: Colors.grey[600],
          unselectedLabelStyle: TextStyle(fontSize: 16),
          tabs: [
            Tab(
              child: const Text("Log in"),
            ),
            Tab(
              child: const Text("Sing up"),
            ),
          ],
        ),
        title: const Text(
          "PIZZA APP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        Form(
            key: _formKeyL,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 5),
                    child: const Text(
                      "Log in to your acount",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: 350,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please entre email";
                      }
                      if (!RegExp(
                              r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return "please entre valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: 350,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        //suffix: IconButton(onPressed: (){},icon: Icon(Icons.remove_red_eye)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$')
                          .hasMatch(value)) {
                        return "please entre valid password";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 20, 5, 5),
                  width: 350,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (_formKeyL.currentState!.validate()) {
                          handel_login();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )),
        Form(
            key: _formKeyS,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 5),
                    child: const Text(
                      "Create an acount",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: 350,
                  child: TextFormField(
                    controller: snameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your User Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: 350,
                  child: TextFormField(
                    controller: semailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please entre email";
                      }
                      if (!RegExp(
                              r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return "please entre valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: 350,
                  child: TextFormField(
                    controller: spasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        //suffix: IconButton(onPressed: (){},icon: Icon(Icons.remove_red_eye)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$')
                          .hasMatch(value)) {
                        return "please entre valid password";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 20, 5, 5),
                  width: 350,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () async {
                        if (_formKeyS.currentState!.validate()) {
                          handel_singup();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      child: const Text(
                        "Sing up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )),
      ]),
    );
  }
}