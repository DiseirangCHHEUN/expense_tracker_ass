import 'package:expense_tracker/constants/style_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'transaction'.tr,
          style: TextStyleConstant.kYellowTitleTextStyle,
        ),
      ),
      body: buildHomeBody(),
    );
  }
}
