import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/bottombar.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  TextEditingController address = TextEditingController();
  Map data = {};
  bool isLoader = false;
  void getData() async {
    isLoader = true;
    setState(() {});
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection("orders").doc(widget.orderId).get();
    var res = documentSnapshot.data();
    data = (res as Map);
    isLoader = false;
    address.text = data['address'];
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
        title: Text(widget.orderId),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: isLoader == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF9c6d9d),
              ),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data['items'].length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        height: 140,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  height: 140,
                                  width: 140,
                                  child: Image.network(
                                    data['items'][index]['image'],
                                    fit: BoxFit.fill,
                                     loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: const Color(0xFF9c6d9d),
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                )),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  data['items'][index]['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${data['items'][index]['price']} \u{20B9}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFF9c6d9d)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "Quantity : ${data['items'][index]['qty']}"),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Dilivery Address"),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "reqiured..!";
                      }
                      return null;
                    },
                    maxLength: 300,
                    maxLines: 5,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Total item ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text("${data['totalItems']}"),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            "status",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            "${data['status']}",
                            style: TextStyle(
                                color: data['status'] == "pending"
                                    ? const Color(0xFF9c6d9d)
                                    : data['status'] == "confirm"
                                        ? Colors.greenAccent
                                        : data['status'] == "cancel"
                                            ? Colors.red
                                            : Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Shipping Charge",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text("0 \u{20B9}"),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Pay Ammount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text("${data['totalBill']} \u{20B9}"),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      data['status'] == "pending"
                          ? InkWell(
                              onTap: () async {
                                isLoader = true;
                                setState(() {});
                                FirebaseFirestore firebaseFirestore =
                                    FirebaseFirestore.instance;
                                await firebaseFirestore
                                    .collection("orders")
                                    .doc(widget.orderId)
                                    .update({
                                  "status": "cancel",
                                });
                                isLoader = false;
                                setState(() {});
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomBar()),
                                    (route) => false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red,
                                ),
                                height: 50,
                                child: const Center(
                                  child: Text("Cancel Order",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                            )
                          : data['status'] == "cancel"
                              ? InkWell(
                                  onTap: () async {
                                    isLoader = true;
                                    setState(() {});
                                    FirebaseFirestore firebaseFirestore =
                                        FirebaseFirestore.instance;
                                    await firebaseFirestore
                                        .collection("orders")
                                        .doc(widget.orderId)
                                        .update({
                                      "status": "pending",
                                    });
                                    isLoader = false;
                                    setState(() {});
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomBar()),
                                        (route) => false);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xFF9c6d9d),
                                    ),
                                    height: 50,
                                    child: const Center(
                                      child: Text("Reorder Order",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                )
                              : Text(
                                  "Your order is diliver at ${data['date']}"),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
