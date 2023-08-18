import 'package:flutter/material.dart';
import 'package:gift_app/screens/bottombar.dart';
import 'package:lottie/lottie.dart';

class OrderComplete extends StatefulWidget {
  const OrderComplete({ Key? key }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderCompleteState createState() => _OrderCompleteState();
}

class _OrderCompleteState extends State<OrderComplete> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const BottomBar()), (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/image/order-confirm.json"),
      ),
    );
  }
}