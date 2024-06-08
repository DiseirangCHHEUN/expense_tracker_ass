import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/home_view.dart';
import '../../report/report_view.dart';
import '../../setting/setting_view.dart';
import '../data/dropdown_item.dart';

class DashboardController extends GetxController {
  int bottomNavIndex = 0;

  final page = [
    const HomeView(),
    const ReportView(),
    SettingView(),
  ];

  changeIndex(int index) {
    bottomNavIndex = index;
    update();
  }

  final TextEditingController colorController = TextEditingController();
  ExpensionType? selectedColor;
  onSelectColor(ExpensionType? color) {
    selectedColor = color;
    update();
  }
}
