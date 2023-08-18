import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/order/cancel_order.dart';
import 'package:gift_app/screens/admin/order/confirm_order.dart';
import 'package:gift_app/screens/admin/order/diliver_order.dart';
import 'package:gift_app/screens/admin/order/pennding_order.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminOrderScreenState createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        backgroundColor: const Color(0xFF9c6d9d),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF9c6d9d),
            child: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(child: Text("Pending")),
                  Tab(child: Text("Confirm")),
                  Tab(child: Text("Diliver")),
                  Tab(child: Text("Cancel")),
                ]),
          ),
          Expanded(child: TabBarView(
            controller: tabController,
            children: const [
              PenddingOrder(),
              ConfirmOrder(),
              DiliverOrder(),
              CancelOrder()
            ]))
        ],
      ),
    );
  }
}
