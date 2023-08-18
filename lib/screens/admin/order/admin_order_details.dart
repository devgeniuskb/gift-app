import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/admin_bottombar.dart';

class AdminOrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const AdminOrderDetailsScreen({Key? key, required this.orderId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminOrderDetailsScreenState createState() =>
      _AdminOrderDetailsScreenState();
}

class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  DateTime? diliveryDate;
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
                const SizedBox(
                  height: 20,
                ),
                const Divider(color: Colors.black,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Name : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text("${data['firstName']} ${data['lastName']}")
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Email : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(data['email'])
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Mobile Number : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(data['mobile'])
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                const Divider(color: Colors.black,),
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Text(data['address']),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          data['status'] == "pending"
                              ? InkWell(
                                  onTap: () async {
                                    diliveryDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024));
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border:
                                            Border.all(color: Colors.black)),
                                    height: 50,
                                    child: Center(
                                      child: diliveryDate == null
                                          ? const Text("Select Dilivery Date",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ))
                                          : Text(
                                              diliveryDate
                                                  .toString()
                                                  .substring(0, 11),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                  ),
                                )
                              : data['status'] == "cancel"
                                  ? const Text(
                                      "order cancel",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(
                                      "Dilivery Date : ${data['date'].toString().substring(0, 11)}"),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
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
                                  "status": "confirm",
                                  "date": diliveryDate.toString()
                                });
                                isLoader = false;
                                setState(() {});
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminBottomBar()),
                                    (route) => false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xFF9c6d9d),
                                ),
                                height: 50,
                                child: const Center(
                                  child: Text("Confirm Order",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                            )
                          : data['status'] == "confirm"
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
                                      "status": "diliver",
                                    });
                                    isLoader = false;
                                    setState(() {});
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminBottomBar()),
                                        (route) => false);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xFF9c6d9d),
                                    ),
                                    height: 50,
                                    child: const Center(
                                      child: Text("Diliver done",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                      const SizedBox(
                        height: 8,
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
                                            const AdminBottomBar()),
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
                          : Container(),
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
