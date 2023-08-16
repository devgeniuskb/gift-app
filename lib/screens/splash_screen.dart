import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/screens/admin/admin_bottombar.dart';
import 'package:gift_app/screens/auth/login_screen.dart';
import 'package:gift_app/screens/bottombar.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (LocalStorage.instance.getBool(LocalStorage.isAdmin) == true) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AdminBottomBar()),
          (route) => false,
        );
      } else if (LocalStorage.instance.getBool(LocalStorage.isLogin) == true) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomBar()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LogInScreen()),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Lottie.asset("assets/image/splash.json"),
    ));
  }
}
