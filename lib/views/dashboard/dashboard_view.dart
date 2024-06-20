import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/dashboard/models/dashboard_model.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'curved_nav_test.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final FirestoreService _firestoreService = FirestoreService();
  late Stream<List<Expense>> _expenseStream;

  @override
  void initState() {
    super.initState();
    _expenseStream = _firestoreService.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
        builder: (context) {
          return dashboardController.page[dashboardController.bottomNavIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<SettingController>(
        builder: (controller) {
          return CurvedNavigationBar(
            onTap: (value) {
              dashboardController.changeIndex(value);
            },
            animationDuration: const Duration(milliseconds: 500),
            buttonLabelColor: controller.isDarkMode
                ? ColorConstants.kWhiteColor
                : Colors.black,
            buttonBackgroundColor: controller.isDarkMode
                ? Colors.grey.shade600
                : ColorConstants.kWhiteColor,
            backgroundColor: controller.isDarkMode
                ? Colors.grey.shade600
                : Colors.transparent,
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExpenseDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showExpenseDialog({Expense? expense}) {
    final titleController = TextEditingController(text: expense?.title);
    final des = TextEditingController(text: expense?.des);
    final amountController =
        TextEditingController(text: expense?.amount.toString());
    final dateController = TextEditingController(
      text: expense != null
          ? DateFormat.yMMMd().format(expense.date)
          : DateFormat.yMMMd().format(DateTime.now()),
    );
    String type = expense?.type ?? 'expense'; // Default to 'expense' if null

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(expense == null ? 'Add Transaction' : 'Edit Transaction'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    suffixIconColor: ColorConstants.kRedColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        strokeAlign: AppSizes.p10,
                        width: 1,
                        style: BorderStyle.solid,
                        color: ColorConstants.kYellowColor.withOpacity(.5),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.s10),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: ColorConstants.kYellowColor.withOpacity(.3),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.s10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    suffixIconColor: ColorConstants.kRedColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        strokeAlign: AppSizes.p10,
                        width: 1,
                        style: BorderStyle.solid,
                        color: ColorConstants.kYellowColor.withOpacity(.5),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.s10),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: ColorConstants.kYellowColor.withOpacity(.3),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.s10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      dateController.text =
                          DateFormat.yMMMd().format(pickedDate);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: type,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      type = newValue;
                    }
                  },
                  items: <String>['expense', 'income']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.capitalizeFirst ?? value),
                      );
                    },
                  ).toList(),
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: des,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    suffixIconColor: ColorConstants.kRedColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        strokeAlign: AppSizes.p10,
                        width: 1,
                        style: BorderStyle.solid,
                        color: ColorConstants.kYellowColor.withOpacity(.5),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.s10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newExpense = Expense(
                  id: expense?.id ?? '',
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  date: DateFormat.yMMMd().parse(dateController.text),
                  category: expense?.category ?? 'Uncategorized',
                  type: type,
                );

                if (expense == null) {
                  _firestoreService.addExpense(newExpense);
                  debugPrint('Added new transaction: ${newExpense.title}');
                } else {
                  _firestoreService.updateExpense(newExpense);
                  debugPrint('Updated transaction: ${newExpense.title}');
                }
                Navigator.of(context).pop();
              },
              child: Text(expense == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
