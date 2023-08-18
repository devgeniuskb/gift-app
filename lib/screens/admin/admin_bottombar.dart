import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/category/admin_home.dart';
import 'package:gift_app/screens/admin/order/admin_order.dart';

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminBottomBarState createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int index = 0;
  List body = [
    const AdminHomeScreen(),
    const AdminOrderScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[index],
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.white,
          color: const Color(0xFF9c6d9d),
          items: [
            Image.asset(
              "assets/icon/home.png",
              color: Colors.white,
              height: 20,
            ),
            Image.asset(
              "assets/icon/shopping-bag.png",
              color: Colors.white,
              height: 20,
            ),
          ]),
    );
  }
}
