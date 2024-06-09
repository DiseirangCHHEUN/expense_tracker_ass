import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/home_body.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: 'transaction',
          leading: const SizedBox(),
          actions: const SizedBox()),
      body: buildHomeBody(),
    );
  }
}
