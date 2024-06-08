import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/utils/custom_dialog.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/dashboard/data/dropdown_item.dart';
import 'package:expense_tracker/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'curved_nav_test.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
        builder: (context) {
          return dashboardController.page[dashboardController.bottomNavIndex];
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        buttonLabelColor: ColorConstants.kWhiteColor,
        onTap: (value) {
          dashboardController.changeIndex(value);
        },
        buttonBackgroundColor: Colors.grey.shade600,
        backgroundColor: Colors.grey.shade600,
        items: [
          CurvedNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: 'home'.tr,
          ),
          CurvedNavigationBarItem(
            icon: const Icon(Icons.bar_chart_rounded),
            label: 'report'.tr,
          ),
          CurvedNavigationBarItem(
            icon: const Icon(Icons.settings_rounded),
            label: 'setting'.tr,
          ),
        ],
      ),
      floatingActionButton: GetBuilder<DashboardController>(
        builder: (context) {
          return Visibility(
            visible: dashboardController.bottomNavIndex == 0,
            child: FloatingActionButton(
              backgroundColor: ColorConstants.kYellowColor,
              child: const Icon(
                Icons.add,
                size: AppSizes.s28,
              ),
              onPressed: () {
                Get.dialog(
                  transitionCurve: const Cubic(100, 100, 100, 300),
                  barrierDismissible: false,
                  transitionDuration: const Duration(milliseconds: 500),
                  GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (controller) {
                      return CustomDialog(
                        title: 'new expense'.tr,
                        children: Column(
                          children: [
                            const SizedBox(height: AppSizes.s10),
                            DropdownMenu<ExpensionType>(
                              // initialSelection: ColorLabel.green,
                              controller: dashboardController.colorController,
                              requestFocusOnTap: true,
                              label: Text(
                                'type'.tr,
                                style: TextStyleConstant.kTitleSmallTextStyle,
                              ),
                              onSelected: (ExpensionType? type) {
                                dashboardController.onSelectColor(type);
                              },
                              dropdownMenuEntries: ExpensionType.values
                                  .map<DropdownMenuEntry<ExpensionType>>(
                                      (ExpensionType type) {
                                return DropdownMenuEntry<ExpensionType>(
                                  value: type,
                                  label: type.label.tr,
                                  // enabled: color.label != 'Grey',
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor: type.color,
                                    iconColor: ColorConstants.kWhiteColor,
                                  ),
                                );
                              }).toList(),
                            ),
                            TextField(
                              style: TextStyleConstant.kTitleSmallTextStyle,
                              keyboardType: TextInputType.number,
                              controller: controller.textController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.p18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: ColorConstants.kWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.p10),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        ColorConstants.kGreenColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (controller
                                          .textController.text.isEmpty) {
                                        Get.snackbar('Add New Expense',
                                            'Please fill the box');
                                      }
                                      controller.textController.text.isNotEmpty
                                          ? controller.addNewItemToList(
                                              newItem: controller
                                                  .textController.text)
                                          : ();
                                      controller.textController.clear();
                                    },
                                    child: Text(
                                      'add'.tr,
                                      style: TextStyleConstant
                                          .kTitleSmallTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSizes.p10),
                                Expanded(
                                  child: FilledButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        ColorConstants.kRedColor,
                                      ),
                                    ),
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'close'.tr,
                                      style: TextStyleConstant
                                          .kTitleSmallTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
