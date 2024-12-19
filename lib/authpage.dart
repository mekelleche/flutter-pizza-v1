
import 'package:flutter/material.dart';
import 'package:project2/homepage.dart';



class AuthPage extends StatefulWidget {
  AuthPage({super.key});
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  

  TabController? tabController;
  final _formKeyL = GlobalKey<FormState>();
  final _formKeyS = GlobalKey<FormState>();
  //TextEditingController emailController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();
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
                    //controller: emailController,
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
                    //controller: passwordController,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 5, 5),
                      width: 170,
                      child: TextFormField(
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
                            labelText: "First Name",
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your First Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 15, 5),
                      width: 170,
                      child: TextFormField(
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
                            labelText: "Last name",
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: 350,
                  child: TextFormField(
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
                        if (_formKeyS.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
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
//class____ with sinle sTier.....
//TabController tab;
//TabBarr
//for validation :
//Form 
//TextFormField
//ReExp(r'@')  for email validation