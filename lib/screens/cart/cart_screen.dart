import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/controller/cart_data.dart';
import 'package:gift_app/screens/cart/order_complete.dart';
import 'package:gift_app/widgets/loader.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  CartData cartData = Get.put(CartData());
  void countBill() async {
    cartData.totalAmmount.value = 0;
    cartData.totalItem.value = 0;
    for (int i = 0; i < cartData.cartList.length; i++) {
      num qty = cartData.cartList[i]['qty'];
      cartData.totalItem.value += qty.toInt();
      num totalAmmount = cartData.cartList[i]['qty'] *
          int.parse(cartData.cartList[i]['price']);
      cartData.totalAmmount += totalAmmount.toInt();
    }
  }

  void addOrder() async {
    showIndiCator(context);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String orderId =
        "orderid-${DateTime.now().millisecondsSinceEpoch.toString()}";
    String firstName =
        LocalStorage.instance.getString(LocalStorage.firstName) ?? "";
    String lastName =
        LocalStorage.instance.getString(LocalStorage.lastName) ?? "";
    String email = LocalStorage.instance.getString(LocalStorage.email) ?? "";
    String uid = LocalStorage.instance.getString(LocalStorage.uid) ?? "";
    String mobile = LocalStorage.instance.getString(LocalStorage.mobile) ?? "";
    String userImage =
        LocalStorage.instance.getString(LocalStorage.image) ?? "";
    await firebaseFirestore.collection("orders").doc(orderId).set({
      "id": orderId,
      "firstName": firstName,
      "lastName": lastName,
      "uid": uid,
      "mobile": mobile,
      "userImage": userImage,
      "email": email,
      "status": "pending",
      "items": cartData.cartList,
      "totalItems": cartData.totalItem.value,
      "totalBill": cartData.totalAmmount.value
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const OrderComplete()),
        (route) => false);
  }

  @override
  void initState() {
    countBill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: const Color(0xFF9c6d9d),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Obx(
              () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartData.cartList.length,
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
                                  cartData.cartList[index]['image'],
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
                                cartData.cartList[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${cartData.cartList[index]['price']} \u{20B9}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF9c6d9d)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (cartData.cartList[index]['qty'] ==
                                          1) {
                                        return;
                                      }
                                      cartData.cartList[index]['qty']--;
                                      countBill();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF9c6d9d),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Obx(
                                    () => Text(
                                        "${cartData.cartList[index]['qty']}"),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cartData.cartList[index]['qty']++;
                                      countBill();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF9c6d9d),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "+",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
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
                      Obx(
                        () => Text("${cartData.totalItem}"),
                      )
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
                      Obx(
                        () => Text("${cartData.totalAmmount} \u{20B9}"),
                      )
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
                  InkWell(
                    onTap: () {
                      if (globalKey.currentState!.validate()) {
                        addOrder();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF9c6d9d),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text("Add Order",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
