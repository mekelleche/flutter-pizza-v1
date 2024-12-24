import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project2/PurchaseCount.dart';

class PizzaPage extends StatefulWidget {
  final String title;
  final String price;
  final String oldprice;

  PizzaPage({required this.title, required this.price, required this.oldprice});
  State<PizzaPage> createState() => _PizzaPage();
}

class _PizzaPage extends State<PizzaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]),
                child: Image.asset("images/pizza.jpeg",
                    height: 280, width: 300, fit: BoxFit.cover),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(widget.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Spacer(),
                        Text(widget.price,
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                        Text(widget.oldprice,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.local_fire_department,
                                  color: Colors.red),
                              Text("242 Calories")
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.fitness_center, color: Colors.red),
                              Text("24g protein")
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.water_drop_outlined,
                                  color: Colors.red),
                              Text("18g Fat")
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.lunch_dining, color: Colors.red),
                              Text("26g Carbs")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 400,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Provider.of<PurchaseCount>(context, listen: false)
                                .incrementCount();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Pizza have been added")),
                            );
                          },
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
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
