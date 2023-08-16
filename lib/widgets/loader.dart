import 'package:flutter/material.dart';

void showIndiCator(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
              child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: const Center(
                child: CircularProgressIndicator(color: Color(0xFF9c6d9d))),
          )),
        );
      });
}
