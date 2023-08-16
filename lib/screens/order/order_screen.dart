import 'package:flutter/material.dart';
import 'package:gift_app/screens/order/order_details.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const OrderDetailsScreen()));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 120,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  offset: Offset(2, 2),
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 1)
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Order Id : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("4 "),
                  ],
                ),
                 SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Total Item :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("4 "),
                  ],
                ),
                 SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "status : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("Pendding",style: TextStyle(color: Colors.red),),
                  ],
                ),
                 SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Bill ammount : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("400 \u{20B9}"),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
