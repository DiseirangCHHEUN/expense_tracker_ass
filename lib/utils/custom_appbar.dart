import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_constant.dart';

AppBar buildAppBar(
    {required String title, required Widget leading, required Widget actions}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title.tr,
      // ignore: prefer_const_constructors
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorConstants.kYellowColor,
      ),
    ),
    leading: leading,
    actions: [
      actions,
    ],
  );
}
