import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/dashboard/models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirestoreService _firestoreService = FirestoreService();
  late Stream<List<Expense>> _expenseStream;
  DateTime _selectedDate = DateTime.now();
  final List<String> _dateOptions = ['Yesterday', 'Today', 'Tomorrow'];
  String _selectedDateOption = 'Today';
  double sum = 0.0;

  @override
  void initState() {
    super.initState();
    _expenseStream = _firestoreService.getExpenses();
  }

  void _updateSelectedDate(String option) {
    setState(() {
      _selectedDateOption = option;
      if (option == 'Yesterday') {
        _selectedDate = DateTime.now().subtract(Duration(days: 1));
      } else if (option == 'Today') {
        _selectedDate = DateTime.now();
      } else if (option == 'Tomorrow') {
        _selectedDate = DateTime.now().add(Duration(days: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'transaction'.tr,
        leading: const SizedBox(),
        actions: const SizedBox(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedDateOption,
                    items: _dateOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option.tr),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _updateSelectedDate(newValue);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Expense>>(
                    stream: _expenseStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        debugPrint('StreamBuilder error: ${snapshot.error}');
                        return Center(child: Text('An error occurred!'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text('No transactions added yet.'));
                      }

                      final expenses = snapshot.data!;
                      final filteredExpenses = expenses.where((expense) {
                        return DateFormat.yMMMd().format(expense.date) ==
                            DateFormat.yMMMd().format(_selectedDate);
                      }).toList();

                      final totalAmount = filteredExpenses.fold(
                          0.0, (sum, item) => sum + item.amount);
                      return Text(
                        'Total: \$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Expense>>(
              stream: _expenseStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  debugPrint('StreamBuilder error: ${snapshot.error}');
                  return Center(child: Text('An error occurred!'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No transactions added yet.'));
                }

                final expenses = snapshot.data!;
                final filteredExpenses = expenses.where((expense) {
                  return DateFormat.yMMMd().format(expense.date) ==
                      DateFormat.yMMMd().format(_selectedDate);
                }).toList();

                if (filteredExpenses.isEmpty) {
                  return Center(
                      child: Text('No transactions for selected date.'));
                }

                return ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];
                    final formattedDate =
                        DateFormat.yMMMd().format(expense.date);
                    final isExpense = expense.type.toLowerCase() == 'expense';
                    final amountColor = isExpense ? Colors.red : Colors.green;

                    return Container(
                      color: Color.fromARGB(72, 0, 0, 0),
                      alignment: Alignment.center,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: AppSizes.m10),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.p5,
                        horizontal: AppSizes.p16,
                      ),
                      child: ListTile(
                        title: Text(
                          expense.title,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        subtitle: Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 212, 212, 212),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${expense.amount.toString()} \$',
                              style: TextStyle(
                                fontSize: 16,
                                color: amountColor,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _firestoreService.deleteExpense(expense.id);
                                debugPrint(
                                    'Deleted transaction with id: ${expense.id}');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
