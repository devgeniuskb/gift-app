import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/screens/order/order_details.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List data = [];
  bool isLoader = false;
  void getData() async {
    isLoader = true;
    setState(() {});
    String userId = LocalStorage.instance.getString(LocalStorage.uid) ?? "";
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection("orders").get();
    var res = querySnapshot.docs;
    for (int i = 0; i < res.length; i++) {
      if (res[i]['uid'] == userId) {
        data.add(res[i]);
      }
    }
    isLoader = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: isLoader == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF9c6d9d),
              ),
            )
          : data.isEmpty
              ? Center(child: Lottie.asset("assets/image/no-data-found.json"))
              : ListView.builder(
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OrderDetailsScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        height: 120,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  spreadRadius: 1)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Order Id : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text("${data[index]['id']}"),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Total Item :",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text("${data[index]['totalItems']}"),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "status : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  "${data[index]['status']}",
                                  style: TextStyle(
                                      color: data[index]['status'] == "pending"
                                          ? const Color(0xFF9c6d9d)
                                          : data[index]['status'] == "confirm"
                                              ? Colors.greenAccent
                                              : data[index]['status'] ==
                                                      "cancel"
                                                  ? Colors.red
                                                  : Colors.green),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Bill ammount : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text("${data[index]['totalBill']} \u{20B9}"),
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
