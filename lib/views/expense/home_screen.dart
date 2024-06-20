import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'expense.dart';
import 'firestore_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: StreamBuilder<List<Expense>>(
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
            return Center(child: Text('No expenses added yet.'));
          }

          final expenses = snapshot.data!;
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              final formattedDate = DateFormat.yMMMd().format(expense.date);
              return ListTile(
                title: Text(expense.title),
                subtitle:
                    Text('\$${expense.amount.toString()} - $formattedDate'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _firestoreService.deleteExpense(expense.id);
                    debugPrint('Deleted expense with id: ${expense.id}');
                  },
                ),
                onTap: () => _showExpenseDialog(expense: expense),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExpenseDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showExpenseDialog({Expense? expense}) {
    final titleController = TextEditingController(text: expense?.title);
    final amountController =
        TextEditingController(text: expense?.amount.toString());
    final dateController = TextEditingController(
      text: expense != null
          ? DateFormat.yMMMd().format(expense.date)
          : DateFormat.yMMMd().format(DateTime.now()),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateController.text = DateFormat.yMMMd().format(pickedDate);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newExpense = Expense(
                  id: expense?.id ?? '',
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  date: DateFormat.yMMMd().parse(dateController.text),
                );

                if (expense == null) {
                  _firestoreService.addExpense(newExpense);
                  debugPrint('Added new expense: ${newExpense.title}');
                } else {
                  _firestoreService.updateExpense(newExpense);
                  debugPrint('Updated expense: ${newExpense.title}');
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
