import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/controller/cart_data.dart';
import 'package:gift_app/screens/cart/cart_screen.dart';
import 'package:lottie/lottie.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  CartData cartData = Get.put(CartData());
  String userId = "";
  bool isLoader = false;
  List data = [];
  void getData() async {
    isLoader = true;
    setState(() {});
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("like")
        .get();
    data = querySnapshot.docs;
    isLoader = false;
    setState(() {});
  }

  @override
  void initState() {
    userId = LocalStorage.instance.getString(LocalStorage.uid) ?? "";
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      bottomNavigationBar: Obx(
        () => cartData.cartList.isEmpty
            ? const SizedBox()
            : InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CartScreen()));
                },
                child: Container(
                  height: 50,
                  color: const Color(0xFF9c6d9d),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      const Text(
                        "Items",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        cartData.cartList.length.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
              ),
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      height: 180,
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
                                height: 180,
                                width: 140,
                                child: Image.network(
                                  data[index]['image'],
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
                                data[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${data[index]['price']} \u{20B9}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF9c6d9d)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Free Shipping",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (cartData.cartList.isEmpty) {
                                    cartData.cartList.add({
                                      "name": data[index]['name'],
                                      "itemId": data[index]['itemId'],
                                      "image": data[index]['image'],
                                      "price": data[index]['price'],
                                      "qty": 1,
                                    });
                                  } else {
                                    for (int i = 0;
                                        i < cartData.cartList.length;
                                        i++) {
                                      if (cartData.cartList[i]['itemId'] ==
                                          data[index]['itemId']) {
                                        return;
                                      }
                                    }
                                    cartData.cartList.add({
                                      "name": data[index]['name'],
                                      "itemId": data[index]['itemId'],
                                      "image": data[index]['image'],
                                      "price": data[index]['price'],
                                      "qty": 1,
                                    });
                                  }

                                  print(cartData.cartList);
                                },
                                child: Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF9c6d9d),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              isLoader = true;
                              setState(() {});
                              FirebaseFirestore firebaseFirestore =
                                  FirebaseFirestore.instance;
                              await firebaseFirestore
                                  .collection("users")
                                  .doc(userId)
                                  .collection("like")
                                  .doc(data[index]['likeId'])
                                  .delete();
                              isLoader = false;
                              setState(() {});
                              getData();
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF9c6d9d),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Image.asset(
                                  "assets/icon/bookmark.png",
                                  color: Colors.white,
                                  height: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
    );
  }
}
