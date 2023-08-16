import 'package:flutter/material.dart';

Widget buttonView(
    {BuildContext? context,
    Function()? onTap,
    @required String? title,
    double? height,
    double? width,
    Color? backgroundColor,
    double? borderRadius,
    Color? titleColor,
    Color? borderColor,
    double? titleFontSize,
    double? horizontalPadding,
    double? verticalPadding}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 16, vertical: verticalPadding ?? 8),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF9c6d9d),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        alignment: Alignment.center,
        child: Text(
          "$title",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}