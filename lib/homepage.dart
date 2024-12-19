import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project2/pizzapage.dart';
import 'package:http/http.dart';
import 'package:project2/PurchaseCount.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pizzaData = [];

  Future<void> handle_api() async {
    final url =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List<dynamic> response = jsonDecode(url.body);
    setState(() {
      pizzaData = response.cast<Map<String, dynamic>>(); 
    });
  }
void initState() {
    super.initState();
    handle_api(); 
  }
  @override
  Widget build(BuildContext context) {
    final purchaseCount = Provider.of<PurchaseCount>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "PIZZA",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
            actions: [          
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart_checkout),
              ),
              Text(
                purchaseCount.count.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
          backgroundColor: Colors.grey[200],
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              // PIZZA 1
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  children: [
                    Image.asset("images/pizza.jpeg"),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18)),
                          child: Text(
                            "NON-VEG",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(18)),
                          child: Text(
                            "SPICY",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(pizzaData[0]['title'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      pizzaData[0]['body'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Row(
                      children: [
                        Text("\$12.6  ",
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                        Text("\$14",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PizzaPage(title:pizzaData[0]['title'],price:"\$12.6 ",oldprice: "\$14")));
                            },
                            icon: Icon(Icons.add_circle)),
                      ],
                    ),
                  ],
                ),
              ),
              // PIZZA 2
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  children: [
                    Image.asset("images/pizza.jpeg"),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18)),
                          child: Text(
                            "NON-VEG",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(18)),
                          child: Text(
                            "BLAND",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(pizzaData[1]['title'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      pizzaData[1]['body'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Row(
                      children: [
                        Text("\$10.8  ",
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                        Text("\$12",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PizzaPage(title:pizzaData[1]['title'],price:"\$10.8 ",oldprice: "\$12")));
                            },
                            icon: Icon(Icons.add_circle)),
                      ],
                    ),
                  ],
                ),
              ),
              // PIZZA 3
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  children: [
                    Image.asset("images/pizza.jpeg"),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(18)),
                          child: Text(
                            "VEG",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(18)),
                          child: Text(
                            "BALANCE",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(pizzaData[2]['title'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      pizzaData[2]['body'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Row(
                      children: [
                        Text("\$9.0  ",
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                        Text("\$10",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PizzaPage(title:pizzaData[0]['title'],price:"\$9.0 ",oldprice: "\$10")));
                            },
                            icon: Icon(Icons.add_circle)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
