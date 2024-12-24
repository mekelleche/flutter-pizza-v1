import 'package:flutter/material.dart';
import 'package:project2/myDB.dart';
import 'package:project2/pizzapage.dart';
import 'package:project2/PurchaseCount.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List pizzaData = [];
  Mydb mydb = Mydb();
  getData() async {
    List<Map> response = await mydb.selectData('SELECT * FROM Pizza');
    //print("$response");
    setState(() {
      pizzaData = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    //print("$pizzaData");
  }

  @override
  Widget build(BuildContext context) {
    final purchaseCount = Provider.of<PurchaseCount>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
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
        body: pizzaData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
          color: Colors.grey[200],
          child: ListView.builder(
  itemCount: pizzaData.length,
  itemBuilder: (BuildContext context, int i) {
    return buildPizza(
      context,
      "${pizzaData[i]['title']}",
      "${pizzaData[i]['desc']}",
      "${pizzaData[i]['price']}",
      "${pizzaData[i]['old_price']}",
        pizzaData[i]['isVeg'],
      "${pizzaData[i]['nature']}"
    );
  },
),
        ),
      ),
    );
  }

  Widget buildPizza(BuildContext context, String title, String description,
      String price, String oldPrice,int isVeg,String nature) {
    return Container(
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
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset("images/pizza.jpeg"),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                decoration: BoxDecoration(
                  color:isVeg ==1? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  isVeg ==1 ? "VEG" : "NON-VEG",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  nature,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          Row(
            children: [
              Text(
                price + "  ",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Text(
                oldPrice,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PizzaPage(
                        title: title,
                        price: price,
                        oldprice: oldPrice,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.add_circle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
