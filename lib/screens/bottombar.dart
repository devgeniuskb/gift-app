import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/profile/profile_screen.dart';

import 'category/category_screen.dart';
import 'home/home_screen.dart';
import 'save/save_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  List body = [
    const HomeScreen(),
    const Category(),
    const SaveScreen(),
    const ProfileScreen(),
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
              "assets/icon/category.png",
              color: Colors.white,
              height: 20,
            ),
            Image.asset(
              "assets/icon/bookmark.png",
              color: Colors.white,
              height: 20,
            ),
            Image.asset(
              "assets/icon/user.png",
              color: Colors.white,
              height: 20,
            ),
          ]),
    );
  }
}
