import 'package:flutter/material.dart';
import 'package:gift_app/widgets/button_view.dart';
import 'package:gift_app/widgets/dialog_view.dart';

void alertDialogView({
  required BuildContext context,
  required String title,
  required String contet,
  required Function() yesPress,
  required Function() noPress,
}) {
  dialogBoxView(context,
      widget: AlertDialog(
        title: Text(
          title,
          
        ),
        content: Text(
          contet,
        ),
        actions: [
          buttonView(
              title: "Yes",
              width: 80,
              height: 35,
              onTap: yesPress,
              horizontalPadding: 0),
          buttonView(
              title: "No",
              width: 80,
              height: 35,
              onTap: noPress,
              horizontalPadding: 0),
        ],
      ));
}
