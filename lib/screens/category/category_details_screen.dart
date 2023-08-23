import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/controller/cart_data.dart';
import 'package:gift_app/screens/cart/cart_screen.dart';
import 'package:lottie/lottie.dart';

class CategoryDetails extends StatefulWidget {
  final String id;
  final String name;
  const CategoryDetails({super.key, required this.id, required this.name});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CartData cartData = Get.put(CartData());
  Future<bool> isLike(String itemId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("like")
        .get();
    var like = querySnapshot.docs;
    for (int i = 0; i < like.length; i++) {
      if (itemId == like[i]['itemId']) {
        return true;
      }
    }
    return false;
  }

  String userId = "";
  bool isLoader = false;
  List data = [];
  void getData() async {
    data.clear();
    isLoader = true;
    setState(() {});
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot res = await firebaseFirestore
        .collection("category")
        .doc(widget.id)
        .collection("items")
        .get();
    var copy = res.docs;
    for (int i = 0; i < copy.length; i++) {
      data.add({"data": copy[i], "isLike": await isLike(copy[i]['id'])});
    }
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
        title: Text(widget.name),
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
                                  data[index]['data']['image'],
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  data[index]['data']['name'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${data[index]['data']['price']} \u{20B9}",
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
                                        "name": data[index]['data']['name'],
                                        "itemId": data[index]['data']['id'],
                                        "image": data[index]['data']['image'],
                                        "price": data[index]['data']['price'],
                                        "qty": 1,
                                      });
                                    } else {
                                      for (int i = 0;
                                          i < cartData.cartList.length;
                                          i++) {
                                        if (cartData.cartList[i]['itemId'] ==
                                            data[index]['data']['id']) {
                                          return;
                                        }
                                      }
                                      cartData.cartList.add({
                                        "name": data[index]['data']['name'],
                                        "itemId": data[index]['data']['id'],
                                        "image": data[index]['data']['image'],
                                        "price": data[index]['data']['price'],
                                        "qty": 1,
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF9c6d9d),
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              isLoader = true;
                              setState(() {});
                              FirebaseFirestore firebaseFirestore =
                                  FirebaseFirestore.instance;
                              QuerySnapshot querySnapshot =
                                  await firebaseFirestore
                                      .collection("users")
                                      .doc(userId)
                                      .collection("like")
                                      .get();
                              var res = querySnapshot.docs;
                              if (data[index]['isLike']) {
                                for (int i = 0; i < res.length; i++) {
                                  if (res[i]['itemId'] ==
                                      data[index]['data']['id']) {
                                    await firebaseFirestore
                                        .collection("users")
                                        .doc(userId)
                                        .collection("like")
                                        .doc(res[i]['likeId'])
                                        .delete();
                                    break;
                                  }
                                }
                              } else {
                                String likeId =
                                    "like-${DateTime.now().millisecondsSinceEpoch.toString()}";
                                await firebaseFirestore
                                    .collection("users")
                                    .doc(userId)
                                    .collection("like")
                                    .doc(likeId)
                                    .set({
                                  "itemId": data[index]['data']['id'],
                                  "likeId": likeId,
                                  "image": data[index]['data']['image'],
                                  "name": data[index]['data']['name'],
                                  "price": data[index]['data']['price']
                                });
                              }
                              isLoader = false;
                              setState(() {});
                              getData();
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Colors.black12,
                                        blurRadius: 3,
                                        spreadRadius: 1)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Image.asset(
                                  "assets/icon/bookmark.png",
                                  color: data[index]['isLike']
                                      ? const Color(0xFF9c6d9d)
                                      : Colors.black,
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
